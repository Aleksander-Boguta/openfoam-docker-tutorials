FROM opencfd/openfoam-default:2406

RUN apt-get update && apt-get install -y --no-install-recommends \
    git && \
    git clone https://develop.openfoam.com/Development/openfoam /tmp/openfoam && \
    cp -r /tmp/openfoam/tutorials /usr/lib/openfoam/openfoam2406/tutorials && \
    rm -rf /tmp/openfoam && \
    apt-get remove -y git && apt-get autoremove -y && apt-get clean

USER openfoam

WORKDIR /usr/lib/openfoam/openfoam2406

CMD ["bash"]
