FROM ghcr.io/syginc/lambda-builder:node20
RUN mkdir /work
WORKDIR /work
COPY scripts/build-on-container.sh /work/build-on-container.sh
RUN /work/build-on-container.sh
