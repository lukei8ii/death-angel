require "bundler/setup"
require "hasu"

class DeathAngel < Hasu::Window
  WIDTH = 768
  HEIGHT = 576

  def initialize
    super(WIDTH, HEIGHT, false)
  end

  def reset

  end

  def update

  end

  def draw

  end

  def button_down(button)
    case button
    when Gosu::KbEscape
      close
    end
  end
end

DeathAngel.run