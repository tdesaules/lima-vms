# LIMA VIRTUAL MACHINES

docker compose up
docker compose down --volumes

docker exec k0s-controller-1 k0s kubectl get controlnodes,etcdmember,nodes,pods -A -o wide
docker compose ps
