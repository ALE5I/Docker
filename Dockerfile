FROM debian:latest
RUN apt-get update && apt-get install -y apache2 openssh-server
COPY index.html /var/www/html/index.html
RUN useradd -ms /bin/bash alesi
RUN echo alesi:contrasena | chpasswd
CMD service apache2 start && service ssh start && tail -f /dev/null
