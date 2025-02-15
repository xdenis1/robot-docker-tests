# Utilisation de l'image Python officielle
FROM python:3.9-slim

# Configuration de l'environnement
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive \
    ROBOT_OPTIONS="--outputdir /workspace/results"

# Installation des dépendances système
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    chromium \
    chromium-driver \
    git \
    # Ajout des outils de développement
    vim \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configuration de Chrome pour le développement
ENV CHROME_OPTIONS="--headless --no-sandbox --disable-dev-shm-usage"

# Installation des packages Python
RUN pip install --no-cache-dir \
    robotframework==6.1.1 \
    robotframework-seleniumlibrary==6.1.3 \
    robotframework-requests==0.9.6 \
    # Outils de développement Python
    pytest \
    pylint \
    black \
    ipython

# Création de la structure des dossiers
WORKDIR /workspace
RUN mkdir -p /workspace/tests/resources /workspace/results

# Les droits d'accès sont importants pour le développement
RUN chmod -R 777 /workspace

# Copier les fichiers de test dans l'image Docker
COPY tests /workspace/tests