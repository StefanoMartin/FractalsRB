require "awesome_print"

module Fractal
  class Similar
    INITIAL_POINT = [[0.0,0.0], [1.0,0.0], [1.0,1.0], [0.0,1.0]].freeze

    def initialize(repetition:, size_square: 100.0)
      @new_points = INITIAL_POINT.map{|t| [t[0]*size_square, t[1]*size_square]}
      @points = @new_points.dup
      @repetition = repetition
      @iteration = []
    end

    def add(x:, y:, rotation:, size:)
      rotation_temp = rotation* Math::PI / 180
      @iteration << [[x,y], [Math.cos(rotation_temp), Math.sin(rotation_temp)], size]
    end

    attr_reader :points

    def build
      @repetition.times do
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
end
