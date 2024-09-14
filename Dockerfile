FROM nginx:1.24.0

# Base packages
RUN apt-get update && \
	apt-get -y install \
	tor torsocks ntpdate \
	qrencode

# Tor configuration
COPY torrc /etc/tor/torrc

# Nginx configuration
COPY index.html /usr/share/nginx/html/index.html
COPY styles.css /usr/share/nginx/html/styles.css
COPY nginx.conf /etc/nginx/conf.d/nginx.conf
EXPOSE 80

# Start services
CMD service tor start && \
	service nginx start && \
	tail -f /dev/null
