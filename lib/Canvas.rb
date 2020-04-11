require "chunky_png"
require_relative "Similar"
require_relative "Error"
require "json"

module Fractal
  class Canvas
    def initialize(width: 1000, height: 1000, **args)
      @width = width
      @height = height
      @points = Fractal::Similar.new(**args).points
      # @canvas = ChunkyPNG::Image.new(16, 16, ChunkyPNG::Color::TRANSPARENT)
      @canvas = ChunkyPNG::Canvas.new(width, height, ChunkyPNG::Color::WHITE)
      build
      picture = @canvas.to_image
      picture.save("#{__dir__}/filename.png", :interlace => true)
    end

    def build
      i = -1
      # @canvas.setLocation()
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


# Fractal::Canvas.new(repetition: 6, translation: [[21,23]], rotation: [ 30], size: [ 0.8])
Fractal::Canvas.new(repetition: ARGV[0].to_i, translation: JSON.parse(ARGV[1]), rotation: JSON.parse(ARGV[2]), size: JSON.parse(ARGV[3]), size_square: JSON.parse(ARGV[4]), width: JSON.parse(ARGV[5]), height: JSON.parse(ARGV[6]))

# ruby lib/Canvas.rb 8 [[0,100],[50,150]] [45,-45] [0.7,0.7]
# ruby lib/Canvas.rb 8 [[0,200],[100,300]] [45,-45] [0.72,0.72] 200 3000 3000
