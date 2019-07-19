#!/bin/bash

echo "sh 2"

DIR="$1"
echo "$DIR"
EMPRESANOMBRE=$(sed -n 's/<Empresa>\(.*\)<\/Empresa>/\1/p' "$DIR"/config/Licencia_Bmatic5.xml)
export empresa="$EMPRESANOMBRE"
echo "$empresa"
