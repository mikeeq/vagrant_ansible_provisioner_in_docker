FROM python:3.10-slim

RUN apt-get update \
    && apt-get install -y \
      openssh-client \
      iputils-ping \
      curl \
      iproute2 \
      vim \
      sshpass \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# https://pypi.org/project/ansible/
# https://pypi.org/project/pywinrm/
RUN pip3 install --no-cache-dir ansible~=10.0.1 pywinrm~=0.4.3

RUN echo "Host *\n  PubkeyAcceptedKeyTypes +ssh-rsa\n  HostKeyAlgorithms +ssh-rsa\n  UserKnownHostsFile /dev/null\n  StrictHostKeyChecking no" > /etc/ssh/ssh_config.d/vagrant.conf

CMD ansible-playbook
