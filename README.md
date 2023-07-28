# Comandos a utilizar para desplegar el contenedor
Nota: Es necesario tener instalado docker para que esto pueda funcionar. 
Más información para la instalación: [Documentación](https://docs.docker.com/get-docker/ )

1. Crear el archivo **Dockerfile**, el contenido debe ser el siguiente:
    
    * Con este comando se utiliza la imagen oficial de **debian** con la etiqueta **latest**:
    > *FROM debian:latest*
    * Se **actualizan** los paquetes disponibles del repositorio de Debian y se instalan los paquetes de **Apache** y el servidor **SSH** (OpenSSH) en la imagen:
    > *RUN apt-get update && apt-get install -y apache2 openssh-server*
    * Se copia nuestro archivo **index.html** de prueba en el directorio por defecto, el archivo **index.html** reemplazará el archivo predeterminado del servidor web **Apache** que sirve como la página de inicio.:
    > *COPY index.html /var/www/html/index.html*
    * Este comando **crea un nuevo usuario** en el contenedor llamado "alesi" y **crea un directorio de inicio** para este usuario en **/home/alesi**.
    > *RUN useradd -ms /bin/bash alesi*
    *Se agrega una contraseña para poder acceder desde SSH:

    > *RUN echo alesi:contrasena | chpasswd*
    * El comando **CMD** define el comando predeterminado que se ejecutará cuando se inicie el contenedor. En este caso, se inician los servicios de **Apache** y **SSH** y luego se mantiene el contenedor en funcionamiento mediante **tail -f /dev/null**. La última parte asegura que el contenedor no se detenga después de iniciar los servicios y esté disponible para recibir solicitudes.
    > *CMD service apache2 start && service ssh start && tail -f /dev/null*

2. Ya que lo tengamos lo guardamos con el nombre ***Dockerfile*** y sin ninguna extensión para que funcione correctamente.

2. Desde una terminal se ejecuta el siguiente comando para armar la imagen del docker con la etiqueta **docker** estando dentro de la carpeta contenedora del **Dockerfile**:

    > *docker build -t docker .*

3. Se crea un volumen local:

    > *docker volume create NOMBRE_VOLUMEN*

4. Se ejecuta el siguiente comando para correr el contenedor **docker** y hace un mapeado de tu puerto local **8081** al puerto **80** dentro del contenedor, además se agrega el parametro **-v** con el que se monta el volumen anteriormente creado  **prueba_volumen** en el directorio **/var/www/html/**. También se agregan los puertos **2222:22** para el servicio de **SSH**

    > *docker run -p 8081:80 -v NOMBRE_VOLUMEN:/var/www/html/ -p 2222:22 docker*

#
#### Una vez realizados estos pasos podemos probar en un navegador accediendo a *localhost:8081*, debemos ver nuestra página de inicio, y desde una terminal con el comando *alesi@localhost -p 2222* (o el usuario que se haya establecido en el Dockerfile), nos solicitará la contraseña también configurada desde el Dockerfile.

