#!/usr/bin/env bash
#
# Copyright 2022 IBM Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -o errexit
set -o pipefail
set -o errtrace
set -o nounset

OC=${1:-oc}

cs_operator_namespaces=""

function main() {
    "${OC}" get nodes
    prereq

    prepare_cluster
}

# verify that all pre-requisite CLI tools exist
function prereq() {
    which "${OC}" || error "Missing oc CLI"
}

function prepare_cluster() {
    local cm_name="common-service-maps"
    return_value=$("${OC}" get -n kube-public configmap ${cm_name} || echo failed)
    if [[ $return_value == "failed" ]]; then
        error "Missing configmap: ${cm_name}. This must be configured before proceeding"
    fi

    # configmap should have control namespace specified

    # ensure cs-operator is not installed in all namespace mode

    # find all namespaces with cs-operator running
    # each namespace should be in configmap

    # uninstall singleton services
}

function msg() {
    printf '%b\n' "$1"
}

function success() {
    msg "\33[32m[✔] ${1}\33[0m"
}

function error() {
    msg "\33[31m[✘] ${1}\33[0m"
    exit 1
}

function title() {
    msg "\33[34m# ${1}\33[0m"
}

function info() {
    msg "[INFO] ${1}"
}

# --- Run ---

main $*

