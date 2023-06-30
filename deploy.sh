docker build -t dhdepna/multi-client:latest -t dhdepna/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dhdepna/multi-server:latest -t dhdepna/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dhdepna/multi-worker:latest -t dhdepna/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dhdepna/multi-client:latest
docker push dhdepna/multi-server:latest
docker push dhdepna/multi-worker:latest
docker push dhdepna/multi-client:$SHA
docker push dhdepna/multi-server:$SHA
docker push dhdepna/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=dhdepna/multi-server:$SHA
kubectl set image deployments/client-deployment client=dhdepna/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dhdepna/multi-worker:$SHA
