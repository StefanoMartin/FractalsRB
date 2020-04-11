require "fractalsrb"
require "sinatra"
require "oj"
require "pry-byebug"

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
      [200, HEADERS, Fractal::Canvas.new(**data).picture]
    rescue StandardError => e
      puts e.backtrace
      [500, HEADERS, e.message]
    end
  end
end

Front.start!
