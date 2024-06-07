# Usa la imagen base de Debian

FROM debian:latest

# Establece el entorno no interactivo para evitar preguntas durante la instalación de paquetes

ENV DEBIAN_FRONTEND=noninteractive

# Actualiza los paquetes e instala los prerequisitos

RUN apt-get update && \
    apt-get install -y \
    autoconf \
    gcc \
    libc6 \
    libmcrypt-dev \
    make \
    libssl-dev \
    wget \
    bc \
    gawk \
    dc \
    build-essential \
    snmp \
    libnet-snmp-perl \
    gettext \
    unzip \
    apache2 \
    apache2-utils \
    php \
    libgd-dev \
    openssl \
    libssl-dev

# Descarga e instala los plugins de Nagios

RUN cd /tmp && \
    wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.4.6.tar.gz && \
    tar zxf nagios-plugins.tar.gz && \
    cd nagios-plugins-release-2.4.6/ && \
    ./tools/setup && \
    ./configure && \
    make && \
    make install

# Descarga y compila Nagios Core

RUN cd /tmp && \
    wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.14.tar.gz && \
    tar xzf nagioscore.tar.gz && \
    cd nagioscore-nagios-4.4.14/ && \
    ./configure --with-httpd-conf=/etc/apache2/sites-enabled && \
    make all

# Crea usuario y grupo nagios

RUN cd /tmp/nagioscore-nagios-4.4.14/ && \
    make install-groups-users && \
    usermod -a -G nagios www-data

# Instala archivos binarios, CGI y HTML

RUN cd /tmp/nagioscore-nagios-4.4.14/ && \
    make install && \
    make install-daemoninit && \
    make install-commandmode && \
    make install-config && \
    make install-webconf

# Configura Apache para Nagios

RUN a2enmod rewrite && \
    a2enmod cgi && \
    htpasswd -cb /usr/local/nagios/etc/htpasswd.users csa-admin Duoc.2K24*

# Exponee el puerto 80 para Apache

EXPOSE 80

# Copia el script de entrada que inicia Apache y Nagios

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Inicia Apache y Nagios al arrancar el contenedor

ENTRYPOINT ["/entrypoint.sh"]
