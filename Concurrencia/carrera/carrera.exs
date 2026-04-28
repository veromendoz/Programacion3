Code.require_file("Animal.ex")
defmodule Carrera do
  def main do
    pid_juez= self()
    meta= 10

    competidores=["Tortuga", "Liebre", "Perro"]
    Enum.each(competidores, fn nombre -> spawn(Animal,:correr,[nombre,pid_juez,meta]) end)

    resultados(%{}, length(competidores))
  end

  def resultados(resultados,animales_restantes) do
     receive do
      {:avance, nombre, distancia} ->
        IO.puts("#{nombre} avanzó a #{distancia}")
        resultados(resultados, animales_restantes)

      {:fin, nombre} ->
        IO.puts("🏁 #{nombre} llegó a la meta!")
        nuevos_resultados = Map.put(resultados, nombre, :llego)

        # cuando el primero llega, declaramos el ganador
        if map_size(resultados) == 0 do
          IO.puts("🎉 ¡#{nombre} es el ganador!")
        end

        if animales_restantes > 1 do
          resultados(nuevos_resultados, animales_restantes - 1)
        else
          IO.puts("Carrera terminada.")
        end
    after
      3000 ->
        IO.puts("⏰ Fin de la carrera (tiempo agotado).")
    end
  end

end
Carrera.main()
