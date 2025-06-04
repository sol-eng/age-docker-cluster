#!/bin/bash

set -x 
export LD_LIBRARY_PATH=/usr/local/altair/licensing$1/bin/
cd /usr/local/altair/licensing$1/
/usr/local/altair/licensing$1/bin/lmx-serv -l /license/age.dat

