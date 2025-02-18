# Utilisation de l'image Python officielle
FROM python:3.9-slim

# Configuration de l'environnement
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive \
    ROBOT_OPTIONS="--outputdir /workspace/results" \
    CHROMIUM_FLAGS="--no-sandbox --headless --disable-dev-shm-usage" \
    PYTHONPATH="/workspace/tests/resources:/workspace/tests"

# Installation des dépendances système
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    chromium \
    chromium-driver \
    git \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxi6 \
    libxtst6 \
    libasound2 \
    xvfb \
    xauth \ 
    vim \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Vérification de l'installation de Chromium et Chromedriver
RUN xvfb-run --server-args="-screen 0 1920x1080x24" chromium --version && \
    xvfb-run --server-args="-screen 0 1920x1080x24" chromedriver --version

# Installation des packages Python
RUN pip install --no-cache-dir \
    robotframework==6.1.1 \
    robotframework-seleniumlibrary==6.1.3 \
    robotframework-requests==0.9.6 \
    selenium==4.9.1 \
    pytest \
    pylint \
    black \
    ipython 

# Installer Node.js 22 et npm
RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

#Installation de la mise à jour de PIP
    RUN pip install --upgrade pip

# Création de la structure des dossiers
WORKDIR /workspace
RUN rm -rf /workspace/temp-data && mkdir -p /workspace/tests/resources /workspace/temp-data /workspace/results && chmod -R 777 /workspace
