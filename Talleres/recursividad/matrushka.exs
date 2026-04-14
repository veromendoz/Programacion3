defmodule Matrushka do
  def main do

    numero_matrushka = "Ingrese un numero: "
    |> Util.ingresar(:entero)

  def imprimir_matrushka(numero) when numero > 1 do
      for i <- numero_matrushka..1//-1 do
        IO.puts("Abriendo matrushka #{i}")
      end

      for i <- 1..numero_matrushka do
        IO.puts("Cerrando matrushka #{i}")
      end
    end
  end
end
Imprimir_matrushka.main()
