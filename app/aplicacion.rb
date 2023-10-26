require_relative './proveedor_clima'
require_relative './meteorologo'

class Aplicacion

  def ejecutar()
    proveedor_clima = ProveedorClima.new(ENV['API_KEY'], ENV['API_URL'])
    meteorologo = Meteorologo.new(proveedor_clima)

    respuesta = meteorologo.hace_calor? ? 'si' : 'no'

    puts "Hace calor? => #{respuesta}"
  end

end

if __FILE__ == $0
  Aplicacion.new.ejecutar
end
