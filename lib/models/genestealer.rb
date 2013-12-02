class Genestealer < Chingu::GameObject
  TYPES = %i(head tongue claws tail)

  attr_accessor :type, :count
end