class SpaceMarine < Chingu::GameObject
  include YamlObject

  attr_accessor :type, :range, :team

  def initialize(options = {})
    super
    @type = options[:type]
    @range = options[:range]
    @team = options[:team]
    @image = Gosu::Image["#{team.to_s}.png"]
    @label = Chingu::Text.create(text: name, x: @x, y: @y, size: 20)
  end

  def setup

  end

  def name
    type.to_s.capitalize
  end
end