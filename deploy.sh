docker build -t rdthomashoutekier/multi-client:latest -t rdthomashoutekier/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rdthomashoutekier/multi-server:latest -t rdthomashoutekier/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rdthomashoutekier/multi-worker:latest -t rdthomashoutekier/multi-worker:$SHA -f ./worker/Dockerfile ./server

docker push rdthomashoutekier/multi-client:latest
docker push rdthomashoutekier/multi-server:latest
docker push rdthomashoutekier/multi-worker:latest
docker push rdthomashoutekier/multi-client:$SHA
docker push rdthomashoutekier/multi-server:$SHA
docker push rdthomashoutekier/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rdthomashoutekier/multi-server:$SHA
kubectl set image deployments/client-deployment client=rdthomashoutekier/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rdthomashoutekier/multi-worker:$SHA
