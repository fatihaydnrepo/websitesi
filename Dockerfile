# Use the official Nginx image from Docker Hub
FROM nginx:alpine

WORKDIR /app

# Expose port for Nginx
EXPOSE 80

# Command to run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
