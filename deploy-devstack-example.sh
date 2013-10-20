#!/bin/bash
set -e

VMDK_OPTION=$1

DEVSTACK_NAME=devstack-test-$RANDOM
ESXI_HOST=10.7.2.2
ESXI_USER=root

DATASTORE=datastore1
ESXI_PUBLIC_SWITCH=vSwitch0
ESXI_PUBLIC_VMNIC=vmnic0

LINUX_TEMPLATE_VMDK=/vmfs/volumes/datastore1/ubuntu-12.04-server-template-40G/ubuntu-12.04-server-template-40G.vmdk
HYPERV_TEMPLATE_VMDK=/vmfs/volumes/datastore1/hyperv-2012-r2-template-80G/hyperv-2012-r2-template-80G.vmdk

if [ "$VMDK_OPTION" == "use_linked_vmdks" ]; then
    LINUX_TEMPLATE_VMDK=${LINUX_TEMPLATE_VMDK%%.vmdk}-000001.vmdk
    HYPERV_TEMPLATE_VMDK=${HYPERV_TEMPLATE_VMDK%%.vmdk}-000001.vmdk    
fi

BASEDIR=$(dirname $0)

echo "Deploying DevStack: $DEVSTACK_NAME"

$BASEDIR/deploy-devstack.sh $ESXI_USER $ESXI_HOST "$DATASTORE" "$DEVSTACK_NAME" "$ESXI_PUBLIC_SWITCH" $ESXI_PUBLIC_VMNIC "$LINUX_TEMPLATE_VMDK" "$HYPERV_TEMPLATE_VMDK"

