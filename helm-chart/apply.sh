#!/usr/bin/env bash

helm --debug \
  upgrade \
  --install \
  yo-release \
  ./mongodb-on-k8s
