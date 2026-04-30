defmodule MatrizOps do

  # S1: suma debajo de la diagonal principal
  def suma_debajo_diag(matriz, parent) do
    suma =
      matriz
      |> Enum.with_index()
      |> Enum.reduce(0, fn {fila, i}, acc ->
        fila
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {val, j}, acc2 ->
          if i > j do
            acc2 + val
          else
            acc2
          end
        end)
      end)

    send(parent, {:s1, suma})
  end

  # S2: promedio de toda la matriz
  def promedio(matriz, parent) do
    {suma, count} =
      matriz
      |> List.flatten()
      |> Enum.reduce({0, 0}, fn val, {s, c} ->
        {s + val, c + 1}
      end)

    promedio = suma / count
    send(parent, {:s2, promedio})
  end

  def main do
    matriz = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]

    parent = self()

    # Lanzar procesos
    spawn(fn -> suma_debajo_diag(matriz, parent) end)
    spawn(fn -> promedio(matriz, parent) end)

    # Esperar resultados
    a =
      receive do
        {:s1, val} -> val
      end

    b =
      receive do
        {:s2, val} -> val
      end

    # S3
    c = a * b

    # S4
    IO.puts("Resultado C = #{c}")
  end
end

# Ejecutar
MatrizOps.main()
