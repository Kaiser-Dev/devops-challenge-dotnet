# Prepare container to build in
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-container
WORKDIR /workspace

# Copy project into build container's WORKDIR
COPY . ./

# Build, test, publish
RUN dotnet restore
RUN dotnet publish -c Release -o outDir --no-restore
RUN dotnet test outDir/DevOpsChallenge.SalesApi.Business.UnitTests.dll

# Setup runtime container, copy build output in
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build-container /workspace/outDir .
ENTRYPOINT ["DevOpsChallenge.SalesApi.exe"]
