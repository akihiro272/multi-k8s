docker build -t akihr/multi-client:latest -t akihr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t akihr/multi-server:latest -t akihr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t akihr/multi-worker:latest -t akihr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push akihr/multi-client:latest
docker push akihr/multi-server:latest
docker push akihr/multi-worker:latest

docker push akihr/multi-client:$SHA
docker push akihr/multi-server:$SHA
docker push akihr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=akihr/multi-server:$SHA
kubectl set image deployments/client-deployment client=akihr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=akihr/multi-worker:$SHA