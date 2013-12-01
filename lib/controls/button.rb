class Button < Chingu::GameObject
  traits :bounding_box, :collision_detection

  def initialize(options = {})
    super
    @text = options[:text]
    @click = options[:click]
    @margin = options[:margin] || 5
    @color = options[:color] || DeathAngel::BUTTON_COLOR
    @background_color = options[:background_color] || DeathAngel::BUTTON_BACKGROUND_COLOR

    @label = Chingu::Text.create(text: @text, color: @color, x: @x, y: @y, size: 30, zorder: @zorder + 1)
    x_offset = @center_x * @label.width
    y_offset = @center_y * @label.height
    @label.x += @margin - x_offset
    @label.y += @margin - y_offset

    self.y += @margin

    @image = TexPlay.create_blank_image($window, @label.width + @margin, @label.height + @margin).rect(0, 0, @label.width + @margin, @label.height + @margin, color: DeathAngel::BUTTON_BACKGROUND_COLOR, fill: true)

    puts "width: #{@width}"
    puts "height: #{@height}"
  end

  def setup
    self.input = { left_mouse_button: :clicked }
  end

  def clicked
    @click.call if @click.respond_to?(:call) && self.collides?({ x: $window.mouse_x, y: $window.mouse_y })
  end
end