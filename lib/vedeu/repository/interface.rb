module Vedeu
  class Interface
    attr_accessor :id, :attributes, :active, :geometry, :name

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

  module ClassMethods
    def interface(name, geometry = {})
      interface_name = name.is_a?(Symbol) ? name.to_s : name

      Interface.create({ name: interface_name, geometry: geometry })
    end
  end

  def self.included(receiver)
    receiver.extend(ClassMethods)
  end
end
