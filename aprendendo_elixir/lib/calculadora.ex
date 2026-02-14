defmodule Calculadora do
  @moduledoc """
  Módulo de funções matemáticas básicas para o laboratório.
  """

  # Aqui o Elixir escolhe a função baseada no átomo que passamos (:soma, :sub, etc)
  def calcular(:soma, a, b), do: a + b

  def calcular(:subtracao, a, b), do: a - b

  def calcular(:multiplicacao, a, b), do: a * b

  # Tratamento especial para divisão por zero usando Pattern Matching direto no argumento
  def calcular(:divisao, _a, 0), do: {:error, "Não dividiras por zero, amém!"}
  def calcular(:divisao, a, b), do: {:ok, a / b}

  # Caso o usuário envie algo que não mapeamos
  def calcular(_, _, _), do: {:error, "Operação desconhecida."}
end
