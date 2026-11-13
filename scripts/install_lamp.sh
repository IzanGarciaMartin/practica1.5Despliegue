#!/bin/bash

# Configuramos el script para mostrar los comandos
# y finalizar si se produce algún error.
set -ex

# Obtenemos la ruta absoluta del directorio del script.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Comprobamos que el script se ejecuta como root.
if [ "$EUID" -ne 0 ]; then
    echo "Este script debe ejecutarse como root."
    exit 1
fi

# Actualizamos la lista de paquetes.
apt update

# Actualizamos los paquetes del sistema.
apt upgrade -y

# Instalamos Apache.
apt install apache2 -y

# Copiamos la configuración del VirtualHost.
cp "$PROJECT_DIR/conf/000-default.conf" /etc/apache2/sites-available/000-default.conf

# Instalamos PHP y sus módulos.
apt install php libapache2-mod-php php-mysql -y

# Habilitamos el módulo rewrite.
a2enmod rewrite

# Instalamos MySQL Server.
apt install mysql-server -y

# Creamos una página de prueba.
echo "<h1>Servidor LAMP funcionando correctamente</h1>" > /var/www/html/index.html

# Asignamos los permisos correspondientes.
chown -R www-data:www-data /var/www/html

# Comprobamos la configuración de Apache.
apache2ctl configtest

# Reiniciamos Apache.
systemctl restart apache2

# Comprobamos que los servicios están activos.
systemctl enable apache2
systemctl enable mysql

echo "Instalación LAMP completada correctamente."
