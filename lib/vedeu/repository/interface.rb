module Vedeu
  class Interface
    attr_accessor :id, :attributes, :active, :geometry, :name, :result

    class << self
      def create(attributes = {})
        new(attributes).create
      end
    end

    def initialize(attributes = {})
      @attributes = attributes || {}

      @active     = false
      @geometry   = attributes[:geometry]
      @name       = attributes[:name]
      @result     = nil
    end

    def create
      InterfaceRepository.create(self)

      InterfaceRepository.activate(self.name)

      self
    end

    def initial_state; end

    def geometry
      Geometry.new(@geometry)
    end
  end
end
