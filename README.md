# Image Object Detection Web Service within a Containerised Environment in Clouds

## install Docker and Kubernetes

all the commends used to install Doker and kubernetes are in [k8s.sh](https://github.com/Jiayulllll/image_detect-kubernetes/blob/master/%23%20k8s.sh)

## Kubernetes deployment and service confgurations

-[myweb-deployment.yml](https://github.com/Jiayulllll/image_detect-kubernetes/blob/master/myweb-deployment.yml)

<img width="1266" alt="food website" src="https://github.com/Jiayulllll/image_detect-kubernetes/blob/master/picture/deployment.png">

-[myweb-service.yml](https://github.com/Jiayulllll/image_detect-kubernetes/blob/master/myweb-service.yml)

<img width="1266" alt="food website" src="https://github.com/Jiayulllll/image_detect-kubernetes/blob/master/picture/service.png">

## client side end point command

### usage format

python iWebLens_client.py <input folder name> <URL> <num_threads>
