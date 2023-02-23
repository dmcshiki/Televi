# Televi
## A new project made to learn swift and mobile development
### O desafio consiste em elaborar um aplicativo que obtenha os dados desta API, apresentando-os de forma simples e acessível, seguindo os padrões de usabilidade da plataforma. Preze pela qualidade e não pela velocidade, utilize o tempo que lhe foi dado da melhor forma possível.
#### Requisitos:
-O projeto deve ser desenvolvido utilizando uma das seguintes tecnologias: -- Flutter (Dart); -- Android Nativo (Kotlin ou Java); -- iOS Nativo (Swift);
-O aplicativo deve ter no mínimo duas telas. Na primeira deve ser mostrada uma lista dos filmes (com imagem e título, ou só imagem). Ao selecionar um filme desta lista, o usuário deve ser redirecionado para uma tela de detalhes, onde mais informações devem ser exibidas. Você não precisa mostrar todas as informações que a API te der sobre os filmes.
-Você precisa manter o usuário informado de que a aplicação está baixando/processando os dados.
-Utilize algum padrão de arquitetura de software (MVP, MVVM, MVC, Clean Architecture, etc).
-Todo o código deve ser enviado para algum repositório git remoto público (Github, Bitbucket, etc).
-Utilize alguma biblioteca de terceiro para realizar as chamadas HTTP. Você é livre para utilizar quantas bibliotecas quiser em seu projeto.
-Realizar tratamento de erros. *O que acontece se o dispositivo estiver sem internet ou o servidor não responder corretamente?
-Bônus: (obrigatório para candidatos a vagas CLT)
-Realizar o armazenamento local (cache) das informações da API. *Após ter realizado o download das informações de forma bem sucedida pela primeira vez, o aplicativo deve guardá-las localmente para que o usuário possa visualizá-las offline caso deseje. Informações da API:
-Para obter a listagem dos filmes, basta realizar uma requisição HTTP utilizando o método GET no seguinte endpoint: https://desafio-mobile.nyc3.digitaloceanspaces.com/movies
-Para obter informações detalhadas de um determinado filme, basta adicionar o ID do mesmo ao final do endpoint anterior. Então se quisermos, por exemplo, obter os detalhes do filme de ID 240, basta realizar um GET no seguinte endpoint: https://desafio-mobile.nyc3.digitaloceanspaces.com/movies/240
