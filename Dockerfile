# Use a imagem base do .NET 8.0 SDK para compilar o projeto
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copie os arquivos do projeto e restaure as dependências
COPY *.csproj .
RUN dotnet restore

# Copie todo o código e compile o projeto
COPY . .
RUN dotnet publish -c Release -o /app/publish

# Use a imagem base do .NET 8.0 Runtime para executar o aplicativo
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copie os arquivos publicados da etapa de build
COPY --from=build /app/publish .

# Exponha a porta 80 (ou a porta que você deseja usar)
EXPOSE 80

# Defina o comando de entrada para executar a API
ENTRYPOINT ["dotnet", "APItempoDIO.dll"]