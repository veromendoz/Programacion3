defmodule Cine do

  @moduledoc """
  Sistema de control de sillas disponibles en un cine.
  Usa un mapa donde la clave es el número de sala
  y el valor es el número de sillas libres.
  """

  def main do
    # Mapa inicial con tres salas y sus sillas libres
    salas = %{1 => 10, 2 => 5, 3 => 8}

    Util.mostrar_mensaje("Salas disponibles: #{inspect(salas)}")

    numero_sala = "Ingrese el número de sala: "
    |> Util.ingresar(:entero)

    cantidad = "Ingrese la cantidad de sillas a reservar: "
    |> Util.ingresar(:entero)

    reservar_sillas(salas, numero_sala, cantidad)
  end

  def reservar_sillas(salas, numero_sala, cantidad) do
    case Map.get(salas, numero_sala) do
      # La sala no existe
      nil ->
        Util.mostrar_mensaje("Sala no encontrada")

      # No hay suficientes sillas
      sillas_libres when sillas_libres < cantidad ->
        Util.mostrar_mensaje("No hay suficientes sillas disponibles")

      # Reserva exitosa
      sillas_libres ->
        salas_actualizadas = Map.put(salas, numero_sala, sillas_libres - cantidad)
        Util.mostrar_mensaje("Reserva exitosa")
        Util.mostrar_mensaje("Salas actualizadas: #{inspect(salas_actualizadas)}")
        salas_actualizadas
    end
  end

end

Cine.main()
