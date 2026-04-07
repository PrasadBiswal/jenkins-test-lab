FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# CACHE LAYER: Only copy the project file and restore
# This stays cached unless you add new NuGet packages
RUN dotnet new console -n EnterpriseApp
WORKDIR /src/EnterpriseApp
RUN dotnet restore

# BUILD LAYER: Now copy the rest and build
COPY . .
RUN dotnet publish -c Release -o /out