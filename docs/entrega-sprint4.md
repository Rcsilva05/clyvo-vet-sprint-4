# Entrega final — Clyvo Vet / SOLIN — 4º Sprint

Este checklist organiza a avaliação e o envio do projeto. As regras do professor e as instruções exibidas no portal da disciplina prevalecem sobre estas orientações; não é possível determinar por esta pasta se o portal exige ZIP, link do GitHub ou outro material complementar.

## Status da publicação e avaliação online

- **Aplicação:** [https://clyvo-vet-sprint-4.onrender.com/solin/login](https://clyvo-vet-sprint-4.onrender.com/solin/login)
- **Banco:** PostgreSQL hospedado no Neon, como serviço separado do Web Service no Render. Não é necessário provisionar outro serviço ou banco para avaliar.
- **Disponibilidade:** o serviço gratuito do Render pode entrar em repouso após inatividade; a primeira requisição depois disso pode demorar.
- **Validação informada pela equipe:** deploy confirmado; registro de evento pela área do tutor e painel veterinário testados na aplicação publicada.

### Roteiro rápido de avaliação

1. Abra a página de login online. Se a primeira abertura demorar, aguarde o serviço gratuito do Render sair do repouso e tente novamente.
2. Na aba **Sou Tutor**, use `tutor.demo@solin.com` / `demo123`. A conta tem o pet de demonstração Luna. Abra **Registrar evento**, escolha Luna, preencha os campos e salve.
3. Encerre a sessão e, na aba **Sou Veterinário**, use `vet.demo@clyvovet.com.br` / `demo123`. Confira o painel de alertas e a lista de pets.
4. As contas são públicas e destinadas somente à demonstração. Não insira dados pessoais, de clientes ou de animais reais. O ambiente online é compartilhado e utiliza o banco Neon.

As credenciais acima são contas de demonstração da aplicação, não credenciais do Render ou do Neon. As mesmas contas estão documentadas no README para a avaliação local; o banco local do Docker Compose é separado do banco online no Neon.

## Evidências e conteúdo do projeto

O repositório inclui os componentes do projeto e evidências de diferentes partes do trabalho:

- `src/`: aplicação Java/Spring Boot, interface web Thymeleaf, API REST e recursos estáticos.
- `pom.xml`, `Dockerfile` e `docker-compose.yml`: dependências e instruções para build e execução local.
- `src/main/resources/db/migration/`: oito migrations Flyway com schema, dados de demonstração e evoluções do banco.
- `docs/`: capturas da interface de tutor e veterinário, formulários, alertas, assistente e evidências de banco/migrations.
- `documentos/diagramas/`: diagramas de classes e entidade-relacionamento.
- `documentos/postman/`: coleção Postman da API REST.
- `documentos/Prints/`: capturas de CRUD, API, Swagger e Postman das etapas anteriores.
- `documentos/Cronograma_Sprint1.docx`: cronograma disponível no material do projeto.
- `README.md`: contexto, arquitetura, tecnologias, instruções locais, credenciais de demonstração e este link para o checklist.

As capturas de migrations refletem a execução que foi registrada quando foram feitas; a imagem de sete migrations é anterior à migration V8. Os scripts versionados em `src/main/resources/db/migration/` incluem a V8.

## ZIP ou link no portal

O formato depende das instruções da disciplina. Confira no portal se é solicitado arquivo `.zip`, link do repositório ou ambos; não envie apenas o ZIP nem apenas o link sem verificar o que foi pedido.

Se o portal aceitar o link, use o [repositório da entrega](https://github.com/Rcsilva05/clyvo-vet-sprint-4), branch `main`. Se pedir um ZIP:

1. Abra o repositório no GitHub e selecione **Code → Download ZIP** na branch `main`.
2. Descompacte o arquivo em uma pasta temporária e confira que há uma pasta raiz com `README.md`, `pom.xml`, `Dockerfile`, `docker-compose.yml`, `src/`, `docs/` e `documentos/` (incluindo diagramas, Postman e cronograma).
3. Confirme que não está enviando `.env`, URL/senha de conexão ao Neon, outros segredos, `.git`, `target/`, `.idea/`, caches, logs ou arquivos temporários. O ZIP baixado do GitHub contém os arquivos versionados e não inclui o histórico `.git` nem arquivos locais ignorados. As credenciais de demonstração que constam no README são para avaliação; não são segredos de infraestrutura.
4. Envie o formato e os arquivos pedidos pelo portal, respeitando limites de tamanho e nomes de arquivo definidos pela disciplina. Guarde o comprovante de envio.

## Execução local (opcional para avaliação)

Na raiz do projeto, com Docker Desktop ativo:

```powershell
docker compose --profile app up -d --build
```

Abra `http://localhost:8080/solin/login`. A conta tutor `tutor.demo@solin.com` / `demo123` tem o pet Luna; a conta veterinário `vet.demo@clyvovet.com.br` / `demo123` acessa o painel clínico. O Compose inicia um PostgreSQL local separado do banco Neon e do serviço Render.

Para encerrar a aplicação e o banco local sem remover o volume de dados:

```powershell
docker compose --profile app down
```

Não use `-v` se quiser preservar os dados locais. O portal pode solicitar outros itens além dos listados aqui; siga sempre as instruções oficiais da disciplina.
