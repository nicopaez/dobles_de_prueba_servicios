require 'spec_helper'
require_relative '../app/proveedor_clima'
require_relative '../app/meteorologo'

describe 'Meteorologo' do

  it 'hace_calor cuando la temperatura es mayor a 30C' do
    proveedor_clima = instance_double(ProveedorClima, temperatura: 31)
    meteorologo = Meteorologo.new(proveedor_clima)
    expect(meteorologo.hace_calor?).to be true
  end

  it 'no hace_calor cuando la temperatura es no mayor a 30C' do
    proveedor_clima = instance_double(ProveedorClima, temperatura: 29)
    meteorologo = Meteorologo.new(proveedor_clima)
    expect(meteorologo.hace_calor?).to be false
  end

end
