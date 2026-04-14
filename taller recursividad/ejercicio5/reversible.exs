defmodule Reversible do
  def main do
    numero = Util.ingresar("Ingrese un número entero positivo: ", :entero)
    resultado = es_reversible(numero)
    Util.mostrar_mensaje("#{numero} es reversible?: #{resultado}")
  end

  def es_reversible(n) when n <= 0, do: false

  def es_reversible(n) do
    invertido = invertir(n, 0)
    suma = n + invertido
    todos_impares(suma)
  end

  defp invertir(0, acum), do: acum
  defp invertir(n, acum) do
    invertir(div(n, 10), acum * 10 + rem(n, 10))
  end

  defp todos_impares(0), do: true
  defp todos_impares(n) do
    if rem(rem(n, 10), 2) != 0 do
      todos_impares(div(n, 10))
    else
      false
    end
  end
end

Reversible.main()
