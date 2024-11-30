FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential cmake g++ zlib1g-dev libopenmpi-dev openmpi-bin \
    git wget ca-certificates libboost-all-dev libfftw3-dev \
    libcgal-dev libscotch-dev libptscotch-dev \
    libgmp-dev libmpfr-dev libreadline-dev libncurses5-dev \
    libxt-dev libxrender-dev libglu1-mesa-dev libqt5x11extras5 \
    bison flex gcc-9 g++-9 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV FOAM_VERSION OpenFOAM-12
ENV FOAM_REPO https://github.com/OpenFOAM/OpenFOAM-12.git
ENV WM_COMPILER=Gcc
ENV WM_MPLIB=SYSTEMOPENMPI

WORKDIR /opt/openfoam

# Pobranie kodu źródłowego z repozytorium GitHub
RUN git clone $FOAM_REPO /opt/openfoam/${FOAM_VERSION}

# Wymuszenie standardu C++17
RUN sed -i 's/-std=c++11/-std=c++17/' /opt/openfoam/${FOAM_VERSION}/wmake/rules/General/Gcc/c++

# Kompilacja OpenFOAM
RUN cd /opt/openfoam/${FOAM_VERSION} && ./Allwmake -j

RUN echo "source /opt/openfoam/${FOAM_VERSION}/etc/bashrc" >> /etc/bash.bashrc

WORKDIR /opt/openfoam/${FOAM_VERSION}

CMD ["bash"]
