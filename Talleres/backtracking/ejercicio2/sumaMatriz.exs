def module SumaMatriz do
  def suma (matriz),do: suma_filas(matriz)

  defp suma_filas([]), do: 0

  defp  suma_filas([fila | resto])do
     suma_elementos (fila) + suma_filas(resto)
  end

  defp suma_elementos([]), do: 0

  defp  suma_elementos([i | resto])do
     i + suma_elementos(resto)
  end

end
