require "bundler/setup"
require "active_support/core_ext/string"
require "chingu"
require "hasu"
require "texplay"
require_relative "lib/lib"

ROOT_PATH = File.dirname(File.expand_path(__FILE__))
MEDIA_PATH = File.join(ROOT_PATH, 'media')

module DeathAngel
  SELECTED_COLOR = Gosu::Color::WHITE
  SELECTABLE_COLOR = Gosu::Color::GRAY
  BUTTON_COLOR = Gosu::Color::WHITE
  BUTTON_BACKGROUND_COLOR = :cyan
end

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

Game.new.show