defmodule EsPerfecto do
  def main do
    numero = 6
    esPerfecto(numero,1,0)
    |>IO.puts()
  end

  def esPerfecto(1,_,_), do: true
  def esPerfecto(numero,divisor,suma) when divisor >= numero, do: numero == suma
  def esPerfecto(numero,divisor,suma) do
    if rem(numero, divisor) == 0 do
      esPerfecto(numero, divisor + 1, suma + divisor)
    else
      esPerfecto(numero, divisor + 1, suma)
    end
  end
end
EsPerfecto.main()
