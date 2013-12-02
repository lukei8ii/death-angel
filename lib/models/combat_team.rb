class CombatTeam < Chingu::GameObject
  traits :bounding_box, :collision_detection

  attr_accessor :type

  TYPE = %i(red blue yellow green purple gray)
  BORDER = 10

  def initialize(options = {})
    super
    @type = options[:type] || :red
    @image = Gosu::Image["#{@type.to_s}.png"].clone
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