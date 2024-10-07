# age-docker-cluster

This repo will spin up a docker based Altair Grid Engine Cluster. It consists of a dedicated license server (`license`, a head node (`head`) and two compute nodes (`c1` and `c2`).

RStudio Workbench is running in a separate container (rsw) and has the new AGE RStudio Launcher  pre-configured against the AGE cluster.

Version of PWB is 2024.09.0+375.pro3.

## Pre-requisites

### Altair Grid Engine

In order to successfully run, for a desired Altair Grid Engine Version (e.g. "2024.1.0"), one needs to  download `ge-2022.1.2-bin-lx-amd64.tar.gz`, `ge-2022.1.2-common.tar.gz` and `ge-2022.1.2-rstudio-age-lx-amd64.tar.gz` into the `age` subfolder. Likewise, for a given Altair License Manager Version (e.g. "15.2") `altair_licensing_15.5.linux_x64.bin` needs to be downloaded and copied into the `license` subfolder.

Finally a valid license file `age.dat` needs to be deployed into the `license` folder.

By default Altair Grid Engine 2024.1.0 with Altair License Manager 15.5 will be spun up. If you would like to use different versions, please set `AGE_VERSION` and/or `LICENSE_MANAGER_VERSION` as environment variables prior to running/building the environment, e.g.

```
export AGE_VERSION=2022.1.1
export LICENSE_MANAGER_VERSION=15.0
```

### Posit Workbench

In the environment launching the `docker-compose.yml`, the environment variable `PWB_LICENSE` must be set to a vaid license key for Posit Workbench.

Default user name and password are `rstudio/rstudio`.

By default Posit Workbench will be deployed using version 2024.09.0+375.pro3. If you would like to use a different Workbench version, please set the `PWB_VERSION` environment variable before running `docker-compose`

```
export PWB_VERSION=2024.04.2-764.pro1
```

## Starting the environment

You simply can start the cluster with

```
docker-compose up -d 
```

If needed, docker will build the required containers.

The cluster will then listen at http://localhost:8787 .

## Stopping the environment 

```
docker-compose down
```

It also may be advisable to clean out the volumes by running `scripts/clean-volumes.sh`.

## Posit Workbench details

PWB is setup to use shared storage for session-data as well as audit-data. Admin dashboard is enabled, too, for the rstudio user.
