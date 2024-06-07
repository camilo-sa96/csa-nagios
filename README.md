#Contenedor de Nagios 
#By Camilo Sepulveda Alfaro (CSA)

Proceso de Descarga y Compilacion de Imagen de Nagios.

#Proceso de Descarga:
```
git clone https://github.com/camilo-sa96/csa-nagios.git
```
#Cambio de Directorio:
```
cd csa-nagios
```
#Ejecucion de Build de Imagen Nagios:
```
docker build -t nagios .
```
#Ejecucion de Imagen Nagios:
```
docker run -it -d -p 80:80 nagios
```
#Acceso a Nagios / Utilizar Direccionamiento IP del Servidor:
```
http://<direccion_ip>/nagios
```
#Credenciales a Utilizar
```
user: csa-admin
pass: Duoc.2K24*
```
#Imagen Nagios en Ejecucion Exitosa
