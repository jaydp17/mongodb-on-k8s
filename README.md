# mongodb-on-k8s

This repo shows how to deploy a very simple app with mongodb on Kubernetes using StatefulSets.

The app being deployed here is a very minimal app with just 2 endpoints

#### 1. Set name for the user

```sh
$ curl -X PUT https://<DOMAIN>/name/this-is-my-new-name
```

#### 2. Get the name of the user

```sh
$ curl https://<DOMAIN>/name
```

## How to deploy?

The project uses [helm](https://www.helm.sh/) for templating & release management.

To check Kubernetes manifest files before deploying

```sh
# it'll print out all the rendered manifest files
$ helm install --dry-run --debug ./helm-chart/mongodb-on-k8s
```

To deploy it

```sh
# installs/upgrades the chart
$ helm --debug upgrade --install --namespace default my-release-name ./helm-chart/mongodb-on-k8s
```

The above commmand deploys it to namespace `default`.

To deploy it to some other namespace

```sh
# create the namespace
$ kubectl create ns my-custom-ns

# deploy the chart in that namespace
$ helm --debug upgrade --install --namespace my-custom-ns my-release-name ./helm-chart/mongodb-on-k8s
```
