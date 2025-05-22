# LIMA VIRTUAL MACHINES

## Basics Lima Commands

### Sorim Audio

```bash
limactl create --tty=false sorim-audio.yaml
limactl start sorim-audio
limactl shell sorim-audio
limactl stop sorim-audio
limactl delete sorim-audio
```

### K0s

```bash
limactl create --tty=false k0s.yaml
limactl start k0s
limactl shell k0s
limactl stop k0s
limactl delete k0s
```

## Other

limactl create --tty=false sorim-audio.yaml
limactl list
limactl shell sorim-audio

docker compose up
docker compose down --volumes
docker compose ps

docker exec k0s-controller-1 k0s kubectl get controlnodes,nodes,services,pods -A -o wide

docker exec k0s-controller-1 k0s kubeconfig admin > ~/.kube/k0s.config
export KUBECONFIG=~/.kube/k0s.config

docker exec k0s-worker-1 curl --silent http://10.104.121.80:8000/ping | jq -c .

docker exec k0s-worker-1 mount bpffs -t bpf /sys/fs/bpf
docker exec k0s-worker-1 mount --make-shared /sys/fs/bpf

docker exec k0s-worker-1 umount /run/cilium/cgroupv2
docker exec k0s-worker-1 mount -t cgroup2 none /run/cilium/cgroupv2
docker exec k0s-worker-1 mount --make-shared /run/cilium/cgroupv2

docker exec k0s-worker-1 mount --make-shared /

cilium install --version 1.17.3 --set k8sServiceHost=172.18.0.2 --set k8sServicePort=6443 --set kubeProxyReplacement=true
cilium hubble enable
cilium status --wait
cilium connectivity test