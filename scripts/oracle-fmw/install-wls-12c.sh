#!/bin/bash
mkdir /home/$OS_USER/.inventory
chown $OS_USER:$OS_GROUP -R /home/$OS_USER/.inventory

cat > /tmp/oraInst.loc <<EOF
inventory_loc=/home/$OS_USER/.inventory
inst_group=$OS_GROUP
EOF

cat > /tmp/fmw_wls.rsp <<EOF
[ENGINE]

#DO NOT CHANGE THIS.
Response File Version=1.0.0.0.0

[GENERIC]

#Set this to true if you wish to skip software updates
DECLINE_AUTO_UPDATES=true

#
MOS_USERNAME=

#
MOS_PASSWORD=<SECURE VALUE>

#If the Software updates are already downloaded and available on your local system, then specify the path to the directory where these patches are available and set SPECIFY_DOWNLOAD_LOCATION to true
AUTO_UPDATES_LOCATION=

#
SOFTWARE_UPDATES_PROXY_SERVER=

#
SOFTWARE_UPDATES_PROXY_PORT=

#
SOFTWARE_UPDATES_PROXY_USER=

#
SOFTWARE_UPDATES_PROXY_PASSWORD=<SECURE VALUE>

#The oracle home location. This can be an existing Oracle Home or a new Oracle Home
ORACLE_HOME=$ORACLE_HOME

#Set this variable value to the Installation Type selected. e.g. WebLogic Server, Coherence, Complete with Examples.
INSTALL_TYPE=Complete with Examples

#Provide the My Oracle Support Username. If you wish to ignore Oracle Configuration Manager configuration provide empty string for user name.
MYORACLESUPPORT_USERNAME=

#Provide the My Oracle Support Password
MYORACLESUPPORT_PASSWORD=<SECURE VALUE>

#Set this to true if you wish to decline the security updates. Setting this to true and providing empty string for My Oracle Support username will ignore the Oracle Configuration Manager configuration
DECLINE_SECURITY_UPDATES=true

#Set this to true if My Oracle Support Password is specified
SECURITY_UPDATES_VIA_MYORACLESUPPORT=false

#Provide the Proxy Host
PROXY_HOST=

#Provide the Proxy Port
PROXY_PORT=

#Provide the Proxy Username
PROXY_USER=

#Provide the Proxy Password
PROXY_PWD=<SECURE VALUE>

#Type String (URL format) Indicates the OCM Repeater URL which should be of the format [scheme[Http/Https]]://[repeater host]:[repeater port]
COLLECTOR_SUPPORTHUB_URL=
EOF

cd $INSTALL_DIR
su $OS_USER -c "java -jar $WLS_JAR -ignoreSysPrereqs -novalidation -silent -responseFile /tmp/fmw_wls.rsp -invPtrLoc /tmp/oraInst.loc -jreLoc $JAVA_HOME"

echo "ORACLE_HOME=$ORACLE_HOME; export ORACLE_HOME" >> /home/$OS_USER/.bash_profile
