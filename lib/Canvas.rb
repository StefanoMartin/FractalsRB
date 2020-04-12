module Fractal
  class Canvas
    def initialize(width: 1000, height: 1000, repetition:, size_square: 100.0,
      fractals:)
      @width = width
      @height = height
      fractal = Fractal::Similar.new(repetition: repetition, size_square: size_square)
      fractals.each{|f| fractal.add(**f)}
      fractal.build
      @points = fractal.points
      @canvas = ChunkyPNG::Canvas.new(width, height, ChunkyPNG::Color::WHITE)
      build
      picture = @canvas.to_image
      picture.save("#{__dir__}/filename.png", :interlace => true)
    end

    def picture
      File.open("#{__dir__}/filename.png")
    end

    def build
      i = -1
      half_width = @width/2
      half_height = @height/2

      @points.each do |point|
        i += 1
        next if i % 4 != 0

        square = [
          ChunkyPNG::Point.new(@points[i][0]+half_width, -@points[i][1]+half_height),
          ChunkyPNG::Point.new(@points[i+1][0]+half_width, -@points[i+1][1]+half_height),
          ChunkyPNG::Point.new(@points[i+2][0]+half_width, -@points[i+2][1]+half_height),
          ChunkyPNG::Point.new(@points[i+3][0]+half_width, -@points[i+3][1]+half_height)
        ]

        @canvas.polygon(square)
      end
    end
  end
end
