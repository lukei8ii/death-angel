module YamlObject
  extend ActiveSupport::Concern

  module ClassMethods
    def create_from_object(original)
      # create(original_object.attributes.select{ |key, _| attribute_names.include? key })

      # copy = create
      # DeepClone.clone original
      create(Hash[original.attributes.map { |a| [a, original.send(a)] }])
    end

    def attr_accessor(*vars)
      @attributes ||= []
      @attributes.concat vars
      super(*vars)
    end

    def attributes
      @attributes
    end
  end

  def attributes
    self.class.attributes
  end
end