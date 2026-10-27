FROM ubuntu:24.04
LABEL maintainer="Kent Hsieh <https://github.com/kenthsieh/ubuntu-sshd.git>"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        openssh-server lrzsz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Host keys are generated per container at startup, not baked into the image.
RUN rm -f /etc/ssh/ssh_host_* && \
    mkdir -p /run/sshd /root/.ssh && \
    chmod 700 /root/.ssh

# Key-based root login by default; password login only if ROOT_PASSWORD is set at runtime.
RUN printf '%s\n' \
        'PermitRootLogin prohibit-password' \
        'PasswordAuthentication no' \
        'KbdInteractiveAuthentication no' \
        > /etc/ssh/sshd_config.d/10-container.conf

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]
