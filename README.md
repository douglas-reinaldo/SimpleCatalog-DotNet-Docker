# 🛒 SimpleCatalog API - Docker & .NET Lab

Este projeto é uma API desenvolvida em .NET 8 que serve como um laboratório prático para implementação de conteinerização profissional, segurança de containers e automação de testes em pipelines de build.

---

## 🚀 Por que este projeto foi construído?

O principal objetivo deste projeto foi dominar o ciclo de implantação de aplicações modernas, focando em **DevOps** e **Segurança (Hardening)**. Ele foi estruturado para validar:

1.  **Imagens Otimizadas**: Criação de containers extremamente leves utilizando distribuições Linux específicas para runtime.
2. **Segurança por Padrão**: Execução da aplicação com privilégios mínimos...
3. **Build Confiável**: Integração de testes automatizados...

## 📖 Escopo do Projeto
Para fins estritamente didáticos...
...

---

## 🛠️ Tecnologias Utilizadas

* **Framework:** .NET 8 (ASP.NET Core)
* **Linguagem:** C#
* **Testes Unitários:** xUnit
* **Containerização:** Docker (Alpine Linux)
* **Ambiente de Desenvolvimento:** Visual Studio / VS Code

---

## 🏗️ Diferenciais Técnicos (DevOps & Infra)

### 🐋 Docker Multi-stage Build
O `Dockerfile` utiliza múltiplos estágios para separar o ambiente de construção do ambiente de execução:
* **SDK Stage**: Onde o código é compilado e as dependências são restauradas.
* **Test Stage**: Um "gate" de qualidade onde os testes unitários são executados. Se houver falha nos testes, o build é interrompido imediatamente, impedindo que código quebrado chegue ao registro de imagens.
* **Runtime Stage**: A imagem final contém apenas o necessário para rodar a aplicação, resultando em um container menor e mais rápido de subir.

### 🛡️ Security Hardening (Non-root)
Diferente de configurações padrão que rodam como `root`, este container utiliza o usuário `app` nativo do .NET 8 Alpine. Isso garante que, em caso de uma vulnerabilidade na aplicação, o invasor não tenha acesso total ao sistema de arquivos do host ou do container.

---

## ⚙️ Como Executar

### Via Docker
Para construir e rodar o projeto com segurança e isolamento:

```bash
# Construir a imagem (os testes rodarão automaticamente aqui)
docker build -t simplecatalog-api .

# Executar o container na porta 5000
docker run -d -p 5000:8080 --name catalog-container simplecatalog-api
