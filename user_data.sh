#!/bin/bash
# To be run as user-data script for AWS / Azure instances to setup my envrionment (runs as root)
username=maur0x

dnf -e 0 -q -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf -e 0 -q -y install git iperf3 podman wget jq bind-utils make zsh net-tools

[[ ! -x /usr/local/bin/yq ]] && wget -q https://github.com/mikefarah/yq/releases/download/v4.27.5/yq_linux_amd64.tar.gz -O - | tar xvzf - -C /usr/local/bin --strip-components=0 ./yq_linux_amd64 && mv /usr/local/bin/yq_linux_amd64 /usr/local/bin/yq
#[[ ! -x /usr/local/bin/oc ]] && wget -q https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz && tar xzf openshift-client-linux.tar.gz kubectl oc && rm openshift-client-linux.tar.gz && mv oc kubectl /usr/local/bin/
#[[ ! -x /usr/local/bin/helm ]] && curl -sSL4 https://mirror.openshift.com/pub/openshift-v4/clients/helm/latest/helm-linux-amd64 -o /usr/local/bin/helm && chmod +x /usr/local/bin/helm

if [[ $EUID -eq 0 ]]; then
  cd /root
  git clone --depth 1 https://github.com/mauroseb/dotfiles.git dotfiles
  cd dotfiles ; make all; cd
  usermod -s `which zsh` root
fi

sudo -H -u ${username} bash <<_ASUSER_
git clone --depth 1 https://github.com/mauroseb/dotfiles.git /home/${username}/dotfiles
cd /home/${username}/dotfiles ; make all; cd
git clone --depth 1 https://github.com/asdf-vm/asdf.git /home/${username}/.asdf
exit
_ASUSER_

usermod -s `which zsh` ${username}
