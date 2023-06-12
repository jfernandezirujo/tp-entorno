# Shebang
#!/bin/bash

# Variables
NUM_IMAGE=$1
NAMES_FILE="names_file.txt"
IMAGES_FOLDER="imagenes"
IMAGES_URL="https://source.unsplash.com/random/900x700/?person"
NAMES_URL="https://raw.githubusercontent.com/fernandezpablo85/name_suggestions/master/assets/dict.csv"

# Descarga el archivo de nombres
curl -o $NAMES_FILE $NAMES_URL

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
tar -czvf images.tar.gz $IMAGES_FOLDER/*
