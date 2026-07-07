import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { createBashTool } from "@earendil-works/pi-coding-agent";

const GIT_ENV = {
  GIT_CONFIG_COUNT: "2",
  GIT_CONFIG_KEY_0: "user.signingkey",
  GIT_CONFIG_KEY_1: "gpg.ssh.program",
  GIT_CONFIG_VALUE_0: "/Users/clay/.ssh/agent_signing",
  GIT_CONFIG_VALUE_1: "/Users/clay/.ssh/sign-noagent",
};

export default function (pi: ExtensionAPI) {
  const cwd = process.cwd();
  const bashTool = createBashTool(cwd, {
    spawnHook: ({ command, cwd, env }) => ({
      command,
      cwd,
      env: { ...env, ...GIT_ENV },
    }),
  });

  pi.registerTool({
    ...bashTool,
    execute: async (id, params, signal, onUpdate, _ctx) =>
      bashTool.execute(id, params, signal, onUpdate),
  });
}