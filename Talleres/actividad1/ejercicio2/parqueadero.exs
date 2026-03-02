defmodule Parqueadero do

  @moduledoc """
  Sistema de tarifas para parqueadero de centro comercial.
  Calcula la tarifa base según horas y aplica descuentos
  según tipo de cliente, vehículo y día de la semana.
  """

  def main do
    horas    = "Ingrese las horas de permanencia: "
    |> Util.ingresar(:entero)

    cliente  = "Tipo de cliente (1=frecuente, 2=regular): "
    |> Util.ingresar(:entero)

    vehiculo = "Tipo de vehículo (1=eléctrico, 2=convencional): "
    |> Util.ingresar(:entero)

    dia      = "Día (1=fin de semana, 2=entre semana): "
    |> Util.ingresar(:entero)

    tarifa_base = calcular_tarifa_base(horas)

    {sin_descuento, con_descuento} =
      aplicar_descuentos(tarifa_base, cliente, vehiculo, dia)

    generar_desglose(horas, tarifa_base, cliente, vehiculo, dia, sin_descuento, con_descuento)
    |> Util.mostrar_mensaje()
  end

  defp calcular_tarifa_base(horas) do
    cond do
      horas <= 2 -> 3000
      horas >= 3 and horas <= 5 -> 3000 + (horas - 2) * 2500
      horas >= 6 and horas <= 8 -> 3000 + 3 * 2500 + (horas - 5) * 2000
      horas > 8 -> 18000
    end
  end

  defp obtener_descuento(categoria, tipo) do
    case {categoria, tipo} do
      {:cliente,  1} -> 0.15
      {:vehiculo, 1} -> 0.20
      {:dia,      1} -> 0.10
      {_,         2} -> 0.0
    end
  end

  defp aplicar_descuentos(tarifa_base, cliente, vehiculo, dia) do
    total_descuento =
      obtener_descuento(:cliente,  cliente)  +
      obtener_descuento(:vehiculo, vehiculo) +
      obtener_descuento(:dia,      dia)

    con_descuento = tarifa_base - (tarifa_base * total_descuento)
    {tarifa_base * 1.0, con_descuento}
  end

  defp generar_desglose(horas, tarifa_base, cliente, vehiculo, dia, sin_descuento, con_descuento) do

    tipo_cliente  = if cliente  == 1, do: "Frecuente (-15%)",     else: "Regular (sin descuento)"
    tipo_vehiculo = if vehiculo == 1, do: "Eléctrico (-20%)",     else: "Convencional (sin descuento)"
    tipo_dia      = if dia      == 1, do: "Fin de semana (-10%)", else: "Entre semana (sin descuento)"

    sin_desc = sin_descuento |> Float.round(2)
    con_desc = con_descuento |> Float.round(2)

    """
    ================================
      SISTEMA DE PARQUEADERO
    ================================
    Horas de permanencia : #{horas}h
    Tarifa base          : $#{tarifa_base}
    --------------------------------
    Cliente  : #{tipo_cliente}
    Vehículo : #{tipo_vehiculo}
    Día      : #{tipo_dia}
    --------------------------------
    Total sin descuento  : $#{sin_desc}
    Total con descuento  : $#{con_desc}
    ================================
    """
  end

end

Parqueadero.main()
