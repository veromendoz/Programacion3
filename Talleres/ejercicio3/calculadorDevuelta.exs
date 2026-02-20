defmodule CalculadorDevuelta do
  def main do
    valor_total = "Ingrese el valor total de la factura: "
    |>Util.ingresar(:entero)

    valor_entregado = "Ingrese el valor entregado para el pago: "
    |>Util.ingresar(:entero)

    calcular_devuelta(valor_entregado,valor_total)
    |>generar_mensaje()
    |>Util.mostrar_mensaje()
  end

  defp calcular_devuelta(valor_total,valor_entregado)do
    valor_total-valor_entregado
  end

  defp generar_mensaje(devuelta)do
    "la devuelta es #{devuelta}"
  end
end
CalculadorDevuelta.main()
