FROM mcr.microsoft.com/dotnet/sdk:6.0

RUN dotnet tool install -g b3dm.tooling --version 1.0.4

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash --debug
RUN apt-get install nodejs -yq
RUN npm install -g gltf-pipeline
COPY compress.sh /

ENV PATH="/root/.dotnet/tools:${PATH}"    

ENTRYPOINT ["/compress.sh"]
