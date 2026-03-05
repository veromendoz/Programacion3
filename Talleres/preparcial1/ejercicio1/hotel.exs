defmodule Hotel do
  def main do
    noches = "Ingrese el numero de noches: "
    |> Util.ingresar(:entero)

    cliente = "Tipo de cliente (frecuente/corporativo/ocasional):"
    |> Util.ingresar(:texto)
    |>String.trim()
    |>String.downcase()

    cliente = case cliente do
    "frecuente"   -> :frecuente
    "corporativo" -> :corporativo
    "ocasional"   -> :ocasional
    _             -> :invalido
    end

    temporada = "Temporada (1 = alta, 2 = baja)"
    |> Util.ingresar(:entero)

    case calcular(noches, cliente, temporada) do
      {:ok, resultado}  -> mostrar_resultado(resultado)
      {:error, mensaje} -> Util.mostrar_mensaje("Error: #{mensaje}")
    end
  end

  defp tarifa_base(noches) when noches <= 2,                 do: 120000
  defp tarifa_base(noches) when noches >= 3 and noches <= 5, do: 100000
  defp tarifa_base(noches) when noches > 5,                  do: 85000

  defp calcular(noches, cliente, temporada)
    when noches > 0
    and cliente in [:frecuente, :corporativo, :ocasional]
    and temporada in [1, 2] do

    tarifa_noche = tarifa_base(noches)
    subtotal     = tarifa_noche * noches

    descuento    = calcular_descuento(subtotal, cliente)
    recargo      = calcular_recargo(subtotal - descuento, temporada)
    total        = subtotal - descuento + recargo

    {:ok, {tarifa_noche, subtotal, descuento, recargo, total}}
  end

  defp calcular(noches, _cliente, _temporada) when noches <= 0 do
    {:error, "El número de noches debe ser mayor a 0"}
  end

  defp calcular(_noches, cliente, _temporada)
    when cliente not in [:frecuente, :corporativo, :ocasional] do
    {:error, "Tipo de cliente inválido"}
  end

  defp calcular(_noches, _cliente, temporada) when temporada not in [1, 2] do
    {:error, "Temporada inválida"}
  end

  defp calcular_descuento(subtotal, :frecuente),   do: subtotal * 0.20
  defp calcular_descuento(subtotal, :corporativo), do: subtotal * 0.15
  defp calcular_descuento(_subtotal, :ocasional),  do: 0.0

  defp calcular_recargo(base, temporada) do
    cond do
      temporada == 1 -> base * 0.25
      temporada == 2 -> 0.0
    end
  end

  defp mostrar_resultado({tarifa_noche, subtotal, descuento, recargo, total}) do
    Util.mostrar_mensaje("================================")
    Util.mostrar_mensaje("       RESERVA      ")
    Util.mostrar_mensaje("================================")
    Util.mostrar_mensaje("Tarifa por noche : $#{tarifa_noche}")
    Util.mostrar_mensaje("Subtotal         : $#{subtotal}")
    Util.mostrar_mensaje("Descuento        : $#{descuento |> Float.round(2)}")
    Util.mostrar_mensaje("Recargo          : $#{recargo   |> Float.round(2)}")
    Util.mostrar_mensaje("--------------------------------")
    Util.mostrar_mensaje("Total a pagar    : $#{total    }")
    Util.mostrar_mensaje("================================")
  end
end
Hotel.main()
