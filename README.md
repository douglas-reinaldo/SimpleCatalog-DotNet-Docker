# 🛒 SimpleCatalog API — Docker, .NET & CI/CD Lab

Este projeto é uma API desenvolvida em **.NET 8** que funciona como um **laboratório prático de containerização profissional**, com foco em **boas práticas de Docker, segurança de containers e automação de build e release via CI/CD**.

O objetivo não é a complexidade do domínio da aplicação, mas sim a **qualidade do processo de entrega**.

---

## 🚀 Por que este projeto foi construído?

Este projeto foi criado para consolidar conhecimentos sobre o **ciclo completo de entrega de aplicações modernas**, abordando conceitos fundamentais de **DevOps**, **Docker** e **segurança por padrão**.

Os principais pontos validados foram:

1. **Imagens Otimizadas**  
   Uso de *multi-stage builds* para gerar imagens finais enxutas, contendo apenas o runtime necessário para execução da aplicação.

2. **Segurança por Padrão (Hardening)**  
   Execução da aplicação como usuário **não-root**, reduzindo a superfície de ataque e seguindo boas práticas de segurança em containers.

3. **Build Confiável e Reprodutível**  
   Integração de **testes automatizados** diretamente no processo de build da imagem, garantindo que apenas código validado possa gerar artefatos de release.

4. **Automação de Release (CI/CD)**  
   Publicação automática de imagens Docker versionadas a partir de **tags Git**, garantindo releases imutáveis e rastreáveis.

---

## 📖 Escopo do Projeto

Para fins **estritamente didáticos**, a aplicação implementa uma API simples, suficiente para demonstrar:

- containerização correta de uma aplicação .NET
- separação clara entre build, testes e runtime
- automação de pipelines de CI e CD
- publicação de imagens em registry remoto

O foco está no **processo**, não na regra de negócio.

---

## 🛠️ Tecnologias Utilizadas

- **Framework:** .NET 8 (ASP.NET Core)
- **Linguagem:** C#
- **Testes Unitários:** xUnit
- **Containerização:** Docker (Alpine Linux)
- **CI/CD:** GitHub Actions
- **Registry:** GitHub Container Registry (GHCR)
- **Ambiente de Desenvolvimento:** Visual Studio / VS Code

---

## 🏗️ Diferenciais Técnicos (DevOps & Infra)

### 🐋 Docker Multi-stage Build

O `Dockerfile` utiliza múltiplos estágios para separar responsabilidades:

- **Build Stage (SDK):**  
  Restaura dependências e compila a aplicação.

- **Test Stage (Quality Gate):**  
  Executa testes unitários durante o build.  
  Caso algum teste falhe, o processo é interrompido imediatamente, impedindo a geração da imagem.

- **Runtime Stage:**  
  Contém apenas os artefatos publicados da aplicação, resultando em uma imagem menor, mais segura e mais rápida de inicializar.

---

### 🛡️ Security Hardening (Non-root)

O container executa a aplicação utilizando o usuário **`app`**, padrão das imagens oficiais do .NET 8 Alpine, em vez de `root`.

Isso garante que, em caso de exploração de alguma vulnerabilidade:
- o impacto seja limitado
- não haja privilégios administrativos dentro do container

Essa abordagem segue práticas recomendadas de segurança em ambientes containerizados.

---

### 🔄 CI/CD com Releases Imutáveis

O projeto implementa dois workflows distintos:

- **CI (Continuous Integration):**  
  Valida build e testes a cada push.

- **CD (Continuous Delivery):**  
  Disparado a partir de **tags Git versionadas**, gerando imagens Docker **imutáveis** publicadas no GitHub Container Registry.

Cada versão da aplicação é rastreável, reproduzível e pronta para consumo em runtime.

---

## ⚙️ Como Executar

### Via Docker (imagem local)

```bash
# Build da imagem (testes executam automaticamente)
docker build -t simplecatalog-api .

# Executar o container
docker run -d -p 5000:8080 --name catalog-container simplecatalog-api


