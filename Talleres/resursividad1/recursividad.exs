defmodule Recursividad do

  def main do
    lista = [1,2,3,4,5,6]
    imprimir_lista(lista)
  end
  def imprimir_lista ([]) do
    IO.puts("Termino")
  end

  def imprimir_lista([x|lista])do
    IO.puts("ida #{x}")
    imprimir_lista(lista)
    IO.puts("vuelta #{x}")
  end
end
Recursividad.main()
