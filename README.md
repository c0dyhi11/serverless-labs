# Serverless Labs
## Step 1 
Clone this repo:
```bash 
git clone https://github.com/c0dyhi11/serverless-labs
cd serverless-labs
```

## Step 2
Setup Helm
```bash
# Install Tiller into your cluster
helm init
# List the pods in the "kube-system" namespace and look for the tiller pod
kubectl -n kube-system get pods
```
Make sure the tiller pod is "Running"
## Step 3
Install Fission

```bash
# Install Fission into your cluster in the fission namespace using Helm
helm install --name fission --namespace fission --set serviceType=NodePort,routerServiceType=NodePort https://github.com/fission/fission/releases/download/1.2.1/fission-all-1.2.1.tgz
# Download the fission CLI tool and put it in you path
curl -Lo ../fission https://github.com/fission/fission/releases/download/1.2.1/fission-cli-linux && chmod +x ../fission && sudo mv ../fission /usr/local/bin/
# Create generic Ingress rule for Fission
kubectl -n fission apply -f setup/ingress.yaml
# List all of the pods in the fission namespace
kubectl -n fission get pods
```
Make sure the fission router and controller are running

## Step 4

Deploy your hello world function:
```bash
# First create your ENV
fission env create --name python --image fission/python-env
# Second upload your code
fission fn create --name hello --env python --code hello.py 
# Third Expose your function
fission route create --name hello --function hello --url /hello
```
Now check your function by browsing in you browser to http://$your-ip/hello

## Step 5
Deploy the guest book app:
```bash
# Create a Redis pod for persistent storage
kubectl -n fission apply -f fission/guestbook/redis.yaml
# Upload your get guestbook fucntion
fission function create --name guestbook-get --env python --code fission/guestbook/get.py 
# Create a route to the get guestbook function
fission route create --name guestbook-get --url /guestbook --method GET
# Upload your add to guestbook function
fission function create --name guestbook-add --env python --code fission/guestbook/add.py 
# Create a route to your add to guestbook function
fission route create --name guestbook-add --url /guestbook --method POST
```
Now checkout your guestbook http://$your-ip/guestbook
