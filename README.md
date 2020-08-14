# Dev Full Cycle - DevOps: Challenge I

## Publicando Imagem Laravel

### Tecnologias Utilizadas

 - PHP 7.3.6
 - Laravel 7.0
 - Docker-compose 1.17.1
 - Docker 19.03.12

### Executando o projeto

1. `git pull https://github.com/paulojp-dev/fullcycle_devops_challenge_1.git`
2. `docker-compose up -d --build`
3. Acessar via navegador: `http://0.0.0.0:8000/`
4. Deve ser exibia a página inicial padrão do Laravel

### Imagem do Laravel no DockerHub

**Link:** https://hub.docker.com/r/paulojp/laravel

Para baixar: `docker pull paulojp/laravel`

Executando a imagem isoladamente:
1. `docker run -d -p 9000:9000 --name laravel paulojp/laravel`
2. Acessar via navegador: `http://0.0.0.0:9000/`
