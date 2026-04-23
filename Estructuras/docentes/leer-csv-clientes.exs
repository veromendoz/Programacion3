defmodule Estructuras do
  def main do
    "clientes.csv"
    |> CSV.leer_csv(&Cliente.convertir_cadena_cliente/1)
    |> Enum.filter(&(&1.edad < 21))
    |> CSV.generar_mensaje_csv(&generar_mensaje/1)
    |> Util.mostrar_mensaje()
  end

  defp generar_mensaje(cliente) do
    altura = cliente.altura |> Float.round(2)
    "Hola #{cliente.nombre}, tu edad es de #{cliente.edad} años y " <>
    "tienes una altura de #{altura}"
  end
end

Estructuras.main()
