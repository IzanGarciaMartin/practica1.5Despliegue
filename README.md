# Práctica 1.5 – Despliegue de un servidor web con HTTPS

## Descripción

En esta práctica se ha desplegado un servidor web LAMP en una instancia EC2 de AWS y se ha configurado una conexión segura HTTPS mediante un certificado SSL/TLS de Let's Encrypt.

## Tecnologías utilizadas

- **AWS EC2:** instancia donde se aloja el servidor.
- **Apache:** servidor web.
- **PHP:** lenguaje de programación del servidor.
- **MySQL:** sistema gestor de bases de datos.
- **Let's Encrypt:** autoridad de certificación para HTTPS.
- **Certbot:** herramienta para obtener y configurar el certificado SSL/TLS.
- **No-IP:** servicio utilizado para obtener un dominio gratuito.

## Configuración realizada

1. Instalación de Apache, PHP y MySQL mediante un script Bash.
2. Configuración del VirtualHost de Apache.
3. Creación de un dominio gratuito en No-IP.
4. Configuración del registro DNS para apuntar a la IP pública de la instancia EC2.
5. Instalación de Certbot mediante Snap.
6. Obtención e instalación del certificado SSL/TLS de Let's Encrypt.
7. Configuración de Apache para utilizar HTTPS y redirigir automáticamente las conexiones HTTP.
8. Comprobación de la renovación automática del certificado mediante el temporizador de Certbot.

## Capturas de pantalla

| Archivo | Descripción |
|---|---|
| `lamp_funcionando.png` | Servidor LAMP funcionando correctamente. |
| `Grupo_seg.png` | Reglas de seguridad del grupo de AWS. |
| `Dominio_NoIp.png` | Dominio gratuito configurado en No-IP. |
| `CertBot_instalado.png` | Instalación de Certbot mediante Snap. |
| `conexion_seg.png` | Comprobación de la conexión segura HTTPS. |
| `detalles_certHTTPS.png` | Detalles del certificado HTTPS instalado. |

## Uso de inteligencia artificial

Se ha utilizado inteligencia artificial como herramienta de apoyo durante la realización de la práctica para:

- Revisar y corregir los scripts Bash utilizados.
- Resolver dudas sobre los comandos y la configuración del servidor.
- Recibir orientación paso a paso durante el despliegue.
- Ayudar a identificar y solucionar errores durante la configuración.

La configuración, ejecución de los comandos y comprobaciones se han realizado en la propia instancia EC2.

## Autor

Izan García Martín

2º DAW – IES Celia Viñas