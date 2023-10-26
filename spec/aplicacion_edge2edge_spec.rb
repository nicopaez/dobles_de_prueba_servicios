require 'spec_helper'
require_relative '../app/aplicacion'
require 'webmock/rspec'

describe 'Aplicacion' do

  def simular_temperatura(temperatura)
    WebMock.disable_net_connect!(allow_localhost: true)
    respuesta_simulada = { "coord": { "lon": 10.99, "lat": 44.34 }, "weather": [{ "id": 804, "main": "Clouds", "description": "overcast clouds", "icon": "04d" }], "base": "stations", "main": { "temp": 273 + temperatura, "feels_like": 284.44, "temp_min": 283.74, "temp_max": 286.65, "pressure": 1001, "humidity": 87, "sea_level": 1001, "grnd_level": 917 }, "visibility": 10000, "wind": { "speed": 1.98, "deg": 192, "gust": 6.53 }, "clouds": { "all": 100 }, "dt": 1698325024, "sys": { "type": 2, "id": 2044440, "country": "IT", "sunrise": 1698299062, "sunset": 1698336928 }, "timezone": 7200, "id": 3163858, "name": "Zocca", "cod": 200 }
    stub_request(:get, "https://api.openweathermap.org/data/2.5/weather?appid=no-importa&lat=44.34&lon=10.99").
      with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Faraday v2.7.5'
        }).
      to_return(status: 200, body: respuesta_simulada.to_json, headers: {})
  end

  it 'hace_calor cuando la temperatura es 31C' do
    ENV['API_KEY'] = 'no-importa'
    simular_temperatura(31)
    $stdout = StringIO.new
    aplicacion = Aplicacion.new

    aplicacion.ejecutar

    expect($stdout.string.strip).to eq 'Hace calor? => si'
  end

  it 'No hace_calor cuando la temperatura es 29C' do
    ENV['API_KEY'] = 'no-importa'
    simular_temperatura(29)
    $stdout = StringIO.new
    aplicacion = Aplicacion.new()

    aplicacion.ejecutar()

    expect($stdout.string.strip).to eq 'Hace calor? => no'
  end

end
