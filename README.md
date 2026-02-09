# 📚  Reading Room

Aplicação web desenvolvida em Ruby on Rails para cadastro e exibição de livros lidos, com autenticação de usuários e integração com a API pública OpenLibrary.

Este projeto foi desenvolvido como parte de um teste técnico, com foco em boas práticas de arquitetura, clareza de código e experiência do usuário.

## Rodando o projeto

- Windows
Para subir o projeto abra o git bash na raiz do projeto e utilize o comando:
 ```bash 
 ./start.sh
 ```

- Linux
Caso esteja utilizando linux será necessário dar permissão para o arquivo, utilize os comandos:
 ```bash 
 chmod +x start.sh 
  ./start.sh
 ```

 
 ## Pré-requisitos
 Docker/Docker compose


## 🧠 Arquitetura e decisões técnicas

Arquitetura MVC (Model–View–Controller) padrão do Rails

Views renderizadas no backend utilizando ERB

Interações dinâmicas feitas com Hotwire (Turbo + Stimulus):

Turbo Frames para carregar conteúdo em modais sem reload

Stimulus para comportamentos pontuais, como abrir e fechar modais

Autorização feita no backend, nunca confiando apenas no frontend

Validações de dados centralizadas nos models

## 🎨 Interface e estilos

Estilização feita com Tailwind CSS

Componentes simples e reutilizáveis

Feedback visual para erros de validação (campos destacados e mensagens claras)

## 🗄️ Banco de dados

Banco de dados SQLite (ambiente de desenvolvimento)

Migrations utilizadas para versionamento do schema


## 🤖 Uso de Inteligência Artificial

O uso de assistentes de IA foi realizado como ferramenta de apoio, principalmente para:

Esclarecimento de conceitos do framework

Revisão de padrões e boas práticas

Todo o código foi revisado, entendido e testado manualmente.

Sugestões inadequadas ou incompletas foram ajustadas para o contexto do projeto.

Exemplo:

- A IA gerou a secret key no arquivo de docker compose na intenção de deixar exposta e commitar ela, alterei imediatamente adicionando a chave ao arquivo .env

- A IA sugeriu inicialmente o uso excessivo de lógica no frontend para controle de estado. Essa abordagem foi corrigida para utilizar Turbo Frames, mantendo a renderização no backend e reduzindo complexidade desnecessária no frontend.

- A Ia adicionou book_search_controller.js na pasta errada de controllers de ruby e nao na pasta de js, corrigi movendo o arquivo para a pasta correta

# 📌 Observações finais (Importante):
Deixei a geração do .env de forma automática para facilitar a instalação para os avaliadores, compreendo que em um projeto real o dev deve gerar sua própria chave.

## Validações básicas implementadas no projeto pensando em regras de negócio.
- Não é permitido adicionar um ano menor que 1000 ou maior que o ano atual.
- Não é permitido adicionar um livro sem titulo ou sem autor.
- Não é permitido criar um cadastro sem email, nome ou senha.
- Caso email e ou senha sejam inválidos não será avisado qual (norma de segurança).

O projeto evita o uso de scaffold, optando por generators pontuais e implementação manual para maior controle do fluxo.

O foco foi clareza, simplicidade e aderência aos requisitos do teste.
