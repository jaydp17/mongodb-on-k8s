# mongodb-on-k8s

This repo shows how to deploy a very simple app with mongodb on Kubernetes using StatefulSets.

The app being deployed here is a very minimal app with just 2 endpoints

#### 1. Set name for the user

```sh
$ curl -v -X PUT https://<DOMAIN>/name/this-is-my-new-name
```

#### 2. Get the name of the user

```sh
$ curl -v https://<DOMAIN>/name
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

The default replica count is 3, you can change it if you like.<br/>
Also every API response contains the **name of the pod that served the response in its header**.

## Cluster Info ![Kubernetes v1.9.7](https://img.shields.io/badge/Kubernetes-v1.9.7-brightgreen.svg)

Because [StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/) became GA in Kubernetes 1.9, this project has been tested on a cluster running `v1.9.7` with RBAC enabled.

The [Terraform](https://www.terraform.io/) files used to create the cluster are available over [here](terraform).

_Note: These terraform files are generated using [kops](https://github.com/kubernetes/kops) v1.9_

## Node Version

Anything above node.js version 8 will work just fine.

The Docker image uses `v8.9.0`.

### License

MIT
