defmodule Cupon do

  @moduledoc """
  Módulo que valida un código de cupón promocional
  según reglas de longitud, formato y caracteres.
  """

  def main do
    cupon = "Ingrese el código del cupón: "
    |> Util.ingresar(:texto)

    cupon
    |> validar()
    |> mostrar_resultado()
  end

  defp validar(cupon) do
    errores = [
      {String.length(cupon) < 10,
        "Debe tener al menos 10 caracteres"},

      # Si al pasar a minúscula es igual al original, no tiene mayúsculas
      {cupon == String.downcase(cupon),
        "Debe contener al menos una letra mayúscula"},

      # Si al eliminar los números es igual al original, no tiene números
      {cupon == String.replace(cupon, ~r/[0-9]/, ""),
        "Debe contener al menos un número"},

      {String.contains?(cupon, " "),
        "No debe contener espacios en blanco"}
    ]

    errores_encontrados = Enum.reduce(errores, [], fn {condicion, mensaje}, acc ->
      if condicion, do: acc ++ [mensaje], else: acc
    end)

    case errores_encontrados do
      [] -> {:ok, "Cupón válido"}
      _  -> {:error, Enum.join(errores_encontrados, " y ")}
    end
  end

  defp mostrar_resultado({:ok, mensaje}) do
    Util.mostrar_mensaje("#{mensaje}")
  end

  defp mostrar_resultado({:error, mensaje}) do
    Util.mostrar_mensaje("El cupón no es válido:")
    Util.mostrar_mensaje("  #{mensaje}")
  end

end

Cupon.main()
