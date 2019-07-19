#!/bin/bash

getValue(){
   key="$1"
   echo $(sed -n 's/<'"$key"'>\(.*\)<\/'"$key"'>/\1/p' "$DIR"/config/Setup.xml)  | tr -d '\r' | tr -d ' '
}

replaceValueFromFile(){
   key="$1"
   value="$2"
   pathFile="$3"

   sed -i 's|'"$key"'|'"$value"'|g' "$pathFile"
}


binDIR=$(pwd)
echo "ruta donde estamos ahora"
echo "$binDIR"
cd ..
DIR=$(pwd)
echo "ruta root"
echo "$DIR"
cd bin



echo $(sed -n 's/<JBossA>\(.*\)<\/JBossA>/\1/p' "$DIR"/config/Setup.xml)


JBossA=$(getValue JBossA)
export JBossAggg="$JBossA"


PORTJBOSSA=$(getValue PORTJBOSSA)
export PORTJBOSSA="$PORTJBOSSA"


JBossB=$(getValue JBossB)
export JBossB="$JBossB"

PORTJBOSSB=$(getValue PORTJBOSSB)
export PORTJBOSSB="$PORTJBOSSB"

User=$(getValue User) 
export User="$User"

Pwd2=$(getValue Pwd2)
export Pwd2="$Pwd2"

Server=$(getValue Server)
export Server="$Server"

PortDB=$(getValue PortDB)
export PortDB="$PortDB"

IPApache=$(getValue IPApache)
export IPApache="$IPApache"

PortApache=$(getValue PortApache)
export PortApache="$PortApache"

SERVICIOS=$(getValue SERVICIOS)
export SERVICIOS="$SERVICIOS"

InstallPrerequisitos=$(getValue InstallPrerequisitos)
InstallRequisitos=$(echo "$InstallPrerequisitos" | sed -e 's/\r//g')

InstallBD=$(getValue InstallBD)

PROTOCOLO=$(getValue Protocolo)
export PROTOCOLO="$PROTOCOLO"

PORTTOMCAT=$(getValue PORTTOMCAT)
export PORTTOMCAT="$PORTTOMCAT"

IPC=$(getValue IPC)
export IPC="$IPC"

PWDSYM=$(getValue PWDSYM)
export PWDSYM="$PWDSYM"

RutaLicencia=$(getValue RutaLicencia)
export RutaLicencia="$RutaLicencia"

rm -f "$DIR"/config/Licencia_Bmatic5.xml
echo "ruta para copiar licencia"
echo "$RutaLicencia"
cp "$RutaLicencia"/Licencia.xml "$DIR"/config/
#cp /home/developer/Documents/licencia/Licencia.xml "$DIR"/config/
mv "$DIR"/config/Licencia.xml "$DIR"/config/Licencia_Bmatic5.xml

BMATIC_HOME="$DIR"
export BMATIC_HOME="$BMATIC_HOME"

echo "Seteando variable de entorno Bmatic_home"
#echo BMATIC_HOME="$BMATIC_HOME" >> /etc/environment
echo "fin de setea de variable de entorno"

JBOSS_HOME_A="$BMATIC_HOME"/Application/wildfly-13-A
export JBOSS_HOME_A="$JBOSS_HOME_A"

JBOSS_HOME_B="$BMATIC_HOME"/Application/wildfly-13-B
export JBOSS_HOME_B="$JBOSS_HOME_B"

sh ./empresa.sh "$DIR"

if [ "$InstallRequisitos" == "Si" ]
then
    echo "activar la instalacion de requisitos"
#   BMATIC_HOME="$DIR"
#   echo "$BMATIC_HOME"

#export BMATIC_HOME="$BMATIC_HOME"
#   dpkg -i "$DIR"/lib/erlang-base_18.3-dfsg-1ubuntu3_i386.deb
#    dpkg -i "$DIR"/lib/erlang-dev_18.3
#    dpkg -i "$DIR"/lib/erlang_18.3-dfsg-1ubuntu3_all.deb   
fi

sh ./installApache.sh
echo "Termino instalacion apache"

#Setear ip y puerto para production.json
#Funcion replaceValueFromFile palabraClave palabraNueva rutaArchivo

echo "IPAPACHE"

echo "$IPApache"
echo "$PortApache"

#sed -i 's|"bmatic_api_central":.*/api/v1|"bmatic_api_central":"'$PROTOCOLO'://'$IPApache':'$PortApache'/api/v1|g' $BMATIC_HOME/WEB/TicketeraWeb/assets/config/production.json
replaceValueFromFile '"bmatic_api_central":.*/api/v1' '"bmatic_api_central":"'$PROTOCOLO'://'$IPApache':'$PortApache'/api/v1' $BMATIC_HOME/WEB/TicketeraWeb/assets/config/production.json
replaceValueFromFile '"bmatic_api_local":.*/api/v1' '"bmatic_api_local":"'$PROTOCOLO'://'$IPApache':'$PortApache'/api/v1' $BMATIC_HOME/WEB/TicketeraWeb/assets/config/production.json
replaceValueFromFile 'bmatic_download_files":.*/TicketeraWeb/assets/files/' '"bmatic_download_files":"'$PROTOCOLO'://'$IPApache':'$PortApache'/TicketeraWeb/assets/files/' $BMATIC_HOME/WEB/TicketeraWeb/assets/config/production.json
replaceValueFromFile '"bmatic_api_alert":.*/WSBmaticTicketera' '"bmatic_api_alert":"'$PROTOCOLO'://'$IPApache':'$PortApache'/WSBmaticTicketera' $BMATIC_HOME/WEB/TicketeraWeb/assets/config/production.json

#Setear valores de global.properties
#sed -i 's|jasperServer=.*|jasperServer=http://'$IPApache':'$PORTJBOSSB'/jasperserver|g' $BMATIC_HOME/Config/global.properties
replaceValueFromFile 'jasperServer=.*' 'jasperServer=http://'$IPApache':'$PORTJBOSSB'/jasperserver' $BMATIC_HOME/Config/global.properties
replaceValueFromFile 'rutaHostSms=.*' 'rutaHostSms=http://'$IPApache':'$PORTJBOSSB'/rutaHostSms' $BMATIC_HOME/Config/global.properties
replaceValueFromFile 'RestHost=.*' 'RestHost='$PROTOCOLO'://'$IPApache'' $BMATIC_HOME/config/global.properties
replaceValueFromFile 'socket.servicio.banner=.*' 'socket.servicio.banner=http://'$IPApache':'$PORTJBOSSB'/WSChannel/rest/ingresarBanner' $BMATIC_HOME/config/global.properties
replaceValueFromFile 'rutaHostTiempoEspera=.*' 'rutaHostTiempoEspera=http://'$IPApache':'$PORTJBOSSB'/ticket-webservice/ticket/waitingTime' $BMATIC_HOME/config/global.properties
replaceValueFromFile 'rutaDespliegue=.*' 'rutaDespliegue=http://localhost:'$PORTJBOSSA'/BMATIC_MAINSECURITY' $BMATIC_HOME/config/global.properties
replaceValueFromFile 'eventBusUri=.*' 'eventBusUri=http://'$IPApache':9000' $BMATIC_HOME/config/global.properties
replaceValueFromFile 'rutaHostCorreo=.*' 'rutaHostCorreo=http://'$IPApache':'$PORTJBOSSA'/email-web' $BMATIC_HOME/config/global.properties
replaceValueFromFile 'rutaImagenRompepantalla=.*' 'rutaImagenRompepantalla=http://'$IPApache':'$PortApache'/imagenes/logo_rompepantalla.png' $BMATIC_HOME/config/global.properties
replaceValueFromFile 'rutaArchivo=.*' 'rutaArchivo='$BMATIC_HOME'/Channel/Contenido' $BMATIC_HOME/config/global.properties



if [ "$PROTOCOLO" == "http" ]
then
    replaceValueFromFile 'eventBusUriVentanillaWeb=.*' 'eventBusUriVentanillaWeb=http://'$IPApache':9000' $BMATIC_HOME/config/global.properties
elif [ "$PROTOCOLO" == "https" ]
then
    replaceValueFromFile 'eventBusUriVentanillaWeb=.*' 'eventBusUriVentanillaWeb=https://'$IPApache $BMATIC_HOME/config/global.properties

fi

if [ "$InstallBD" == "si" ]
then
echo "se instalara base de datos"
    sh ./BaseDatos.sh


fi


replaceValueFromFile '"ip":.*' '"ip":"'$IPApache'",' $BMATIC_HOME/wars/wildfly-13-A/resources/conexion.properties
cd $BMATIC_HOME/wars/wildfly-13-A
pwd
jar uvf report-client.war resources
cd $BMATIC_HOME/bin


echo "Se copiaran los archivos para jboss A y B"
cp -r $BMATIC_HOME/wars/wildfly-13-A/* $BMATIC_HOME/Application/wildfly-13-A/standalone/deployments
cp -r $BMATIC_HOME/wars/wildfly-13-B/* $BMATIC_HOME/Application/wildfly-13-B/standalone/deployments

sh ./installServAdm.sh
sh ./installServOper.sh

