# Finalização da entrega — 4º Sprint

Este checklist separa o que já existe nesta pasta do que depende de publicação ou ação da equipe. Não substitui a conferência final da rubrica do professor.

## Evidências já incluídas

- Capturas de telas de cadastro, login, tutor, alertas, assistente e painel veterinário em `docs/`.
- Diagrama de classes e DER em `documentos/diagramas/` (Mermaid).
- Migrations versionadas de banco em `src/main/resources/db/migration/`.
- A migration V8 associa o pet `Luna` à conta `tutor.demo@solin.com`, para o formulário de eventos ter uma opção de teste.
- Coleção Postman da API em `documentos/postman/SOLIN_API.postman_collection.json`.
- README com contexto do problema, arquitetura, tecnologias, padrões, fluxos, credenciais locais e instruções para executar.
- Dockerfile e perfil Docker Compose para executar a aplicação com PostgreSQL local.

## O que falta para a entrega externa

- **Publicar a aplicação no Render:** seguir o passo a passo em [Implantação no Render com GitHub](../README.md#implantação-no-render-com-github). Enviar esta versão para `Rcsilva05/clyvo-vet-sprint-4`, criar PostgreSQL e Web Service Docker na mesma região, configurar as variáveis secretas e validar login/eventos antes de acrescentar a URL pública ao README. A equipe deve confirmar a criação dos recursos no Dashboard; nenhum recurso foi provisionado por esta alteração.
- **Confirmar o vídeo:** o README mantém um link que já constava no material recebido, mas o conteúdo e a duração não foram verificados. Confirmem ou substituam pelo vídeo do 4º Sprint, com no máximo 15 minutos e participação de todos os integrantes listados no README.
- **Sincronizar o repositório:** publique os arquivos selecionados na branch `main` do novo repositório `https://github.com/Rcsilva05/clyvo-vet-sprint-4`, seguindo as instruções seguras do README. Depois, confirme que o README no GitHub contém a URL online e o link final do vídeo.

## Roteiro sugerido para o vídeo (aprox. 13 minutos)

| Tempo | Demonstração / narrativa |
|---|---|
| 0:00–1:00 | Apresentar equipe, problema de acompanhar a rotina de saúde dos pets e proposta do SOLIN para a Clyvo Vet. |
| 1:00–2:30 | Explicar o fluxo tutor–clínica e a arquitetura em camadas; contextualizar Spring Boot, PostgreSQL e Thymeleaf. |
| 2:30–4:00 | Mostrar o login e os perfis; explicar como Spring Security restringe dados e áreas por papel. |
| 4:00–6:30 | Demonstrar a área do tutor: pets, ficha, registro de evento e como os dados alimentam os alertas. |
| 6:30–8:30 | Explicar Strategy com os limites por espécie e demonstrar alertas amarelo/vermelho usando dados preparados para a apresentação. |
| 8:30–10:00 | Demonstrar o painel veterinário e a resolução de um alerta. |
| 10:00–11:30 | Relacionar DTOs, validação, JPA/Repository e Flyway aos problemas concretos que resolvem; mostrar os diagramas e migrations. |
| 11:30–13:00 | Mostrar a API/coleção Postman, comentar UI/UX e decisões de tecnologia, apresentar o endereço publicado e concluir. Todos os integrantes devem aparecer e participar durante o vídeo. |

Mantenham alguns minutos de margem para a edição e não apresentem alertas como diagnóstico veterinário. Usem contas e dados de demonstração, sem exibir informações pessoais reais.

## Execução local para ensaio

Na raiz `clyvo-vet`, com Docker Desktop ativo:

```powershell
docker compose --profile app up -d --build
```

Abrir `http://localhost:8080/solin/login`. A conta de demonstração veterinária é `vet.demo@clyvovet.com.br` / `demo123`; a conta tutor é `tutor.demo@solin.com` / `demo123` e tem o pet de teste Luna. Para ver os pets de outro tutor, entre com a conta correspondente: `maria.silva@email.com` / `tutor123` (Rex e Mimi) ou `joao.pereira@email.com` / `tutor123` (Thor). A equipe também pode cadastrar um tutor adicional para mostrar o fluxo de criação de conta.

Uma conta nova começa sem pets e, por isolamento entre tutores, o seletor em **Registrar evento** lista apenas os pets vinculados à conta autenticada. Cadastre primeiro um pet pela opção **Cadastrar pet** nessa mesma conta. Ao terminar:

```powershell
docker compose --profile app down
```

Os registros do banco persistem no volume `solin-db-data`; não use a opção `-v` se quiser preservá-los.
