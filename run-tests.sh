#!/bin/bash

# Nom de l'image Docker
IMAGE_NAME="robot-tests"

# Étape 1 : Construire l'image Docker
echo "📦 Building Docker image..."
docker build -t $IMAGE_NAME .

# Vérifier si l'image a été créée avec succès
if [[ $? -ne 0 ]]; then
  echo "❌ Failed to build the Docker image."
  exit 1
fi

# Étape 2 : Lancer le conteneur avec l'image créée
echo "🚀 Running Docker container..."
docker run --rm \
  -v "$(pwd)/results:/workspace/results" \
  $IMAGE_NAME robot --outputdir /workspace/results /workspace/tests/environment_check.robot

# Vérifier si les tests se sont bien exécutés
if [[ $? -ne 0 ]]; then
  echo "❌ Tests failed."
  exit 1
else
  echo "✅ Tests completed successfully."
fi