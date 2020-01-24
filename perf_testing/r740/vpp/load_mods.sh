#!/bin/bash

rmmod i40e; modprobe i40e
modprobe uio_pci_generic
modprobe vfio_pci
