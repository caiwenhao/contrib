#!/bin/bash
# Copyright 2016 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e
set -x

branch="master"
github_url="https://raw.githubusercontent.com/kubernetes/kubernetes/${branch}"


# get dns templates
dir="dns"
mkdir -p $dir
for filename in kubedns-cm.yaml kubedns-sa.yaml ; do
    filepath="${dir}/${filename}.j2"
    curl -Lfo ${filepath} "${github_url}/cluster/addons/dns/${filename}"
done
for filename in dns-horizontal-autoscaler.yaml ; do
    filepath="${dir}/${filename}.j2"
    curl -Lfo ${filepath} "${github_url}/cluster/addons/dns-horizontal-autoscaler/${filename}"
done
for filename in kubedns-controller.yaml kubedns-svc.yaml ; do
    filepath="${dir}/${filename}.j2"
    curl -Lfo ${filepath} "${github_url}/cluster/addons/dns/${filename}.in"
    sed -i "" "s/pillar\['\(.*\)'\]/\1/g" $filepath
done

# get cluster monitoring
dir="cluster-monitoring"
mkdir -p $dir
for filename in grafana-service.yaml heapster-controller.yaml heapster-service.yaml influxdb-grafana-controller.yaml influxdb-service.yaml; do
    filepath="${dir}/${filename}.j2"
    curl -Lfo ${filepath} "${github_url}/cluster/addons/cluster-monitoring/influxdb/${filename}"
done

# get cluster logging
dir="cluster-logging"
mkdir -p $dir
for filename in es-controller.yaml es-service.yaml kibana-controller.yaml kibana-service.yaml; do
    filepath="${dir}/${filename}.j2"
    curl -Lfo ${filepath} "${github_url}/cluster/addons/fluentd-elasticsearch/${filename}"
done

# get kube dash
dir="kube-dash"
mkdir -p $dir
for filename in dashboard-controller.yaml dashboard-service.yaml; do
    filepath="${dir}/${filename}.j2"
    curl -Lfo ${filepath} "${github_url}/cluster/addons/dashboard/${filename}"
done

# get kube dash
dir="kube-dash"
mkdir -p $dir
for filename in dashboard-controller.yaml dashboard-service.yaml; do
    filepath="${dir}/${filename}.j2"
    curl -Lfo ${filepath} "${github_url}/cluster/addons/dashboard/${filename}"
done

# get node-problem-detector
dir="node-problem-detector"
mkdir -p $dir
for filename in node-problem-detector.yaml; do
    filepath="${dir}/${filename}.j2"
    curl -Lfo ${filepath} "https://raw.githubusercontent.com/kubernetes/node-problem-detector/master/${filename}"
done