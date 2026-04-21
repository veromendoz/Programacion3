defmodule Estructura do
  def main do
    "\nIngrese los datos del cliente"
    |> Cliente.ingresar(:clientes)
    |> Cliente.escribir_csv("cliente.csv")
    |> generar_mensaje_clientes()
    |> Util.mostrar_mensaje()
  end
  defp crear_lista_clientes() do
    [
      Cliente.crear("Ana", 16, 1.70),
      Cliente.crear("Juan", 20, 1.72),
      Cliente.crear("Diana", 48, 1.73),
      Cliente.crear("Julian", 51, 1.60),
      Cliente.crear("Isabella", 6, 1.55),
      Cliente.crear("Sara", 8, 1.45),
    ]
  end

  defp generar_mensaje(cliente) do
    altura = cliente.altura |> Float.round(2)
    "Hola #{cliente.nombre}, tu edad es de #{cliente.edad} años y " <> "tienes una altura de #{altura}\n"
  end

  def generar_mensaje_clientes(lista_clientes) do
    lista_clientes
    |> Enum.map(&generar_mensaje/1)
    |> Enum.join
  end
end
Estructura.main()
