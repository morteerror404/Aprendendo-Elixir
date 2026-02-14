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

# Por onde começar ? 

1. Abra o arquivo lib/lab_zero.ex que o Mix criou. Apague o que estiver lá

Vamos começar a escrever nosso primeiro Hello Word:

```ex

```