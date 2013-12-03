class PickTeam < Chingu::GameState
  def initialize(options = {})
    super
    @picks = options[:picks]
  end

  def setup
    @background = Chingu::GameObject.create(x: $window.width / 2, y: $window.height / 2, image: Gosu::Image["space_hulk.jpg"])

    title_text = "Choose your #{@picks} #{'combat team'.pluralize(@picks)}"
    @title = Chingu::Text.create(text: title_text, x: 0, y: 30, size: 30, max_width: $window.width, align: :center)
    self.input = { left_mouse_button: :clicked }

    x_margin = 15
    x_start = DeathAngel::CARD_WIDTH / 2 + x_margin
    y_margin = 150
    @teams = []
    @selected = []

    CombatTeam::TYPE.each_with_index do |c, i|
      x_offset = (DeathAngel::CARD_WIDTH + x_margin) * i + x_start
      @teams << team = CombatTeam.create(type: c, x: x_offset, y: y_margin, factor_x: DeathAngel::CARD_SCALE, factor_y: DeathAngel::CARD_SCALE)
    end

    @submit = Button.create(center_x: 0.5, x: $window.width / 2, y: 300, text: "Start Game", click: -> { submit_teams })
  end

  def submit_teams
    push_game_state Play.new(teams: @selected.map(&:type)) if @selected.size == @picks
  end

  def clicked
    @teams.each do |t|
      if t.collides?({ x: $window.mouse_x, y: $window.mouse_y })
        unless t.selected?
          t.select
          @selected << t
          @selected.shift.deselect if @selected.size > @picks
        end
      end
    end
  end
end