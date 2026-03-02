defmodule HoraActual do

  @moduledoc """
  Módulo que obtiene la hora actual del sistema y saluda
  al usuario según el rango horario en que se encuentre.
  """

  def main do
    # Solicita el nombre del usuario por teclado
    nombre = "Ingrese su nombre: "
    |> Util.ingresar(:texto)

    # :calendar.local_time/0 retorna {{año, mes, día}, {hora, min, seg}}
    # elem(1) extrae la parte de la hora y con pattern matching
    # se desestructura la tupla para obtener solo la hora
    {hora, _minuto, _segundo} =
      :calendar.local_time() |> elem(1)

    # Genera el saludo según la hora y lo muestra en consola
    obtener_saludo(hora, nombre)
    |> Util.mostrar_mensaje()
  end

  @doc """
  Retorna el saludo personalizado según el rango horario.
  """
  defp obtener_saludo(hora, nombre) do
    cond do
      hora >= 0  and hora < 12  -> "Buenos días #{nombre}"
      hora >= 12 and hora < 18  -> "Buenas tardes #{nombre}"
      hora >= 18 and hora <= 23 -> "Buenas noches #{nombre}"
    end
  end

end

HoraActual.main()
