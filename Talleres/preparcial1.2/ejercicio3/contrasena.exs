defmodule Contrasena do

  @moduledoc """
  Módulo que valida la fortaleza de una contraseña
  según reglas de longitud, formato y caracteres.
  """

  def main do
    contrasena = "Ingrese la contraseña: "
    |> Util.ingresar(:texto)

    contrasena
    |> validar()
    |> mostrar_resultado()
  end

  defp validar(contrasena) do
    errores = [
      # String.length verifica longitud mínima de 8
      {String.length(contrasena) < 8,
        "Debe tener al menos 8 caracteres"},

      # Si al pasar a minúscula es igual al original, no tiene mayúsculas
      {contrasena == String.downcase(contrasena),
        "Debe contener al menos una letra mayúscula"},

      # Si al eliminar números es igual al original, no tiene números
      {contrasena == String.replace(contrasena, ~r/[0-9]/, ""),
        "Debe contener al menos un número"},

      # String.contains? verifica si hay espacios
      {String.contains?(contrasena, " "),
        "No debe contener espacios"}
    ]

    errores_encontrados = Enum.reduce(errores, [], fn {condicion, mensaje}, acc ->
      if condicion, do: acc ++ [mensaje], else: acc
    end)

    case errores_encontrados do
      [] -> {:ok, "Contraseña segura"}
      _  -> {:error, errores_encontrados}
    end
  end

  defp mostrar_resultado({:ok, mensaje}) do
    Util.mostrar_mensaje("#{mensaje}")
  end

  defp mostrar_resultado({:error, errores}) do
    Util.mostrar_mensaje("Contraseña inválida:")
    Enum.each(errores, fn error ->
      Util.mostrar_mensaje("  - #{error}")
    end)
  end

end

Contrasena.main()
