class EnhancedGameObject < Chingu::GameObject
  def initialize(options={})
    super
    attributes.each do |a|
      send("#{a}=", options[a])

      puts "#{a}: #{send(a)}" if options[:debug]
    end

    puts "\n" if options[:debug]
  end

  def attributes
    self.class.attributes
  end

  class << self
    def attr_accessor(*vars)
      @attributes ||= []
      @attributes.concat vars
      super(*vars)
    end

    def attributes
      @attributes
    end
  end
end