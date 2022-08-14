IF [%JUSTTERMINATE%] == [OKAY] (
    SET JUSTTERMINATE=
    docker build -t ansible-rhel .
    powershell -command "docker run --net=host --rm -e ANSIBLE_FORCE_COLOR=true -v %cd%:/repo -w /repo -i vagrant-ansible /bin/bash -c 'chmod 600 $(find . | grep -i private_key) && ansible-playbook %*'
) ELSE (
    SET JUSTTERMINATE=OKAY
    CALL %0 %* <NUL
)
