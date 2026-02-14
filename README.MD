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

## Por que o Elixir Funciona dessa forma? 

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

### 1. O Símbolo = não é "Igual", é casamento.

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

**Python:**
```python
mercado = {"banana": 2.50, "sabao": 0.50, "refrigerante": 8.00} 
mercado["banana"] = 1.99  
print(mercado) 
>> 
#{"banana": 1.99, "sabao": 0.50, "refrigerante": 8.00}
```

**Elixir:**
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

O BEAM é esperto. Ele não copia a lista inteira. Ele apenas cria um novo "nó" para a banana, e reaproveita o resto da lista (sabão e refrigerante) usando a memória.

Como o mercado original nunca muda, se você tiver 100 processos "vendedores" consultando o preço ao mesmo tempo, nenhum deles corre o risco de ler um valor pela metade ou um valor que mudou no meio da consulta. **Zero erros de disputa de dados.**

---

### 2. Tipagem de dados 

Diferente de linguagens como C# ou Java, você não precisa dizer ao Elixir que um valor é int ou string. Ele descobre sozinho. Mas diferente do JavaScript, ele não deixa você fazer "bagunça" com os tipos.

**Tipagem Dinâmica**

Você pode reatribuir um nome (fazer o rebinding) a qualquer tipo de dado.

```ex
x = 10      # x é um Inteiro
x = "Dez"   # Agora x é uma String. Sem problemas!
```

**Tipagem Forte**

O Elixir não tenta ser "legal" com você. Se você tentar somar um número com uma string, ele não vai converter automaticamente (coerção). Ele vai travar e dizer que os tipos não batem.

**No JavaScript:**
```js  
10 + "5" = "105"
```
**No Elixir:**
```ex
10 + "5" 
> # (ArithmeticError) bad argument in arithmetic expression
```

| Tipo | Exemplo | Descrição |
| :--- | :--- | :--- |
| **Inteiros** | `123`, `1_000` | Números inteiros. O `_` facilita a leitura (ex: `1_000_000`). |
| **Floats** | `3.14` | Números decimais. Devem ter dígitos antes e depois do ponto (ex: `0.5`). |
| **Booleans** | `true`, `false` | Valores lógicos. Internamente, são os átomos `:true` e `:false`. |
| **Átomos** | `:ok`, `:error` | Constantes cujo nome é o próprio valor. Etiquetas leves para a memória. |
| **Strings** | `"Olá"` | Sempre com aspas duplas. Codificadas em UTF-8 (binários). |
| **Listas** | `[1, 2, :ok]` | Dinâmicas. Rápidas para mexer no início, lentas para o final. |
| **Tuplas** | `{:ok, 200}` | Fixas. Rápidas para acessar qualquer posição, mas imutáveis em tamanho. |

**por que `_` em numeros inteiros?**

> O uso do _ em números inteiros (e também em floats) é puramente para legibilidade humana. O compilador do Elixir ignora completamente esses sublinhados na hora de executar.

No seu código, é muito mais fácil bater o olho e entender o valor aqui:

```ex
um_bilhao = 1_000_000_000
```
Diferente de:
```ex 
um_bilhao = 1000000000 # Quantos zeros tem aqui? Ficou na dúvida, né?
```
As **Strings** no Elixir guardam uma surpresa: elas não são como as strings do Python ou C#. Para o BEAM, uma string é um **binário**.

Aqui está o conteúdo para o seu guia, focado no que é essencial para o laboratório:

---

### 3. Strings 

No Elixir, strings são sempre delimitadas por **aspas duplas** (`" "`). Se você usar aspas simples (`' '`), estará criando uma "Lista de Caracteres" (Charlists), que é algo bem diferente e menos comum.

**1. Interpolação (Colocando variáveis no texto)**

O jeito mais fácil de misturar código com texto é usando `#{ }`. É muito parecido com o `f-string` do Python ou o `${ }` do JavaScript.

```ex
nome = "José"
msg = "Olá, #{nome}! Bem-vindo ao Lab."
# Resultado: "Olá, José! Bem-vindo ao Lab."

```

**2. Concatenação (Juntando textos)**

Para juntar duas strings, não usamos o símbolo de `+`. Usamos o operador de junção binária: `<>`.

```ex
saudacao = "Bom dia" <> " " <> "Programador"
# Resultado: "Bom dia Programador"

```

**3. O Segredo: Elixir Strings são Binários**

Como o Elixir foi feito para ser ultra rápido e lidar com sistemas globais, toda string é codificada em **UTF-8**. Isso significa que emojis e acentos funcionam perfeitamente sem esforço.

```ex
String.length("Café ☕") # Resultado: 6
```

**Tabela de Comandos Úteis (Strings)**

| Comando | O que faz | Exemplo |
| --- | --- | --- |
| `String.upcase/1` | Deixa tudo em MAIÚSCULO | `String.upcase("oi") # "OI"` |
| `String.downcase/1` | Deixa tudo em minúsculo | `String.downcase("OLÁ") # "olá"` |
| `String.trim/1` | Remove espaços nas pontas | `String.trim("  limpo  ") # "limpo"` |
| `String.contains?/2` | Verifica se tem um termo | `String.contains?("elixir", "ex") # true` |

As strings no Elixir são potentes e tratadas como binários em UTF-8. 

* **Aspas:** Use sempre aspas duplas `" "`.
* **Interpolação:** Use `#{var}` para inserir valores no texto.
* **Concatenação:** Use o operador `<>` para juntar textos.

**Exemplo Prático:**
```ex
produto = "banana"
preco = 2.50
"O preço da #{produto} é R$ #{preco}" 
# "O preço da banana é R$ 2.5"
```
---

### 4. Operadores Matemáticos

No Elixir, a matemática é direta, mas com uma regra importante sobre divisões.

| Operador | Função | Exemplo |
| :--- | :--- | :--- |
| `+` | Soma | `10 + 5 = 15` |
| `-` | Subtração | `10 - 5 = 5` |
| `*` | Multiplicação | `10 * 5 = 50` |
| `/` | Divisão Real | `10 / 2 = 5.0` (Sempre retorna Float) |

**Divisões Especiais:**
* `div(10, 3)` -> Retorna `3` (Divisão inteira).
* `rem(10, 3)` -> Retorna `1` (Resto da divisão).

**Dica de Ouro:** Como os dados são imutáveis, não existem operadores como `x += 1` ou `x++`. Você sempre gera um novo valor.

--- 

### 5. O Operador Pipe `|>`

O operador Pipe é a identidade do Elixir. Ele serve para encadear funções, criando uma "esteira" de transformação de dados.

* **O que ele faz:** Pega o retorno da função anterior e passa como o primeiro parâmetro para a próxima.
* **Vantagem:** Transforma códigos aninhados e complexos em algo legível de cima para baixo.

**Exemplo prático no Mercado:**
```ex
lista_compras = [leite: 4.50]

lista_final = 
  lista_compras
  |> Keyword.put(:pao, 1.20)
  |> Keyword.put(:cafe, 15.00)

# O resultado de cada linha alimenta a próxima.
```

**Código "Cebola":**

```ex
# Tenta ler de dentro para fora:
novo_mercado = Keyword.put(Keyword.put(mercado, :banana, 1.99), :maca, 3.00)
```
**Código com Pipe (Fluxo natural):**

O operador |> pega o resultado da esquerda e o injeta como o primeiro argumento da função à direita.

```ex 
novo_mercado = 
  mercado
  |> Keyword.put(:banana, 1.99)
  |> Keyword.put(:maca, 3.00)
```

**Exemplo na Calculadora:**

Se quisermos somar dois números e multiplicar o resultado por 2:
```ex
# (5 + 5) * 2
5 
|> Calculadora.somar(5) 
|> Calculadora.multiplicar(2)
# Resultado: 20
```

### 6. Listas e Tuplas

### Listas (`[]`)
São listas encadeadas. Excelentes para coleções onde você adiciona ou remove itens frequentemente.
* **Operadores:** `++` (adicionar), `--` (remover).
* **Acesso:** `hd(lista)` pega o primeiro, `tl(lista)` pega o resto.
* **Performance:** Contar itens com `length/1` é lento em listas gigantes.

São listas encadeadas (linked lists). Cada elemento aponta para o próximo.

- **Concatenação:** Use ``++`` para juntar e ``--`` para remover elementos.

- **Imutabilidade:** Operadores de lista nunca modificam a lista existente; eles sempre retornam uma nova.

- **Head e Tail:** A "cabeça" (hd) é o primeiro elemento, e a "cauda" (tl) é o restante da lista.

- **Performance:** Acessar o tamanho da lista (length/1) é uma operação linear (fica mais lenta conforme a lista cresce), pois o Elixir precisa percorrer todos os itens.

```ex
lista = [1, 2, 3]
hd(lista) # 1
tl(lista) # [2, 3]
```

### Tuplas (`{}`)
Armazenadas de forma contígua. Ideais para estruturas de tamanho fixo.
* **Acesso:** `elem(tupla, indice)` é instantâneo.
* **Tagged Tuples:** Muito usadas para retornos de funções: `{:ok, resultado}`.

Tuplas armazenam elementos de forma contígua na memória.

- Acesso Rápido: Obter o tamanho (tuple_size/2) ou acessar um elemento pelo índice (elem/2) é muito rápido (tempo constante).

- Modificação Cara: Como são contíguas, mudar um elemento (put_elem/3) exige a criação de uma cópia da tupla inteira na memória.

- Uso Comum: São usadas para retornos fixos, como as Tagged Tuples para indicar sucesso ou erro: {:ok, valor} ou {:error, motivo}.

```ex
tupla = {:ok, "hello"}
elem(tupla, 1) # "hello"
```

> **Regra de ouro:** Se o número de elementos pode variar, use **Listas**. Se for fixo (como uma resposta de banco de dados), use **Tuplas**.

# 3. Trabalhado com Funções e Fluxos

No Elixir, a forma como estruturamos o código e tomamos decisões é um pouco diferente das linguagens imperativas como Python ou C.

## Funções Públicas vs. Privadas

Dentro de um módulo, você pode controlar o que é visível para o resto do mundo:

* **Públicas (`def`):** Podem ser chamadas de fora do módulo.
* **Privadas (`defp`):** Só podem ser usadas por outras funções dentro do mesmo módulo. Elas servem para organizar a lógica interna sem expor detalhes desnecessários.

```ex
defmodule Mercado do
  def fechar_conta(lista) do
    total = somar_itens(lista)
    "O total é R$ #{total}"
  end

  # defp cria uma função privada
  defp somar_itens(lista) do
    # Lógica interna que ninguém de fora precisa ver
    Enum.sum(Keyword.values(lista))
  end
end
```

---

## Estruturas de Fluxo (Adeus, `while`)

Aqui está o maior choque: **No Elixir, não existe `while` ou `for` (do tipo loop)**. Como os dados são imutáveis, você não pode ter um contador que aumenta (`i++`). Usamos **Recursão** ou o módulo **`Enum`** para iterar.

### 1. `if` e `unless`

Diferente do Python, o `if` no Elixir é uma expressão: ele sempre retorna um valor.

```ex
# if comum
if preco > 100 do
  "Muito caro"
else
  "Pode comprar"
end

# unless (o inverso do if: "a menos que")
unless conta_paga do
  "Bloquear acesso"
end

```

### 2. `cond` (O substituto do `elif`)

Quando você tem várias condições, em vez de `if/elif/else`, usamos o `cond`. Ele executa a primeira linha que for verdadeira.

```ex
cond do
  2 + 2 == 5 -> "Isso não vai rodar"
  2 * 2 == 4 -> "Isso é verdade!"
  true       -> "Este é o 'else' (sempre verdade)"
end

```

### 3. `case` (O rei do Pattern Matching)

O `case` é a estrutura mais poderosa. Ele tenta "casar" o resultado de uma expressão com diferentes padrões.

```ex
case Calculadora.dividir(10, 0) do
  {:ok, valor}      -> "Resultado: #{valor}"
  {:error, mensagem} -> "Erro detectado: #{mensagem}"
  _                  -> "Qualquer outra coisa (Default)"
end
```

---
