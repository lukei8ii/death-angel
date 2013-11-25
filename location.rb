class Location
  attr_reader :name, :type, :terrain, :left_blip, :right_blip, :activate, :on_enter

  def initialize
    @name = 'Launch Control Room'
    @type = 4
    @terrain = [
      { side: :left, type: :dark_corner, position: 1, from: :top },
      { side: :left, type: :control_panel, position: 3, from: :top },
      { side: :right, type: :ventilation_duct, position: 2, from: :bottom },
      { side: :right, type: :corridor, position: 1, from: :bottom }
    ]
    @left_blip = 6
    @right_blip = 6
    @activate = "Place a Support Token on this card or roll a die. If the roll is equal or less than the number of Support Tokens on this card, Space Marines win. Otherwise there is no effect."
  end
end