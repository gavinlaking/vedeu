module Vedeu
  class Interface
    include Queue

    attr_accessor :id, :attributes, :active, :name

    class << self
      def create(attributes = {})
        new(attributes).create
      end
    end

    def initialize(attributes = {})
      @attributes = attributes || {}

      @active     = false
      @name       = attributes[:name]
      @cursor     = attributes.fetch(:cursor, true)
    end

    def create
      InterfaceRepository.create(self)

      Compositor.arrange(initial_state)

      self
    end

    def update
      dequeue
    end

    def geometry
      @geometry ||= Geometry.new(attributes)
    end

    def colour
      @colour ||= Colour.new([foreground, background])
    end

    def cursor
      @cursor ? Cursor.show : Cursor.hide
    end

    private

    def initial_state
      { name => [Array.new(geometry.height) { '' }] }
    end

    def foreground
      attributes[:fg] || attributes[:foreground]
    end

    def background
      attributes[:bg] || attributes[:background]
    end
  end

  module ClassMethods
    def interface(name, options = {})
      interface_name = name.is_a?(Symbol) ? name.to_s : name

      Interface.create({ name: interface_name }.merge!(options))
    end
  end

  def self.included(receiver)
    receiver.extend(ClassMethods)
  end
end
