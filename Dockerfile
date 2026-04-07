# Use a specific version to avoid "latest" check delays
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
WORKDIR /app

# COPY only the project file first to cache dependencies
RUN dotnet new console -n EnterpriseApp
WORKDIR /app/EnterpriseApp

# This layer stays cached unless you change dependencies
RUN dotnet restore

# Now copy the rest and build
COPY . .
RUN dotnet publish -c Release -o /out --no-restore