FROM nginx:alpine

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Set work directory
WORKDIR /usr/share/nginx/html

# Copy all project files into webroot
COPY . /usr/share/nginx/html

# Run update_media.sh to ensure media.js always lists all current images/videos
RUN chmod +x update_media.sh && ./update_media.sh

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
