defmodule Util do

  def mostrar_mensaje(mensaje) do
    mensaje
    |> IO.puts()
  end

  def mostrar_error(mensaje) do
    IO.puts(:standard_error,mensaje)
  end

  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end

  def ingresar(mensaje, :entero) do
    try do
      mensaje
      |> IO.gets()
      |> String.trim()
      |> String.to_integer()
    rescue
      ArgumentError ->
        IO.puts(:standard_error, "Error, se espera que ingrese un numero entero")
        mensaje
        |> ingresar(:entero)
    end
  end

end
