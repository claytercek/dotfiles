# dotfiles

Managed with [chezmoi](https://chezmoi.io). One prompt at `chezmoi init`
("Is this machine a headless server") splits machines into two classes:

- **Workstations** — full config, secrets pulled from 1Password at apply
  time, shared git signing key.
- **Servers** — same configs, no secret access, per-host git signing key
  generated on first apply. Commit signing is enforced everywhere.

1Password is the root of trust: the GitHub SSH key (which clones this
private repo) and the git signing key both live there. That fixes the
bootstrap order — on a workstation, 1Password always comes first.
Nothing is hand-edited: 1Password's own setup flow writes the SSH agent
config, and chezmoi renders everything else.

## New workstation (macOS)

```sh
# 1. Homebrew (also installs git via the Xcode CLT)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. chezmoi + 1Password
brew install chezmoi
brew install --cask 1password 1password-cli
```

3. Open 1Password and sign in (Secret Key from another device or the
   Emergency Kit). In Settings → Developer:
   - Enable **SSH agent** — accept the **Edit Automatically** prompt,
     which writes the `IdentityAgent` snippet to `~/.ssh/config` itself.
   - Enable **CLI integration** (biometric unlock for `op`).

4. Clone and apply in one shot — the clone authenticates through the
   1Password agent, and the apply renders the signing key via `op`
   (expect one biometric prompt):

   ```sh
   chezmoi init --apply --ssh claytercek
   ```

   Answer **no** to the server prompt.

Linux workstations are the same shape: install 1Password desktop + CLI
for your distro, enable the SSH agent and CLI integration in the app,
then run step 4.

On Windows, install `AgileBits.1Password` and `AgileBits.1Password.CLI`
via winget, enable the SSH agent (the app walks through disabling the
built-in ssh-agent service and serves the default OpenSSH pipe), then
run step 4.

## New server

Servers never get 1Password. Repo access for the initial clone is
borrowed from your workstation via SSH agent forwarding:

```sh
ssh -A user@host          # or set ForwardAgent yes in the host's entry
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --ssh claytercek
```

Answer **yes** to the server prompt. First apply generates a per-host
signing key at `~/.ssh/signing` and prints its public key. Then:

1. Add it on GitHub as a **Signing Key** (not an authentication key).
2. Append it to `home/private_dot_ssh/allowed_signers` in this repo.

Later `chezmoi update` runs also need repo access — run them while
SSHed in with forwarding, or add a read-only deploy key for this repo
if a server must pull unattended.

## Known limitations

- `~/.ssh/config` is deliberately unmanaged: 1Password owns the agent
  snippet and per-machine host entries stay local.
- The 1Password sign-in and the two Developer toggles are GUI steps
  with no supported automation.
