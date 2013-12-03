class CombatTeam < Chingu::GameObject
  traits :bounding_box, :collision_detection

  attr_accessor :type
  attr_accessor :label

  TYPE = %i(red blue yellow green purple gray)
  BORDER = 10

  def initialize(options = {})
    super
    @type = options[:type] || :red
    @image = Gosu::Image["#{@type.to_s}.png"].clone
    @label = Chingu::Text.create(text: type.to_s.titleize, x: @x, y: @y, size: 20, zorder: zorder + 1)
    @label.center = 0.5
    @label.color = Gosu::Color::BLACK if @type == :yellow
  end

  # def draw
  #   super
  #   # $window.draw_rect(self.bounding_box, DeathAngel::SELECTED_COLOR, zorder + 1) if selected
  #   @image.rect(BORDER, BORDER, self.width - BORDER, self.height - BORDER, color: DeathAngel::SELECTED_COLOR, thickness: BORDER * 2) if selected
  # end

  def select
    @selected = true
    @image.rect(BORDER, BORDER, @image.width - BORDER, @image.height - BORDER, color: DeathAngel::SELECTED_COLOR, thickness: BORDER * 2)
  end

  def deselect
    @selected = false
    @image = Gosu::Image["#{@type.to_s}.png"].clone
  end

  def selected?
    @selected
  end

  def name
    type.to_s.capitalize
  end
end