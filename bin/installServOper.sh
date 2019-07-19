#!/bin/bash

echo "Se instalará servicios operativos"

echo "===================Servicio de alarma================================="

chmod +x $BMATIC_HOME/Services/Alarmas/start.sh

#Setear properties de cfg
sed -i 's|"hibernate.connection.url.*|"hibernate.connection.url">jdbc:sqlserver://'$Server':'$PortDB';databaseName=dbBMatic</property>|g' $BMATIC_HOME/Services/Alarmas/config/hibernate.cfg.xml
sed -i 's|"hibernate.connection.username.*|"hibernate.connection.username">'$User'</property>|g' $BMATIC_HOME/Services/Alarmas/config/hibernate.cfg.xml
sed -i 's|"hibernate.connection.password.*|"hibernate.connection.password">'$Pwd2'</property>|g' $BMATIC_HOME/Services/Alarmas/config/hibernate.cfg.xml

#Setear ruta en log4j.log
sed -i 's|log4j.appender.file.File.*|log4j.appender.file.File='$BMATIC_HOME'/Log/Servicios/Alarmas/alarmas.log|g' $BMATIC_HOME/Services/Alarmas/config/log4j.properties

#sed -i 's|log4j.appender.file.File.*|log4j.appender.file.File='$BMATIC_HOME'/Log/Servicios/Alarmas/alarmas.log|g' $BMATIC_HOME/Services/Alarmas/config/log4j.properties


#setear bmatic_home en configuracion del service
sed -i 's|$BMATIC_HOME|'$BMATIC_HOME'|g' $BMATIC_HOME/Services/Alarmas/bmatic-alarms.service

echo "instalar servicio"

echo $BMATIC_HOME

systemctl daemon-reload
#systemctl enable $BMATIC_HOME/Services/Alarmas/bmatic-alarms.service
systemctl enable /home/developer/Documents/instaladorLinux/linux/Services/Alarmas/bmatic-alarms.service
systemctl start bmatic-alarms
#systemctl status bmatic-alarms

echo "====================================================================="

echo "====================Servicio de monitoreo============================"

chmod +x $BMATIC_HOME/Services/Monitoreo/start.sh

#setear properties
sed -i 's|"hibernate.connection.url.*|"hibernate.connection.url">jdbc:sqlserver://'$Server':'$PortDB';databaseName=dbBMatic</property>|g' $BMATIC_HOME/Services/Monitoreo/config/hibernate01.cfg.xml
sed -i 's|"hibernate.connection.username.*|"hibernate.connection.username">'$User'</property>|g' $BMATIC_HOME/Services/Monitoreo/config/hibernate01.cfg.xml
sed -i 's|"hibernate.connection.password.*|"hibernate.connection.password">'$Pwd2'</property>|g' $BMATIC_HOME/Services/Monitoreo/config/hibernate01.cfg.xml

sed -i 's|"hibernate.connection.url.*|"hibernate.connection.url">jdbc:sqlserver://'$Server':'$PortDB';databaseName=dbBMatic</property>|g' $BMATIC_HOME/Services/Monitoreo/config/hibernate02.cfg.xml
sed -i 's|"hibernate.connection.username.*|"hibernate.connection.username">'$User'</property>|g' $BMATIC_HOME/Services/Monitoreo/config/hibernate02.cfg.xml
sed -i 's|"hibernate.connection.password.*|"hibernate.connection.password">'$Pwd2'</property>|g' $BMATIC_HOME/Services/Monitoreo/config/hibernate02.cfg.xml

sed -i 's|urlService=.*|urlService=http://'$IPApache':'$PORTJBOSSB'/WSBmaticTicketera/b_generarAlarma3300|g' $BMATIC_HOME/Services/Monitoreo/config/configuracion.properties
sed -i 's|urlServiceDisplay=.*|urlServiceDisplay=http://'$IPApache':9001/ingresarProgramacion/|g' $BMATIC_HOME/Services/Monitoreo/config/configuracion.properties

#setear bmatic_home en configuracion del service
sed -i 's|$BMATIC_HOME|'$BMATIC_HOME'|g' $BMATIC_HOME/Services/Monitoreo/bmatic-monitoring.service

#setear log4j
sed -i 's|log4j.appender.file.File.*|log4j.appender.file.File='$BMATIC_HOME'/Log/Servicios/Monitoreo/monitoreo.log|g' $BMATIC_HOME/Services/Monitoreo/config/log4j.properties


systemctl daemon-reload
systemctl enable $BMATIC_HOME/Services/Monitoreo/bmatic-monitoring.service
systemctl start bmatic-monitoring
#systemctl status bmatic-monitoring

echo "====================================================================="

echo "=========================Servicio de email==========================="

chmod +x $BMATIC_HOME/Services/Email/start.sh

#setear properties
sed -i 's|"hibernate.connection.url.*|"hibernate.connection.url">jdbc:sqlserver://'$Server':'$PortDB';databaseName=dbBMatic</property>|g' $BMATIC_HOME/Services/Email/config/hibernate.cfg.xml
sed -i 's|"hibernate.connection.username.*|"hibernate.connection.username">'$User'</property>|g' $BMATIC_HOME/Services/Email/config/hibernate.cfg.xml
sed -i 's|"hibernate.connection.password.*|"hibernate.connection.password">'$Pwd2'</property>|g' $BMATIC_HOME/Services/Email/config/hibernate.cfg.xml

sed -i 's|parametro.config.urlWS=.*|parametro.config.urlWS=http://'$IPApache':'$PORTJBOSSB'/WSEnvioCorreo|g' $BMATIC_HOME/Services/Email/config/parametros.properties

#setear log4j
sed -i 's|log4j.appender.file.File.*|log4j.appender.file.File='$BMATIC_HOME'/Log/Servicios/Email/monitoreo.log|g' $BMATIC_HOME/Services/Email/config/log4j.properties

#setear bmatic_home en configuracion del service
sed -i 's|$BMATIC_HOME|'$BMATIC_HOME'|g' $BMATIC_HOME/Services/Email/bmatic-email.service

systemctl daemon-reload
systemctl enable $BMATIC_HOME/Services/Email/bmatic-email.service
systemctl start bmatic-email
#systemctl status bmatic-email

echo "====================================================================="


echo "==========================Wildfly-B=================================="

chmod +x $BMATIC_HOME/Application/wildfly-13-B/start.sh

#setear properties
sed -i 's|<connection-url>.*;databaseName|<connection-url>jdbc:sqlserver://'$Server':'$PortDB';databaseName|g' $BMATIC_HOME/Application/wildfly-13-B/standalone/configuration/standalone.xml
sed -i 's|<module-option name="username".*|<module-option name="username" value="'$User'"/>|g' $BMATIC_HOME/Application/wildfly-13-B/standalone/configuration/standalone.xml
sed -i 's|<module-option name="password".*|<module-option name="password" value="'$Pwd2'"/>|g' $BMATIC_HOME/Application/wildfly-13-B/standalone/configuration/standalone.xml


#setear bmatic_home en configuracion del service
sed -i 's|$BMATIC_HOME|'$BMATIC_HOME'|g' $BMATIC_HOME/Application/wildfly-13-B/bmatic-operative.service

systemctl daemon-reload
systemctl enable $BMATIC_HOME/Application/wildfly-13-B/bmatic-operative.service
systemctl start bmatic-operative
#systemctl status bmatic-operative


if (( $(ps -ef | grep -v grep | grep $bmatic-operative | wc -l) > 0 ))
then
   echo "Servicio de wildfly-B instalado correctamente"
fi



echo "===================================================================="

echo "=========================Display===================================="

chmod +x $BMATIC_HOME/Services/Servidor/Display/start.sh

#setear bmatic_home en configuracion del service
sed -i 's|$BMATIC_HOME|'$BMATIC_HOME'|g' $BMATIC_HOME/Services/Servidor/Display/bmatic-display-server.service

systemctl daemon-reload
systemctl enable $BMATIC_HOME/Services/Servidor/Display/bmatic-display-server.service
systemctl start bmatic-display-server
#systemctl status bmatic-display-server

echo "===================================================================="

echo "=========================Eventos===================================="

chmod +x $BMATIC_HOME/Services/Servidor/Eventos/start.sh


#setear bmatic_home en configuracion del service
sed -i 's|$BMATIC_HOME|'$BMATIC_HOME'|g' $BMATIC_HOME/Services/Servidor/Eventos/bmatic-event-server.service

systemctl daemon-reload
systemctl enable $BMATIC_HOME/Services/Servidor/Eventos/bmatic-event-server.service
systemctl start bmatic-event-server
#systemctl status bmatic-event-server

echo "===================================================================="

<<COMMENT
COMMENT
echo "fin de instalacion de servicio"

