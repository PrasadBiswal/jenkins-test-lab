# STAGE 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Create a dummy console app for testing the pipeline
RUN dotnet new console -n EnterpriseApp
WORKDIR /src/EnterpriseApp
RUN dotnet publish -c Release -o /app/publish

# STAGE 2: Create the final tiny image
FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build /app/publish .

# Tell the container what to run
ENTRYPOINT ["dotnet", "EnterpriseApp.dll"]