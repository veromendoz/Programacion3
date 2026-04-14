defmodule Suma do

  # CASO BASE: lista con 1 solo elemento → devuélvelo directo
  def suma([x]), do: x

  # CASO RECURSIVO: parte la lista, suma cada mitad, combínalas
  def suma(lista) do
    mitad = div(length(lista), 2)
    {izq, der} = Enum.split(lista, mitad)
    suma(izq) + suma(der)
  end

end

IO.puts Suma.suma([1, 2, 3, 4, 5])
