require "awesome_print"
require "pry-byebug"

module Fractal
  class Similar
    INITIAL_POINT = [[0.0,0.0], [1.0,0.0], [1.0,1.0], [0.0,1.0]].freeze

    def initialize(repetition:, translation:, rotation:, size:, size_square: 100.0)
      verify(translation.size, translation, rotation, size)
      @iteration = translation.size.times.map do |i|
        rotation_temp = rotation[i] * Math::PI / 180
        [translation[i], [Math.cos(rotation_temp), Math.sin(rotation_temp)], size[i]]
      end
      @new_points = INITIAL_POINT.map{|t| [t[0]*size_square, t[1]*size_square]}
      @points = @new_points.dup
      repetition.times{|s| build}
    end

    attr_reader :points

    def verify(iteration, translation, rotation, size)
      if rotation.size != translation.size
        raise Fractal::Error.new(
          "Number of rotations different from number of translations",
          {rotations_size: rotation.size, translations_size: translation.size})
      end
      if size.size != translation.size
        raise Fractal::Error.new(
          "Number of sizes different from number of iterations",
          {rotations_size: size.size, translations_size: translation.size})
      end
      translation.each do |t|
        next if t.size == 2
        raise Fractal::Error.new("#{t} is not a valid translation", {wrong_translation: t})
      end
    end

    def build
      new_points = []
      @iteration.each do |i|
        @new_points.each do |po|
          new_points << [
            i[2] * (i[1][0]*po[0]-i[1][1]*po[1]) + i[0][0],
            i[2] * (i[1][1]*po[0]+i[1][0]*po[1]) + i[0][1]
          ]
        end
      end
      @points += new_points
      @new_points = new_points
    end
  end
end
