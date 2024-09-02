# Use the base PostGIS image
FROM postgis/postgis:latest

# Set environment variable to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    osm2pgsql \
    python3-pip \
    bzip2 \
    ca-certificates \
    curl \
    git \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda3 with Python 3.11
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh \
    && /bin/bash /tmp/miniconda.sh -b -p /opt/conda \
    && rm /tmp/miniconda.sh \
    && /opt/conda/bin/conda clean -ya

# Copy the default.style file needed for osm2pgsql
COPY default.style /usr/bin/

# Download the OpenStreetMap data
RUN wget -O /tmp/switzerland-latest.osm.pbf http://download.geofabrik.de/europe/switzerland-latest.osm.pbf

# Reset environment variable
ENV DEBIAN_FRONTEND=dialog