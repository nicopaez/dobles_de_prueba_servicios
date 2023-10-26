class Meteorologo

  def initialize(proveedor_clima)
    @proveedor_clima = proveedor_clima
  end

  def hace_calor?
    @proveedor_clima.temperatura() > 30
  end
end
