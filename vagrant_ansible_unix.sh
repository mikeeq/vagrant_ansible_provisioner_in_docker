set -x

docker build -t vagrant-ansible .

docker run --net=host --rm -e ANSIBLE_FORCE_COLOR=true -v $PWD:/repo -w /repo -i vagrant-ansible /bin/bash -c "ansible-playbook $*"
