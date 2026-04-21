defmodule Estructuras do
  def main do
    "Docentes_Uniquindio_20240817.csv"
    |> Docente.leer_csv()
    |> filtrar_datos_interes()
    |> Docente.generar_mensaje_docente(&generar_mensaje/1)
    |> Util.mostrar_mensaje()
  end

  defp generar_mensaje(docente) do
    "#{docente.periodo}, #{docente.formacion}, #{docente.vinculacion}"
  end
end

Estructuras.main()
