defmodule Calculadora do
  @moduledoc """
  Módulo de funções matemáticas básicas para o laboratório.
  """

  @decimais {:zero, :um, :dois, :"três", :quatro, :cinco, :seis, :sete, :oito, :nove, :dez}
  @dez_mais {:Onze, :Doze, :Treze, :Quatorze, :Quinze, :Dezesseis, :Dezessete, :Dezoito, :Dezenove}
  @dezena {:Dez, :Vinte, :Trinta, :Quarenta, :Cinquenta, :Sessenta, :Setenta, :Oitenta, :Noventa}

  def soma(a, b), do: a + b
  def sub(a, b), do: a - b
  def mult(a, b), do: a * b

  def divisao(a, b) do
    if b != 0 do
      a / b
    else
      "Erro: Divisão por zero!"
    end
  end

  def diga_numero(num) do
    dez = div(num, 10)
    uni = rem(num, 10)

    cond do
      num <= 10 -> elem(@decimais, num)
      num < 20  -> elem(@dez_mais, uni - 1)
      num >= 20 and num < 100 and uni == 0 -> elem(@dezena, dez - 1)
      num >= 20 and num < 100 -> "#{elem(@dezena, dez - 1)} e #{elem(@decimais, uni)}"
      true -> "Número fora do intervalo."
    end
  end

  def menuL1 do
    IO.puts("\n--- Calculadora Elixir ---")
    IO.puts("1. Soma | 2. Sub | 3. Mult | 4. Div | 5. Extenso")
    op = IO.gets("Escolha: ") |> String.trim()
    executar_opcao(op)
  end

  defp executar_opcao("5") do
    num = IO.gets("Digite o número: ") |> String.trim() |> String.to_integer()
    IO.puts("Extenso: #{diga_numero(num)}")
    menuL1()
  end

  defp executar_opcao(op) when op in ["1", "2", "3", "4"] do
    {a, b} = menuL2()
    res = case op do
      "1" -> soma(a, b)
      "2" -> sub(a, b)
      "3" -> mult(a, b)
      "4" -> divisao(a, b)
    end
    IO.puts("Resultado: #{res}")

    if is_number(res) and res > 0 and res < 100, do: menuL3(round(res))
    menuL1() 
  end

  defp executar_opcao(_), do: IO.puts("Tchau!")

  def menuL2 do
    a = IO.gets("Num 1: ") |> String.trim() |> String.to_integer()
    b = IO.gets("Num 2: ") |> String.trim() |> String.to_integer()
    {a, b}
  end

  def menuL3(num) do
    if (IO.gets("Ver por extenso? (s/n): ") |> String.trim()) == "s" do
      IO.puts("Extenso: #{diga_numero(num)}")
    end
  end


  def main do
    menuL1()
  end
end
