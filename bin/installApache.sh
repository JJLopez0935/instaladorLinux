#!/bin/bash

echo "llega apache"
echo $BMATIC_HOME

echo ""
echo ""

if [ $PROTOCOLO = "http" ]
then
 echo "ES HTTP"
 mv $BMATIC_HOME/tools/Apache24/conf/extra/httpd-ahssl.conf.http $BMATIC_HOME/tools/Apache24/conf/extra/httpd-ahssl.conf
 mv $BMATIC_HOME/tools/Apache24/conf/extra/httpd-vhosts.conf.http  $BMATIC_HOME/tools/Apache24/conf/extra/httpd-vhosts.conf

 echo "Se cambio de nombre los archivos http"
 sed -i 's/IP_LOCAL/'$IPApache'/g' $BMATIC_HOME/tools/Apache24/conf/extra/httpd-ahssl.conf
 sed -i 's/ReplaceServer:ReplacePort/'$IPApache':'$PortApache'/g' $BMATIC_HOME/tools/Apache24/conf/extra/httpd-vhosts.conf
 sed -i 's/IPApache:PORTJBOSSA/'$IPApache':'$PORTJBOSSA'/g' $BMATIC_HOME/tools/Apache24/conf/extra/httpd-vhosts.conf
elif [ $PROTOCOLO = "https" ]
then
 echo "ES HTTPS"
 mv $BMATIC_HOME/tools/Apache24/conf/extra/httpd-ahssl.conf.https $BMATIC_HOME/tools/Apache24/conf/extra/httpd-ahssl.conf
 mv $BMATIC_HOME/tools/Apache24/conf/extra/httpd-vhosts.conf.https  $BMATIC_HOME/tools/Apache24/conf/extra/httpd-vhosts.conf

 sed -i 's/IP_LOCAL/'$IPApache'/g' $BMATIC_HOME/tools/Apache24/conf/extra/httpd-vhosts.conf
 #sed -i 's/ReplaceServer:ReplacePort/'$IPApache':'$PortApache'/g' $BMATIC_HOME/tools/Apache24/conf/extra/httpd-ahssl.conf
 sed -i 's/IPApache:PORTJBOSSA/'$IPApache':'$PORTJBOSSA'/g' $BMATIC_HOME/tools/Apache24/conf/extra/httpd-ahssl.conf
fi


echo "Termino de configurar reglas de apache"
echo ""
RUTAAPACHE="$BMATIC_HOME"/tools/Apache24
echo "$RUTAAPACHE"
sed -i 's|Carpeta_apache_home|'$BMATIC_HOME'/tools/Apache24|g' $BMATIC_HOME/tools/Apache24/conf/httpd.conf
sed -i 's|RootTicketeraWeb|'$BMATIC_HOME'/WEB/TicketeraWeb|g' $BMATIC_HOME/tools/Apache24/conf/httpd.conf
sed -i 's|RootVideos|'$BMATIC_HOME'/Channel/Contenido/Partes|g' $BMATIC_HOME/tools/Apache24/conf/httpd.conf
sed -i 's|RootImagenes|'$BMATIC_HOME'/Channel/Imagenes|g' $BMATIC_HOME/tools/Apache24/conf/httpd.conf
sed -i 's|http://.*/BMATIC_MAINSECURITY|http://'$IPApache'/BMATIC_MAINSECURITY|g' $BMATIC_HOME/tools/Apache24/htdocs/index.html
sed -i 's|http://.*/VentanillaWeb|http://'$IPApache'/VentanillaWeb|g' $BMATIC_HOME/tools/Apache24/htdocs/index.html

