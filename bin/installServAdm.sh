#!/bin/bash

echo "Se instalará servicios administrativos"

echo "==========================Wildfly-A=================================="

chmod +x $BMATIC_HOME/Application/wildfly-13-A/start.sh

#setear properties
sed -i 's|<connection-url>.*;databaseName|<connection-url>jdbc:sqlserver://'$Server':'$PortDB';databaseName|g' $BMATIC_HOME/Application/wildfly-13-A/standalone/configuration/standalone.xml
sed -i 's|<module-option name="username".*|<module-option name="username" value="'$User'"/>|g' $BMATIC_HOME/Application/wildfly-13-A/standalone/configuration/standalone.xml
sed -i 's|<module-option name="password".*|<module-option name="password" value="'$Pwd2'"/>|g' $BMATIC_HOME/Application/wildfly-13-A/standalone/configuration/standalone.xml

echo "llega aqui"

#setear bmatic_home en configuracion del service
sed -i 's|$BMATIC_HOME|'$BMATIC_HOME'|g' $BMATIC_HOME/Application/wildfly-13-A/bmatic-management.service

echo "ggg"

systemctl daemon-reload
systemctl enable $BMATIC_HOME/Application/wildfly-13-A/bmatic-management.service
systemctl start bmatic-management
#systemctl status bmatic-management

echo "llega "

echo "===================================================================="

<<COMMENT
COMMENT
echo "fin de instalacion de servicio"

