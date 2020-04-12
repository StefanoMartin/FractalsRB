require "fractalsrb"
require "sinatra"
require "oj"
require "base64"

HEADERS = {
  "Access-Control-Allow-Origin" => "*",
  "Access-Control-Allow-Credentials" => "true",
  "Access-Control-Allow-Methods" => "GET, POST, OPTIONS",
  "Access-Control-Allow-Headers" => "Origin, Content-Type, Accept"
}
# HEADERS_OK = HEADERS.merge({"Content-Type" => "image/png"})

class Front < Sinatra::Base
  options "/fractal" do
    [200, HEADERS, {}]
  end

  post "/fractal" do
    begin
      request.body.rewind
      data = Oj.load(request.body.read, symbol_keys: true)
      file = Fractal::Canvas.new(**data).picture
      [200, HEADERS, Oj.dump({data: Base64.encode64(file.read())}, mode: :json)]
    rescue StandardError => e
      puts e.backtrace
      [500, HEADERS, e.message]
    end
  end
end

Front.start!
