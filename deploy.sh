docker build -t mbull93/k8s-client:latest -t mbull93/k8s-client:$SHA -f ./client/Dockerfile ./client 
docker build -t mbull93/k8s-server:latest -t mbull93/k8s-server:$SHA -f ./server/Dockerfile ./server 
docker build -t mbull93/k8s-worker:latest -t mbull93/k8s-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push mbull93/k8s-client:latest
docker push mbull93/k8s-server:latest
docker push mbull93/k8s-worker:latest

docker push mbull93/k8s-client:$SHA
docker push mbull93/k8s-server:$SHA
docker push mbull93/k8s-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mbull93/k8s-server:$SHA
kubectl set image deployments/client-deployment client=mbull93/k8s-client:$SHA
kubectl set image deployments/worker-deployment worker=mbull93/k8s-worker:$SHA