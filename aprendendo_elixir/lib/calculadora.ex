defmodule Calculadora do
  @moduledoc """
  Módulo de funções matemáticas básicas para o laboratório.
  """

  def soma(a, b) do
    a + b
  end

  def sub(a, b ) do
    a - b
  end

  def mult(a, b) do
    a * b
  end
  
  def div(a, b) do
    if b != 0 do
      a / b
    else
      "Divisão por zero não é permitida."
    end
  end

end
