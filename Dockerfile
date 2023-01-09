FROM mcr.microsoft.com/dotnet/core/sdk:3.1

RUN dotnet tool install -g b3dm.tooling --version 0.14

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash --debug
RUN apt-get install nodejs -yq
RUN npm install -g gltf-pipeline
COPY compress.sh /

ENV PATH="/root/.dotnet/tools:${PATH}"    

ENTRYPOINT ["/compress.sh"]