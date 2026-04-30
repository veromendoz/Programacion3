defmodule MatrizOps do

  # S1: suma debajo de la diagonal principal
  def suma_debajo_diag(matriz) do
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
  end

  # S2: promedio de toda la matriz
  def promedio(matriz) do
    {suma, count} =
      matriz
      |> List.flatten()
      |> Enum.reduce({0, 0}, fn val, {s, c} ->
        {s + val, c + 1}
      end)

    suma / count
  end

  def main do
    matriz = [
      [60, 22, 41, 5],
      [13, 33, 44, 5],
      [89, 10, 100, 99],
      [5, 101, 6, 34]
    ]

    # Lanzar tareas (procesos)
    t1 = Task.async(fn -> suma_debajo_diag(matriz) end)
    t2 = Task.async(fn -> promedio(matriz) end)

    # Esperar resultados
    a = Task.await(t1)
    b = Task.await(t2)

    # S3
    c = a * b

    # S4
    IO.puts("Resultado C = #{c}")
  end
end

# Ejecutar
MatrizOps.main()
