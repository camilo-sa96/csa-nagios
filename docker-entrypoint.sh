#!/bin/bash

# Inicia Apache

service apache2 start

# Inicia Nagios directamente

/usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg

# Mantener el contenedor en ejecución

tail -f /dev/null
