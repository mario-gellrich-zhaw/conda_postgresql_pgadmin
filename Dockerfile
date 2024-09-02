# Use the base PostGIS image
FROM postgis/postgis

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

# Install Anaconda3 with Python 3.11
RUN wget https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh -O /tmp/anaconda.sh \
    && /bin/bash /tmp/anaconda.sh -b -p /opt/anaconda3 \
    && rm /tmp/anaconda.sh \
    && /opt/anaconda3/bin/conda install -y python=3.11 \
    && /opt/anaconda3/bin/conda clean -ya

# Add Anaconda to the PATH
ENV PATH /opt/anaconda3/bin:$PATH

# Copy the default.style file needed for osm2pgsql
COPY default.style /usr/bin/

# Download the OpenStreetMap data
RUN wget -O /tmp/switzerland-latest.osm.pbf http://download.geofabrik.de/europe/switzerland-latest.osm.pbf
