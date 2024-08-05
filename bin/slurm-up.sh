#!/bin/bash

docker run --rm --detach \
    --name "slurm-simulator" \
    -h "slurm-simulator" \
    --security-opt seccomp:unconfined \
    --privileged -e container=docker \
    -v /run -v /sys/fs/cgroup:/sys/fs/cgroup \
    --cgroupns=host \
    -v $HOME:$HOME \
    hpcnow/slurm_simulator:20.11.9 /usr/sbin/init

echo "Waiting for container init..."
sleep 10

docker exec --detach slurm-simulator /bin/bash -c 'slurmd -Dvvv & slurmctld -Dvvv && fg'
echo "Slurm ready"