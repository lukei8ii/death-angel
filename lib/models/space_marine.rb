class SpaceMarine < EnhancedGameObject
  attr_accessor :type, :range, :team
  attr_accessor :label

  def initialize(options={})
    super
    @image = Gosu::Image["#{@team}.png"].clone
    # @image = TexPlay.create_image($window, DeathAngel::CARD_WIDTH, DeathAngel::CARD_HEIGHT).fill(0, 0, color: DeathAngel::COLORS[@team])
    # @image = TexPlay.create_blank_image($window, 390, 250).fill(0, 0, color: [1, 0, 0, 1])
    @label = Chingu::Text.create(text: name, x: @x, y: @y, size: 20)
    @label.center = 0.5

    # disable until needed
    hide!
    pause!
    @label.hide!
    @label.pause!
  end

  def name
    type.to_s.titleize
  end
end