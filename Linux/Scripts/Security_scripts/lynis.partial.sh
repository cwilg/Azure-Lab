#!/bin/bash

lynis --tests-from-group malware,authentication,networking,storage,filesystems >> /tmp/lynis.partial_scan.log
