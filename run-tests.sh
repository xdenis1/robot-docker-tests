#!/bin/bash
docker run --rm -it \
    -v "/Users/deniskochlyak/robot-docker-tests/tests:/tests" \
    -v "/Users/deniskochlyak/robot-docker-tests/tests/results:/tests/results" \
    robot-tests /bin/bash
