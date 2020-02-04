FROM syginc/lambda-builder:node12
RUN mkdir /work
WORKDIR /work
COPY scripts/build-on-container.sh /work/build-on-container.sh
RUN /work/build-on-container.sh
