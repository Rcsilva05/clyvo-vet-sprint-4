# Diagrama Entidade–Relacionamento (DER)

> Modelo físico do PostgreSQL do projeto SOLIN, conforme as migrations Flyway V1–V7.

```mermaid
erDiagram
    TB_TUTOR ||--o{ TB_PET : "possui"
    TB_ESPECIE ||--o{ TB_PET : "classifica"
    TB_PET ||--o{ TB_EVENTO : "registra"
    TB_PET ||--o{ TB_ALERTA : "recebe"

    TB_ESPECIE {
        BIGSERIAL id_especie PK
        VARCHAR nm_especie "NOT NULL UNIQUE"
        INTEGER qt_horas_max_urina "NOT NULL"
        INTEGER qt_horas_max_agua "NOT NULL"
    }

    TB_TUTOR {
        BIGSERIAL id_tutor PK
        VARCHAR nm_tutor "NOT NULL"
        VARCHAR ds_email "NOT NULL UNIQUE"
        VARCHAR nr_telefone
        DATE dt_cadastro "NOT NULL"
    }

    TB_PET {
        BIGSERIAL id_pet PK
        VARCHAR nm_pet "NOT NULL"
        VARCHAR ds_raca
        DATE dt_nascimento
        DOUBLE vl_peso_kg
        VARCHAR tp_sexo
        BOOLEAN st_ativo "NOT NULL DEFAULT TRUE"
        BIGINT id_tutor FK "NOT NULL"
        BIGINT id_especie FK "NOT NULL"
    }

    TB_EVENTO {
        BIGSERIAL id_evento PK
        VARCHAR tp_evento "NOT NULL"
        TIMESTAMP dh_evento "NOT NULL"
        VARCHAR tp_origem "NOT NULL"
        VARCHAR ds_observacao
        BIGINT id_pet FK "NOT NULL"
    }

    TB_ALERTA {
        BIGSERIAL id_alerta PK
        VARCHAR tp_nivel "NOT NULL"
        VARCHAR ds_mensagem "NOT NULL"
        TIMESTAMP dh_gerado "NOT NULL"
        BOOLEAN st_resolvido "NOT NULL DEFAULT FALSE"
        BIGINT id_pet FK "NOT NULL"
    }

    TB_USUARIO {
        BIGSERIAL id_usuario PK
        VARCHAR ds_email "NOT NULL UNIQUE"
        VARCHAR ds_senha_hash "NOT NULL"
        VARCHAR nm_usuario "NOT NULL"
        VARCHAR tp_perfil "NOT NULL"
        BOOLEAN st_ativo "NOT NULL DEFAULT TRUE"
        BIGINT id_tutor FK "UNIQUE NULLABLE"
    }

    TB_TUTOR ||--o| TB_USUARIO : "login do tutor"
```

## Coerência com o Diagrama de Classes

Cada entidade JPA do diagrama de classes mapeia diretamente para uma tabela aqui:

| Classe (JPA) | Tabela | PK |
|---|---|---|
| `Tutor` | `TB_TUTOR` | `id_tutor` |
| `Especie` | `TB_ESPECIE` | `id_especie` |
| `Pet` | `TB_PET` | `id_pet` |
| `Evento` | `TB_EVENTO` | `id_evento` |
| `Alerta` | `TB_ALERTA` | `id_alerta` |
| `Usuario` | `TB_USUARIO` | `id_usuario` |

Os enums (`TipoEvento`, `NivelAlerta`, `OrigemEvento`, `Sexo`, `Perfil`) são persistidos como `VARCHAR` pelo Hibernate via `@Enumerated(EnumType.STRING)` — opção escolhida ao invés de `ORDINAL` porque manter a string facilita a leitura direta no banco e evita problemas se a ordem dos valores do enum mudar no futuro.

## Índices

| Índice | Tabela | Colunas | Motivo |
|---|---|---|---|
| `IX_EVENTO_PET_DH` | `TB_EVENTO` | `(id_pet, dh_evento)` | Acelera a query `findUltimoEventoPorTipo` usada pelas Strategies de alerta |

## Cascateamento

O fluxo disponível para pets usa **soft delete** (`ST_ATIVO = false`): preserva eventos e alertas para histórico. As FKs mantêm os vínculos de domínio; exclusões físicas em cascata não são o fluxo de remoção de pets da interface.
