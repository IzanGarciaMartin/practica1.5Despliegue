#!/bin/bash

# Configuramos el script para mostrar los comandos
# y finalizar si se produce algún error.
set -ex

# Obtenemos la ruta absoluta del directorio del script.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Cargamos las variables de configuración.
source "$SCRIPT_DIR/.env"

# Comprobamos que el script se ejecuta como root.
if [ "$EUID" -ne 0 ]; then
    echo "Este script debe ejecutarse como root."
    exit 1
fi

# Comprobamos que las variables necesarias están configuradas.
if [ -z "$DOMAIN" ] || [ "$DOMAIN" = "tu-dominio" ] || [ -z "$EMAIL" ]; then
    echo "Error: configura DOMAIN y EMAIL en el archivo .env."
    exit 1
fi

# Comprobamos que Snap está instalado.
if ! command -v snap &> /dev/null; then
    apt update
    apt install snapd -y
fi

# Instalamos y actualizamos Snap Core.
if ! snap list core &> /dev/null; then
    snap install core
fi

snap refresh core

# Eliminamos una posible instalación anterior de Certbot mediante APT.
apt remove certbot -y

# Instalamos Certbot mediante Snap.
if ! snap list certbot &> /dev/null; then
    snap install --classic certbot
else
    snap refresh certbot
fi

# Creamos el enlace simbólico para utilizar el comando certbot.
ln -fs /snap/bin/certbot /usr/bin/certbot

# Preparamos los dominios para solicitar el certificado.
CERTBOT_DOMAINS=(-d "$DOMAIN")

if [ -n "$WWW_DOMAIN" ]; then
    CERTBOT_DOMAINS+=(-d "$WWW_DOMAIN")
fi

# Solicitamos el certificado y configuramos Apache.
certbot --apache \
    -m "$EMAIL" \
    --agree-tos \
    --no-eff-email \
    --redirect \
    --non-interactive \
    "${CERTBOT_DOMAINS[@]}"

echo "Certificado SSL/TLS configurado correctamente."
