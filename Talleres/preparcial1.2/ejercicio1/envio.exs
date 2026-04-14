defmodule Envio do

  def main do

    peso = "Ingrese el peso del paquete: "
    |> Util.ingresar(:entero)

     cliente = "Tipo de cliente (1=corporativo, 2=estudiante, 3=regular): "
    |> Util.ingresar(:entero)

    cliente = case cliente do
      1 -> :corporativo
      2 -> :estudiante
      3 -> :regular
      _ -> :invalido
    end

    servicio = "Tipo de servicio (1=express, 2=estandar): "
    |> Util.ingresar(:entero)

    servicio = case servicio do
      1 -> :express
      2 -> :estandar
      _ -> :invalido
    end

    case calcular(peso, cliente, servicio) do
      {:ok, resultado}  -> mostrar_resultado(resultado)
      {:error, mensaje} -> Util.mostrar_mensaje("Error: #{mensaje}")
    end
  end

 defp calcular(peso, _cliente, _servicio) when peso <= 0 do
    {:error, "El peso debe ser mayor a 0"}
  end

  defp calcular(_peso, :invalido, _servicio) do
    {:error, "Tipo de cliente inválido"}
  end

  defp calcular(_peso, _cliente, :invalido) do
    {:error, "Tipo de servicio inválido"}
  end

  defp calcular(peso, cliente, servicio) when peso > 0 do
    base      = tarifa_base(peso)
    descuento = calcular_descuento(base, cliente)
    subtotal  = base - descuento
    recargo   = calcular_recargo(subtotal, servicio)
    total     = subtotal + recargo

    {:ok, {base, descuento, subtotal, recargo, total}}
  end

  defp tarifa_base(peso) do
  cond do
    peso <= 1               -> 8000
    peso >= 1 and peso <= 5 -> 12000
    peso > 5                -> 20000
  end
end

  defp calcular_descuento(subtotal, :corporativo),   do: subtotal * 0.15
  defp calcular_descuento(subtotal, :estudiante), do: subtotal * 0.10
  defp calcular_descuento(_subtotal, :regular),  do: 0.0

  defp calcular_recargo(subtotal, :express),   do: subtotal * 0.25
  defp calcular_recargo(_subtotal, :estandar), do: 0

  defp mostrar_resultado({base, descuento, subtotal, recargo, total}) do
    Util.mostrar_mensaje("Tarifa base : $#{base}")
    Util.mostrar_mensaje("Descuento   : $#{descuento}")
    Util.mostrar_mensaje("Subtotal    : $#{subtotal}")
    Util.mostrar_mensaje("Recargo     : $#{recargo}")
    Util.mostrar_mensaje("Total       : $#{total}")
  end

end

Envio.main()
