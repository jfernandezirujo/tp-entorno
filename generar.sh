# Shebang
#!/bin/bash

# Variables
NUM_IMAGE=$1
NAMES_FILE="dict.csv"
IMAGES_FOLDER="imagenes"
IMAGES_URL="https://thispersondoesnotexist.com/"
NAMES_URL="https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv"
CHECKSUM_FILE="checksum.txt"

# Descarga el archivo de nombres
touch $NAMES_FILE
wget -O $NAMES_FILE $NAMES_URL

# Crea la carpeta de imagenes
mkdir -p $IMAGES_FOLDER

# Genera imagenes y les asigna un nombre
for ((N=1; N<=NUM_IMAGE; N++))
do
  NAME=$(shuf -n 1 $NAMES_FILE) #Toma 1 valor random del archivo names_file
  NAME=$(echo $NAME | sed 's/,.*//') # Remueve la edad del nombre
  IMAGE_NAME=$(echo $NAME | tr ' ' '_') # Reemplaza espacios por guiones bajos
  wget -O "$IMAGES_FOLDER/imagen_$N-$IMAGE_NAME.jpg" $IMAGES_URL #Toma 1 imagen de la url y le asigna el nombre
  sleep 1 #Tiempo espera entre cada iteracion
done

# Comprime las imágenes
zip -r "$IMAGES_FOLDER.zip" "$IMAGES_FOLDER"/*

# Crea archivo con cantidad de imagnes
touch $CHECKSUM_FILE
md5sum "$IMAGES_FOLDER.zip" > "$CHECKSUM_FILE"

rm $NAMES_FILE
rm -r $IMAGES_FOLDER