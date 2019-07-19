#!/bin/bash


#Desinstalar servicios
systemctl stop bmatic-alarms.service
systemctl disable bmatic-alarms.service

systemctl stop bmatic-email.service
systemctl disable bmatic-email.service

systemctl stop bmatic-display-server.service
systemctl disable bmatic-display-server.service

systemctl stop bmatic-monitoring.service
systemctl disable bmatic-monitoring.service

systemctl stop bmatic-operative.service
systemctl disable bmatic-operative.service

systemctl stop bmatic-management.service
systemctl disable bmatic-management.service

systemctl stop bmatic-sync.service
systemctl disable bmatic-sync.service

systemctl stop bmatic-www.service
systemctl disable bmatic-www.service

#Deshacer archivos de configuracion para servicios
sed -i 's|ExecStart.*|ExecStart=$BMATIC_HOME/Services/Alarmas/start.sh|g' $BMATIC_HOME/Services/Alarmas/bmatic-alarms.service
sed -i 's|Environment.*|Environment="BMATIC_HOME=$BMATIC_HOME"|g' $BMATIC_HOME/Services/Alarmas/bmatic-alarms.service

sed -i 's|ExecStart.*|ExecStart=$BMATIC_HOME/Services/Monitoreo/start.sh|g' $BMATIC_HOME/Services/Monitoreo/bmatic-monitoring.service
sed -i 's|Environment.*|Environment="BMATIC_HOME=$BMATIC_HOME"|g' $BMATIC_HOME/Services/Monitoreo/bmatic-monitoring.service

sed -i 's|ExecStart.*|ExecStart=$BMATIC_HOME/Services/Email/start.sh|g' $BMATIC_HOME/Services/Email/bmatic-email.service
sed -i 's|Environment.*|Environment="BMATIC_HOME=$BMATIC_HOME"|g' $BMATIC_HOME/Services/Email/bmatic-email.service

sed -i 's|ExecStart.*|ExecStart=$BMATIC_HOME/Services/Servidor/Display/start.sh|g' $BMATIC_HOME/Services/Servidor/Display/bmatic-display-server.service
sed -i 's|Environment.*|Environment="BMATIC_HOME=$BMATIC_HOME"|g' $BMATIC_HOME/Services/Servidor/Display/bmatic-display-server.service

sed -i 's|ExecStart.*|ExecStart=$BMATIC_HOME/Services/Servidor/Eventos/start.sh|g' $BMATIC_HOME/Services/Servidor/Eventos/bmatic-event-server.service
sed -i 's|Environment.*|Environment="BMATIC_HOME=$BMATIC_HOME"|g' $BMATIC_HOME/Services/Servidor/Eventos/bmatic-event-server.service

sed -i 's|ExecStart.*|ExecStart=$BMATIC_HOME/Application/wildfly-13-A/start.sh|g' $BMATIC_HOME/Application/wildfly-13-A/bmatic-management.service
sed -i 's|Environment.*|Environment="BMATIC_HOME=$BMATIC_HOME"|g' $BMATIC_HOME/Application/wildfly-13-A/bmatic-management.service

sed -i 's|ExecStart.*|ExecStart=$BMATIC_HOME/Application/wildfly-13-B/start.sh|g' $BMATIC_HOME/Application/wildfly-13-B/bmatic-operative.service
sed -i 's|Environment.*|Environment="BMATIC_HOME=$BMATIC_HOME"|g' $BMATIC_HOME/Application/wildfly-13-B/bmatic-operative.service


<<COMMENT
systemctl stop bmatic-.service
systemctl disable bmatic-email.service

systemctl stop bmatic-email.service
systemctl disable bmatic-email.service
COMMENT
