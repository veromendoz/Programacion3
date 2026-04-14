defmodule Util do
  def ingresar(mensaje, :entero) do
    try do
      mensaje
      |> IO.gets()
      |> String.trim()
      |> String.to_integer()
    rescue
      ArgumentError ->
        "Error, se espera que ingrese un numero entero \n"
        |> IO.puts(:standard_error)

        mensaje
        |> ingresar(:entero)
    end
  end
end
