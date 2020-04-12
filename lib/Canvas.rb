require "base64"

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
      Oj.dump({data: Base64.encode64(File.read("#{__dir__}/filename.png"))}, mode: :json)
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

# a = Time.now
# Fractal::Canvas.new(repetition: ARGV[0].to_i, translation: JSON.parse(ARGV[1]), rotation: JSON.parse(ARGV[2]), size: JSON.parse(ARGV[3]), size_square: JSON.parse(ARGV[4]), width: JSON.parse(ARGV[5]), height: JSON.parse(ARGV[6]))
# puts Time.now - a

# ruby lib/Canvas.rb 8 [[0,100],[50,150]] [45,-45] [0.7,0.7]
# ruby lib/Canvas.rb 8 [[0,200],[100,300]] [45,-45] [0.72,0.72] 200 3000 3000
