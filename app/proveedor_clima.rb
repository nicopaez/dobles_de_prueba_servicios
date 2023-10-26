require 'faraday'

class ProveedorClima

  def initialize(api_key, api_url)
    @api_key = api_key
    @api_url = api_url || 'https://api.openweathermap.org'
  end

  def temperatura
    respuesta_http = Faraday.get("#{@api_url}/data/2.5/weather?lat=44.34&lon=10.99&appid=#{@api_key}")
    respuesta_hash = JSON.parse(respuesta_http.body)
    respuesta_hash['main']['temp'].to_i - 273
  end

end
