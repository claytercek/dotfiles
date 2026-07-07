@echo off
set "SSH_AUTH_SOCK=\\.\pipe\ssh-noagent"
"C:\Program Files\OpenSSH\ssh-keygen.exe" %*