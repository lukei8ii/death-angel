class Genestealer < EnhancedGameObject
  TYPES = %i(head tongue claws tail)

  attr_accessor :type, :count
  attr_accessor :label

  def initialize(options={})
    super
    @image = Gosu::Image["genestealer.png"].clone
    @label = Chingu::Text.create(text: @type.to_s.titleize, x: @x, y: @y, size: 20)
    @label.center = 0.5

    # disable until needed
    hide!
    pause!
    @label.hide!
    @label.pause!
  end
end