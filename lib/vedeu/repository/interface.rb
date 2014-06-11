module Vedeu
  class Interface
    attr_accessor :id, :active, :attributes, :result, :name, :geometry

    class << self
      def create(attributes = {})
        new(attributes).create
      end
    end

    def initialize(attributes = {})
      @attributes = attributes || {}
      @name       = attributes[:name]
      @active     = false
      @geometry   = Geometry.new(attributes[:options][:geometry])
    end

    def create
      InterfaceRepository.create(self)

      InterfaceRepository.activate(self.name)

      self
    end

    def origin(index = 0)
      Position.set(geometry.vy(index), geometry.vx)
    end

    def initial_state
      # raise NotImplementedError, 'Subclasses implement this method.'
    end

    def input
      raise Collapse if evaluate == :stop
    end

    def output
      Compositor.arrange(@result, self) unless @result.nil? || @result.empty?
    end

    private

    def evaluate
      @result = Input.evaluate(read)
    end

    def read
      Terminal.input
    end
  end
end
