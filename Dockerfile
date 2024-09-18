FROM nginx:1.24.0

# Base packages
RUN apt-get update && \
	apt-get -y install \
	tor torsocks ntpdate \
	qrencode \
	openssh-server

# Create a new user for ssh access
RUN useradd -m sshuser && \
	echo 'sshuser:password' | chpasswd && \
	mkdir -p /home/sshuser/.ssh

# Tor configuration
COPY torrc /etc/tor/torrc

# Nginx configuration
COPY index.html /usr/share/nginx/html/index.html
COPY styles.css /usr/share/nginx/html/styles.css
COPY nginx.conf /etc/nginx/conf.d/nginx.conf

# Copy SSH keys
COPY id_rsa.pub /home/sshuser/.ssh/authorized_keys
COPY sshd_config /etc/ssh/sshd_config

# Set correct permissions for SSH keys
RUN chown -R sshuser:sshuser /home/sshuser/.ssh && \
	chmod 600 /home/sshuser/.ssh/authorized_keys && \
	chmod 700 /home/sshuser/.ssh

# Allow the user to connect via SSH
RUN echo 'AllowUsers sshuser' >> /etc/ssh/sshd_config

EXPOSE 80
EXPOSE 4242

# Start services
CMD service tor start && \
	service nginx start && \
	service ssh start && \
	tail -f /dev/null
