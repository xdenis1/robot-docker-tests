#!/bin/bash
docker build -t robot-tests .devcontainer
docker run --rm \
    -v "$(pwd)/tests:/tests" \
    -v "$(pwd)/tests/results:/tests/results" \
    robot-tests
