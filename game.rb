require "bundler/setup"
require "active_support/core_ext/string"
require "active_support/concern"
require "active_support/inflector"
require "chingu"
require "hasu"
require "texplay"
require_relative "lib/lib"

ROOT_PATH = File.dirname(File.expand_path(__FILE__))
MEDIA_PATH = File.join(ROOT_PATH, 'media')

class Game < Chingu::Window
  prepend Hasu::Guard

  TITLE = "Space Hulk: Death Angel"

  def initialize
    super(1280, 800, false)
    reset
  end

  def reset
    self.caption = TITLE
    self.cursor = true

    Gosu::Image.clear
    Gosu::Sound.clear
    Gosu::Image.autoload_dirs << File.join(MEDIA_PATH, 'images')
    Gosu::Sound.autoload_dirs << File.join(MEDIA_PATH, 'sounds')

    # binding.pry

    clear_game_states
    push_game_state PickTeam.new(picks: 2)

    self.input = {
      esc: :exit
    }
  end

  # def update
  #   # ...
  # end

  # def draw

  # end
end

module DeathAngel
  SELECTED_COLOR = :white
  SELECTABLE_COLOR = Gosu::Color::GRAY
  BUTTON_COLOR = Gosu::Color::WHITE
  BUTTON_BACKGROUND_COLOR = :cyan
  CARD_IMAGE_WIDTH = 390
  CARD_IMAGE_HEIGHT = 250
  CARD_SCALE = 0.5
  CARD_WIDTH = CARD_IMAGE_WIDTH * CARD_SCALE
  CARD_HEIGHT = CARD_IMAGE_HEIGHT * CARD_SCALE

  COLORS = {
    red: [1, 0, 0, 1],
    green: [0, 1, 0, 1],
    blue: [0, 0, 1, 1],
    # Black = [0, 0, 0, 1]
    # White = [1, 1, 1, 1]
    gray: [0.5, 0.5, 0.5, 1],
    # Alpha = [0, 0, 0, 0]
    purple: [1, 0, 1, 1],
    yellow: [1, 1, 0, 1]
    # Cyan = [0, 1, 1, 1]
    # Orange = [1, 0.5, 0, 1]
    # Brown = [0.39, 0.26, 0.13, 1]
    # Turquoise = [1, 0.6, 0.8, 1]
    # Tyrian = [0.4, 0.007, 0.235, 1]
  }
end

Game.new.show