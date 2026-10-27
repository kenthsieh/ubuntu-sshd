# ubuntu-sshd

Ubuntu 24.04 image running OpenSSH server (with `lrzsz`).

## Build

```sh
docker build -t ubuntu-sshd .
```

## Run

Key-based login (recommended):

```sh
docker run -d -p 2222:22 -e SSH_PUBLIC_KEY="$(cat ~/.ssh/id_ed25519.pub)" ubuntu-sshd
ssh -p 2222 root@localhost
```

Password login (only enabled when `ROOT_PASSWORD` is set):

```sh
docker run -d -p 2222:22 -e ROOT_PASSWORD=change-me ubuntu-sshd
```

Host keys are generated when each container starts, so containers never share them.
