defmodule Animal do
  def avanzar(nombre,pid_juez,distancia,meta) when distancia >= meta do
    send(pid_juez,{:fin,nombre})
  end

  def avanzar(nombre,pid_juez,distancia,meta) when distancia < meta do
    send(pid_juez, {:avance,nombre,distancia+1})

    :timer.sleep(:rand.uniform(400))

    avanzar(nombre,pid_juez,distancia+1,meta)
  end
  def correr(nombre,pid_juez,meta) do
    avanzar(nombre,pid_juez,0,meta)
  end

end
