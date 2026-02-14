# Primeiros comandos

Para criar um projeto em elixir, precisamos utilizar o comando **mix new** projeto_maluco. Lembrando que o elixir usa snake_case. Se você veio de outras linguagens, esqueça completamente o camelCase. 

```
mix new 
```

Se você quiser usar um nome no projeto e outro no seu ambiente voce pode usar **mix new aprendendo_lab --app aprendendo_elixir**

```
mix new a --app b
```

Observe a estrutura criada 

```
D:.
└───aprendendo_elixir
    │   .formatter.exs
    │   .gitignore 
    │   mix.exs
    │   README.md (Sim o elixir cria o README.md)
    │
    ├───lib
    │       aprendendo_elixir.ex
    │
    └───test
            aprendendo_elixir_test.exs
            test_helper.exs
```

# 1. Primeiro Hello Word ? 

Abra o arquivo lib/aprendendo_elixir.ex que o Mix criou. Apague o que estiver lá. (Eu sei que ele já vem com um Hello Word, mas bora fazer um novo.)

Vamos começar a escrever nosso primeiro Hello Word:

```ex
defmodule LabZero do
  def hello do
    IO.puts("Olá Mundo ! O laboratório está vivo. Vamos aprender Elixir juntos!")
  end
end

```

## Como rodar:
No terminal, dentro da pasta do projeto (Nesse caso aprendendo_elixir), digite:
> Se você estiver no Windows poder dar conflito entre os comandos iex do Powershell 

Linux:
```bash
iex -S mix
```
PowerShell:
```ps1
iex.bat -S mix
```
---

### Depois, dentro do IEx, chame a função:

```
LabZero.hello()
```

## Resultado:

```ps1
PS D:\Repositorios\Aprendendo Liguagens de Programação\Elixir\aprendendo_elixir> iex.bat -S mix
Erlang/OTP 28 [erts-16.2] [source] [64-bit] [smp:12:12] [ds:12:12:10] [async-threads:1] [jit:ns]

Compiling 1 file (.ex)
Generated aprendendo_elixir app
Interactive Elixir (1.19.5) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> LabZero.hello()                                                                                                                                                                                                   
Olá Mundo ! O laboratório está vivo. Vamos aprender Elixir juntos!
:ok
iex(2)>
```

### Para Sair do mix:

```ps1
Ctrl + C
a
s
```

## Resultado:

```ps1
D:\Repositorios\Aprendendo Liguagens de Programação\Elixir\aprendendo_elixir> iex.bat -S mix
Erlang/OTP 28 [erts-16.2] [source] [64-bit] [smp:12:12] [ds:12:12:10] [async-threads:1] [jit:ns]

Compiling 1 file (.ex)
Generated aprendendo_elixir app
Interactive Elixir (1.19.5) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> LabZero.hello()                                                                                                                                                                                                   
Olá Mundo ! O laboratório está vivo. Vamos aprender Elixir juntos!
:ok
iex(2)>
BREAK: (a)bort (A)bort with dump (c)ontinue (p)roc info (i)nfo
       (l)oaded (v)ersion (k)ill (D)b-tables (d)istribution
a
Deseja finalizar o arquivo em lotes (S/N)? s
D:\Repositorios\Aprendendo Liguagens de Programação\Elixir\aprendendo_elixir>
```
---

# Por que o Elixir Funciona dessa forma? 

porque o Elixir não é apenas uma linguagem, ele é uma interface amigável para uma máquina virtual poderosa chamada BEAM (a máquina virtual do Erlang).


## O que é o BEAM? 

**BEAM** significa Bogdan's Erlang Abstract Machine. É a máquina virtual que executa o código compilado do Erlang (e do Elixir). Ela foi criada pela Ericsson nos anos 80 para resolver um problema específico: manter redes telefônicas funcionando 24/7 sem nunca travar.

Diferente do Windows ou do Java, onde criar uma "Thread" é pesado e consome muita memória, no BEAM um "Processo" é incrivelmente leve (consome cerca de 2 KB de memória).

- Você pode subir milhões de processos simultâneos em um computador comum.

- Cada usuário do WhatsApp, por exemplo, é um processo isolado dentro do **BEAM**. Se um usuário cai, os outros bilhões nem percebem.

No **BEAM**, os processos não compartilham memória, veja ele como a união de uma VM com conatainer e um servidor local, tudo isso junto e misturado. 

Se um processo da sua Calculadora (Exemplo) der erro (como uma divisão por zero mal tratada), apenas aquele processo morre.

Ele não derruba o sistema inteiro. É o famoso conceito de "Let it crash" (Deixe quebrar). O **BEAM** assume que coisas vão dar errado e foca em isolar o erro.

A questão aqui não é robustes em cima de sintaxe ou tratamento de dados, é parar e dizer: "Eu sei que isso vai quebrar, o que eu posso fazer para resolver isso?", ou seja, a robustes se dá pela adaptabilidade, não por trezentas funcionalidades.

Como os processos são isolados, o **BEAM** usa uma relação de Agentes e Supervisores. (Sim, igual uma empresa)

- Um Supervisor é um processo cujo único trabalho é vigiar outros processos.

- Se a sua Calculadora quebrar, o Supervisor percebe em milissegundos e a reinicia para um "estado limpo". É como se o seu computador desse um reboot automático apenas no programa que travou, sem você perceber.

Por essa mesma premissa, o **Elixir** consegue trabalhar com **Hot Swapping** (Troca quente), ou seja, a solução perfeita pra um deploy em um projeto IaC (Infrastructure as Code)

---

# 2. Calculadora (Trabalhando com variáveis, dados e matemática)

Antes de começar, precisamos entender que Elixir tem muitas particularidades, vamos apresentar alguns conceitos:

**Variáveis e Imutabilidade**

O Elixir ele não usa variáveis, ele atribui uma representação baseada em string para apontar para um valor. Sei que falei grego, então vamos descomplicar:

1. O Símbolo = não é "Igual", é casamento.

```ex
x = 10 
```

A "váriavel" x não existe, nós casamos a **String** x com o valor 10. Mas ele segue o padrão de convenção das outras linguagens, ou seja, (Esquerda) recebe (Direita)

Na prática, imagine que você fez uma relação de preços de produtos em um mercado, ou simplificando, uma lista.

Vamos usar dois exemplos 

Em python: 
```python 
mercado = {"banana": 2.50, "sabao": 0.50, "refrigerante": 8.00} 
```

No Elixir ficará assim: 

```ex
mercado = [banana: 2.50, sabao: 0.50, refrigerante: 8.00]
```

Vamos supor uma promoção, e ver como ficaria em cada linguagem: 

Python: 
```python
mercado = {"banana": 2.50, "sabao": 0.50, "refrigerante": 8.00} 
mercado["banana"] = 1.99  
print(mercado) 
>>{"banana": 1.99, "sabao": 0.50, "refrigerante": 8.00}
```

No Elixir: 
```ex
mercado = [banana: 2.50, sabao: 0.50, refrigerante: 8.00]

# Tentativa de "mudar"
novo_mercado = Keyword.put(mercado, :banana, 1.99 )

IO.inspect(mercado)      # [banana: 2.50, sabao: 0.50, refrigerante: 8.00] (Ainda intacto!)
IO.inspect(novo_mercado) # [banana: 1.99, sabao: 0.50, refrigerante: 8.00] (Versão nova para o cliente da promo)
```

> Percebeu como o Python "esmagou" o preço antigo, enquanto no Elixir você preservou a história?

Essa é a grande sacada! No Python, o objeto mercado foi mutado (alterado no lugar). No Elixir, o valor original de 2.50 é sagrado. Ele não morre. O que você fez foi criar uma nova versão da lista, apontando um novo valor para um elemento.

*"Mas se eu ficar criando listas novas, a memória do meu PC vai acabar!"*

O BEAM é esperto. Ele não copia a lista inteira. Ele apenas cria um novo "nó" para a banana, e reaproveita o resto da lista (sabão e refrigerante) na memória. É como se a nova lista fosse um "puxadinho" da antiga. Como o mercado original nunca muda, se você tiver 100 processos "vendedores" consultando o preço ao mesmo tempo, nenhum deles corre o risco de ler um valor pela metade ou um valor que mudou no meio da consulta. **Zero erros de disputa de dados.**