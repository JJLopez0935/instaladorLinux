#!/bin/bash
echo "prueba de var entorno"
echo $BMATIC_HOME

#cd $BMATIC_HOME/Services/Monitoreo/ && java -jar app.jar &
java -jar $BMATIC_HOME/Services/Monitoreo/app.jar &

