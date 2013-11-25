class Dice
  SIDES = 5
  SKULLS = 1..3

  def roll
    number = Random.new.rand(SIDES)

    {
      number: number,
      skull: SKULLS.include?(number)
    }
  end
end