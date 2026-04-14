defmodule Matriz do
  def main do
    matriz = [
  [1, 2, 8],
  [3, 4, 1],
  [2, 5, 6]
]
imprimir_diagonal(matriz)
  end
  def imprimir_diagonal(matriz) do
    imprimir_diagonal(matriz, 0)
  end

  def imprimir_diagonal([fila | columna], indice) do
    IO.puts(Enum.at(fila, indice))
    imprimir_diagonal(columna, indice + 1 )
  end

  
end

Recorrer_diagonal.recorrer_matriz(matriz)
