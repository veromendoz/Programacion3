defmodule Plataforma do
  def main do

    nombre_usuario = util.ingresar("ingrese el nombre del usuario" :texto)
    edad_usuario = util.ingresar("ingrese la edad del usuario" :texto)
    credenciales_usuario = util.ingresar("ingrese las credenciales del usuario" :texto)

    def validar_usuario(nombre, edad, credenciales,intentos)do
      unless credenciales do
      {:error}

      end
    end
  end
end




