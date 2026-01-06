# ESTAGIO 1: Compilacao e Testes (SDK)
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build

# Define o diretorio de trabalho no estagio de build
WORKDIR /source

# 1. Copiar arquivos de projeto (.csproj) para restaurar dependencias
# Isso aproveita o cache do Docker e acelera o build
# Copia o csproj da API para src/SimpleCatalog.Api/
COPY ["SimpleCatalog.Api/SimpleCatalog.Api.csproj", "src/SimpleCatalog.Api/"]
# Copia o csproj dos testes para src/SimpleCatalog.Tests/
COPY ["SimpleCatalog.Tests/SimpleCatalog.Tests.csproj", "src/SimpleCatalog.Tests/"]


# Restaura dependencias da API
RUN dotnet restore "src/SimpleCatalog.Api/SimpleCatalog.Api.csproj"
# Restaura dependencias dos testes
RUN dotnet restore "src/SimpleCatalog.Tests/SimpleCatalog.Tests.csproj"


# 2. Copiar todo o resto do codigo para as pastas correspondentes
COPY SimpleCatalog.Api/ src/SimpleCatalog.Api/
COPY SimpleCatalog.Tests/ src/SimpleCatalog.Tests/


# 3. EXECUTAR OS TESTES
# Se os testes falharem, o build para aqui e a imagem nao e gerada.
# Executa os testes em modo Release
RUN dotnet test "src/SimpleCatalog.Tests/SimpleCatalog.Tests.csproj" --configuration Release --no-restore


# 4. Publicar a API
# Gera os arquivos publicados da API em /app/publish
RUN dotnet publish "src/SimpleCatalog.Api/SimpleCatalog.Api.csproj" -c Release -o /app/publish --no-restore


# ESTAGIO 2: Imagem Final de Execucao (Runtime)
# Usa uma imagem menor do runtime do ASP.NET Core (Alpine)
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS final

# Define o diretorio de trabalho na imagem final
WORKDIR /app

# Hardening: Mudar para o usuario nao-root 'app' para melhorar a seguranca
USER app

# Copiar apenas os arquivos publicados (sem codigo fonte ou testes)
# Origem: stage-build /app/publish -> Destino: stage-final /app
COPY --from=build /app/publish .

# Porta padrao do .NET 8 para usuario nao-root
# Documenta que o container escuta na porta 8080
EXPOSE 8080

# Comando para iniciar a aplicacao
ENTRYPOINT ["dotnet", "SimpleCatalog.Api.dll"]