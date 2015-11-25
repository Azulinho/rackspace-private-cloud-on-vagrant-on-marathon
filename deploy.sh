#!/bin/bash

export HOME=/root

git clone --recursive https://github.com/wbentley15/vagrant-rpcv901_deploy.git
git clone --recursive https://github.com/wbentley15/vagrant-rpcv901.git

cd vagrant-rpcv901
vagrant up
cd ..
cd vagrant-rpcv901_deploy

vagrant up

vagrant ssh deploy1 -- sudo su -c 'cd /opt/ansible-lxc-rpc/rpc_deployment/ ; ansible-playbook -e @/etc/rpc_deploy/user_variables.yml playbooks/setup/host-setup.yml'

vagrant ssh deploy1 -- sudo su -c 'cd /opt/ansible-lxc-rpc/rpc_deployment/ ;ansible-playbook -e @/etc/rpc_deploy/user_variables.yml playbooks/infrastructure/haproxy-install.yml'

vagrant ssh deploy1 -- sudo su -c 'cd /opt/ansible-lxc-rpc/rpc_deployment/; ansible-playbook -e @/etc/rpc_deploy/user_variables.yml playbooks/infrastructure/infrastructure-setup.yml'

vagrant ssh deploy1 -- sudo su -c 'cd /opt/ansible-lxc-rpc/rpc_deployment/ ; ansible-playbook -e @/etc/rpc_deploy/user_variables.yml playbooks/openstack/openstack-setup.yml'