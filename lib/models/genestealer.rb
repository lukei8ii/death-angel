class Genestealer < Chingu::GameObject
  TYPES = %i(head tongue claws tail)

  attr_reader :type, :count
end