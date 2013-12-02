class Genestealer < EnhancedGameObject
  TYPES = %i(head tongue claws tail)

  attr_accessor :type, :count
end