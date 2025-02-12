# Use the official Nginx image from Docker Hub
FROM nginx:alpine

# Install Google Cloud SDK and required tools
RUN apk add --no-cache curl bash tar python3 py3-pip

# Install Google Cloud SDK
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-455.0.0-linux-x86_64.tar.gz \
    && tar -xf google-cloud-cli-455.0.0-linux-x86_64.tar.gz \
    && ./google-cloud-sdk/install.sh --usage-reporting=false --command-completion=false --path-update=true \
    && rm -rf google-cloud-cli-455.0.0-linux-x86_64.tar.gz

# Install Helm
RUN curl https://get.helm.sh/helm-v3.9.1-linux-amd64.tar.gz -o helm.tar.gz \
    && tar -xvzf helm.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf helm.tar.gz

# Install the gke-gcloud-auth-plugin
RUN gcloud components install gke-gcloud-auth-plugin

# Set the environment variable for using the plugin
RUN echo 'export USE_GKE_GCLOUD_AUTH_PLUGIN=True' >> /etc/profile.d/gke-gcloud-auth-plugin.sh

# Expose port for Nginx
EXPOSE 80

# Command to run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
