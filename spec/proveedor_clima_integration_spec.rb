require 'spec_helper'
require_relative '../app/proveedor_clima'

describe 'ProveedorClima' do

  xit 'invoca a open weather' do
    open_weather_key = ENV['API_KEY']
    proveedor_clima = ProveedorClima.new(open_weather_key,nil)
    expect(proveedor_clima.temperatura).to be < 300
  end

end
