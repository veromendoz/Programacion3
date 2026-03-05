defmodule Aerolinea do

  @moduledoc """
  Sistema de tiquetes de aerolínea de bajo costo.
  Calcula el total según destino y cargos adicionales opcionales.
  """

  def main do
    destino = "Destino (bogota/medellin/cartagena/sanAndres): "
    |> Util.ingresar(:texto)
    |> String.trim()
    |> String.downcase()

    destino = case destino do
      "bogota"    -> :bogota
      "medellin"  -> :medellin
      "cartagena" -> :cartagena
      "san_andres"-> :sanAndres
      _           -> :invalido
    end

    silla   = "¿Desea selección de silla? (s/n): "
    |> Util.ingresar(:texto)

    maleta  = "¿Desea maleta de bodega? (s/n): "
    |> Util.ingresar(:texto)

    seguro  = "¿Desea seguro de viaje? (s/n): "
    |> Util.ingresar(:texto)

    case calcular(destino, silla, maleta, seguro) do
      {:ok, resultado}  -> mostrar_resultado(resultado)
      {:error, mensaje} -> Util.mostrar_mensaje("Error: #{mensaje}")
    end
  end

  defp calcular(destino, _silla, _maleta, _seguro)
    when destino == :invalido do
    {:error, "Destino inválido. Use: bogota, medellin, cartagena o sanAndres"}
  end

  defp calcular(destino, silla, maleta, seguro) do
    tarifa        = tarifa_base(destino)
    cargo_silla   = cargo_silla(silla)
    # Guard verifica si san_andres obliga maleta
    {cargo_maleta, maleta_automatica} = cargo_maleta(destino, maleta)
    cargo_seguro  = cargo_seguro(seguro)

    total = tarifa + cargo_silla + cargo_maleta + cargo_seguro

    {:ok, {destino, tarifa, cargo_silla, cargo_maleta, cargo_seguro, total, maleta_automatica}}
  end

  defp tarifa_base(:bogota),    do: 150000
  defp tarifa_base(:medellin),  do: 180000
  defp tarifa_base(:cartagena), do: 220000
  defp tarifa_base(:sanAndres),do: 320000

  defp cargo_silla("s"), do: 15000
  defp cargo_silla(_),   do: 0

  defp cargo_seguro("s"), do: 12000
  defp cargo_seguro(_),   do: 0

  # Guard: si es san_andres la maleta es obligatoria
  defp cargo_maleta(destino, _maleta) when destino == :sanAndres do
    {45000, true}
  end

  defp cargo_maleta(_destino, "s"), do: {45000, false}
  defp cargo_maleta(_destino, _),   do: {0, false}

  defp mostrar_resultado({destino, tarifa, cargo_silla, cargo_maleta, cargo_seguro, total, maleta_automatica}) do
    Util.mostrar_mensaje("Destino          : #{destino}")
    Util.mostrar_mensaje("Tarifa base      : $#{tarifa}")
    Util.mostrar_mensaje("Selección silla  : $#{cargo_silla}")
    Util.mostrar_mensaje("Maleta de bodega : $#{cargo_maleta}")
    Util.mostrar_mensaje("Seguro de viaje  : $#{cargo_seguro}")
    Util.mostrar_mensaje("Total a pagar    : $#{total}")

    if maleta_automatica do
      Util.mostrar_mensaje("* Maleta agregada automáticamente por destino san_andres")
    end
  end
end

Aerolinea.main()
