require 'spec_helper'
require_relative '../app/aplicacion'

describe 'Aplicacion' do

  def simular_temperatura(temperatura)
    mapping = {
      "request": {
        "method": "GET",
        "urlPath": "/data/2.5/weather"
      },
      "response": {
        "status": 200,
        "body": '{"coord":{"lon":10.99,"lat":44.34},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"base":"stations","main":{"temp":' + (temperatura + 273).to_s + ',"feels_like":284.44,"temp_min":283.74,"temp_max":286.65,"pressure":1001,"humidity":87,"sea_level":1001,"grnd_level":917},"visibility":10000,"wind":{"speed":1.98,"deg":192,"gust":6.53},"clouds":{"all":100},"dt":1698325024,"sys":{"type":2,"id":2044440,"country":"IT","sunrise":1698299062,"sunset":1698336928},"timezone":7200,"id":3163858,"name":"Zocca","cod":200}',
        "headers": {
          "Content-Type": "text/plain"
      }
      }
    }
    Faraday.post('http://localhost:8080/__admin/mappings', mapping.to_json)
  end

  it 'hace_calor cuando la temperatura es mayor a 30C' do
    # docker run --rm -p 8080:8080 wiremock/wiremock:3.2.0
    simular_temperatura(31)
    salida = `API_KEY=no-importa API_URL=http://localhost:8080 ruby app/aplicacion.rb`
    expect(salida.strip).to eq 'Hace calor? => si'
  end

  it 'no hace_calor cuando la temperatura es 27C' do
    # docker run --rm -p 8080:8080 wiremock/wiremock:3.2.0
    simular_temperatura(27)
    salida = `API_KEY=no-importa API_URL=http://localhost:8080 ruby app/aplicacion.rb`
    expect(salida.strip).to eq 'Hace calor? => no'
  end
end
