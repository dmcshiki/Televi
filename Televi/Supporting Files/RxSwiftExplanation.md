# Tome as perguntas abaixo como norte e faça uma apresentação para a Comissão de Treinamento Mobile que responda às seguintes perguntas: 

## 1. O que é um Observable? 
### R: é um objeto a ser escutado e emite eventos baseado em um fluxo de dados.

## 2. O que é um Observer?
### R: é um objeto que notifica uma alteracao em um observable.

## 3. Para que servem os operadores map, flatMap, do(onNext), do(onError), filter, catchError e catchErrorJustReturn? Cite exemplos nos quais cada um deles poderia ser aplicado.
### R: Map - cria um novo array baseado em uma colecao ja existente, transformando os dados de acordo com a necessidade.
    FlatMap - cria um novo array com dados mapeados baseado em uma colecao ja existente, sua diferenca com o map é que o flatmap transforma os dados em uma colecao unica.
    do(onNext) - executa determinada tarefa depois que um novo evento acontece.
    do(onError) - executa quando um obersable emite um erro.
    filter - cria um novo array com apenas os elementos filtrados.
    catchError - trata um erro.
    catchErrorJustReturn - similar ao catchError, porem, apenas retorna um erro padrao inves de uma tratativa do mesmo.

## 4. O que é um Single?
### R: é uma especializacao de um observable que emite dados apenas do resulto de um evento.

## 5. O que é um Completable?
### R: uma especializacao de um observable que emite apenas o resultado de um evento e nao emite dados.

## 6 .O que faz a função Single.zip?
### R: O zip unifica o resultado do fluxo de dados em um só.

## 7. O que faz a função Observable.merge?
### R: O merge unifica o fluxo de dados de dois observable em um só.

## 8. O que é um Disposable?
### R: Um objeto que pode ser dispensado quando deixa de ser necessario para que nao ocupe espaco na memoria.

## 9. Para que serve uma DisposeBag?
### R: Cria um conjunto de disposables que serao desalocados simultaneamente. Serve para nao precisar desalocar individualmente cada um.

## 10. Diferenças entre HOT Observable e COLD Observable
### R: O Hot observable é quando os dados sao gerados fora do observable e o cold é quando os dados sao gerados dentro do observable.

## 11. O que é um Subject?
### R: Subject é a juncao do observable com o observer. Ele é utilizado para quando queremos um multicasting.
