# Gerenciador de Atividades para Usuários

Uma aplicação web em Rails 7 para gerenciamento de atividades dos usuários.

## Funcionalidades

- CRUD de atividades para usuários autenticados
- Filtragem e ordenação de atividades
- Histórico de modificações das atividades
- Integração com API externa de clima para exibição da temperatura na listagem das atividades

## Pré-requisitos

- Ruby 3.1.0
- Rails 7.0.0
- PostgreSQL

## Instalação

1. Clone o repositório:

`https://github.com/allissonconsorte04/todolist.git`


2. Instale as dependências:

`bundle install`


3. Crie o banco de dados, execute as migrações e popule o banco:

```
rails db:create
rails db:migrate
rails db:seed
```

4. Inicie o servidor:

`rails server`


5. Acesse a aplicação em seu navegador em:

`http://localhost:3000`


## Configuração da API externa de SMS

1. Crie uma conta gratuita em [Twilio](https://twilio.com/) para obter a chave da API.

2. Adicione a chave da API no arquivo `.env`:

```
TWILIO_ACCOUNT_SID=sua_id_do_twilio
TWILIO_AUTH_TOKEN=seu_token_do_twilio
TWILIO_FROM_NUMBER=seu_numero_do_twilio
```



## Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.


