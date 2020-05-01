docker build -t jsilve12/multi-client:latest -t jsilve12/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jsilve12/multi-server:latest -t jsilve12/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jsilve12/multi-worker:latest -t jsilve12/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jsilve12/multi-client:latest
docker push jsilve12/multi-server:latest
docker push jsilve12/multi-worker:latest
docker push jsilve12/multi-client:$SHA
docker push jsilve12/multi-server:$SHA
docker push jsilve12/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jsilve12/multi-server:$SHA
kubectl set image deployments/client-deployment client=jsilve12/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jsilve12/multi-worker:$SHA
