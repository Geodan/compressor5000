FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN dotnet tool install -g b3dm.tooling

RUN curl -sL https://deb.nodesource.com/setup_21.x | bash --debug
RUN apt-get install nodejs parallel -yq
RUN npm install -g gltf-pipeline
COPY compress.sh /
RUN chmod +x compress.sh

ENV PATH="/root/.dotnet/tools:${PATH}"    

ENTRYPOINT ["/compress.sh"]
