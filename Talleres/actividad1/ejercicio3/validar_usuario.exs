defmodule ValidarUsuario do

  @moduledoc """
  Módulo que valida un nombre de usuario para una plataforma
  académica según reglas de longitud, formato y caracteres permitidos.
  """

  def main do
    nombre = "Ingrese el nombre de usuario: "
    |> Util.ingresar(:texto)

    nombre
    |> validar()
    |> mostrar_resultado()
  end

  defp validar(nombre) do
    longitud = nombre |> String.length()

    errores = [
      {longitud < 5 or longitud > 12,
        "Debe tener entre 5 y 12 caracteres (tiene #{longitud})"},

      {nombre != String.downcase(nombre),
        "Debe estar completamente en minúscula"},

      {String.contains?(nombre, " "),
        "No debe contener espacios"},

      {String.contains?(nombre, "@") or String.contains?(nombre, "#") or
       String.contains?(nombre, "$") or String.contains?(nombre, "%"),
        "No debe contener caracteres especiales (@, #, $, %)"},

      {nombre |> String.replace(~r/[a-z]/, "") |> String.length() == longitud,
        "Debe contener al menos una letra"}
    ]

    # Filtra solo los que fallaron (condicion == true)
    errores_encontrados = errores

    # Enum.filter recorre cada tupla {condicion, mensaje} de la lista
    # y se queda SOLO con las que tienen condicion = true (las que fallaron)
    # El _ ignora el mensaje en este paso, solo nos importa la condicion
    |> Enum.filter(fn {condicion, _} -> condicion end)

    # Enum.map recorre el resultado del filter
    # y extrae SOLO el mensaje de cada tupla, ignorando el true con _
    # al final errores_encontrados es una lista de strings con los errores
    |> Enum.map(fn {_, mensaje} -> mensaje end)

    if errores_encontrados == [] do
      {:ok, "Usuario válido"}
    else
      {:error, errores_encontrados}
    end
  end

  defp mostrar_resultado({:ok, mensaje}) do
    Util.mostrar_mensaje(" #{mensaje}")
  end

  defp mostrar_resultado({:error, errores}) do
    Util.mostrar_mensaje(" Usuario inválido:")
    Enum.each(errores, fn error ->
      Util.mostrar_mensaje("  - #{error}")
    end)
  end

end

ValidarUsuario.main()
