#!/bin/bash

if [ "$1" = "head-node" ]; then
   /etc/init.d/ssh restart
   echo "Installing AGE on the head node..."
   rm -rf /opt/age/*/default 
   cd /opt/age/*/ && ./inst_sge -m -auto  `pwd`/inst.conf 
   source /opt/age/*/default/common/settings.sh
   echo "Configuring PE's"
   for pe in smp mpi openmp
   do
     qconf -Ap /tmp/$pe.conf
   done
   echo "AGE installed successfully on the head node."
 
   while true
	do
	sleep 10
	done
fi

if [ "$1" = "compute-node" ]; then
   /etc/init.d/ssh restart
   echo "Installing AGE on the compute node..."
   cat > /etc/ssh/ssh_config << EOF
Host *
    StrictHostKeyChecking  no
EOF

   while true 
   do
   sleep 5
   if [ -f /opt/age/*/default/common/settings.sh ]; then 
      break
   fi
   done
   sudo -u ageadmin ssh head "source /opt/age/*/default/common/settings.sh && qconf -as `hostname`"
   sudo -u ageadmin ssh head "source /opt/age/*/default/common/settings.sh && qconf -ah `hostname`"
   cd /opt/age/*/ && cat ./inst.conf | sed "s/EXEC_HOST_LIST=.*/EXEC_HOST_LIST=`hostname`/" > ./inst_`hostname`.conf
   cd /opt/age/*/ && ./inst_sge -x -auto  ./inst_`hostname`.conf
   while true
        do
        sleep 10
        done
fi

if [ "$1" = "rsw" ]; then 
  echo "x" 
   echo "Installing AGE on the compute node..."
   cat > /etc/ssh/ssh_config << EOF
Host *
    StrictHostKeyChecking  no
EOF

   while true 
   do
   sleep 5
   if [ -f /opt/age/*/default/common/settings.sh ]; then 
      break
   fi
   done

   sudo -u ageadmin ssh head "source /opt/age/*/default/common/settings.sh && qconf -as `hostname`"

   ln -s /opt/rstudio-age /opt/age/*
   /usr/lib/rstudio-server/bin/license-manager activate $PWB_LICENSE
   rm -f /etc/rstudio/launcher.{pem,pub}
   rstudio-server start
   rstudio-launcher start

   while true
        do
        sleep 10
        done
fi 
