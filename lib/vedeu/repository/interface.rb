module Vedeu
  class Interface
    attr_accessor :id, :attributes, :result

    class << self
      def create(attributes = {})
        new(attributes).create
      end
    end

    def initialize(attributes = {})
      @attributes = attributes
    end

    def create
      InterfaceRepository.create(self)
      self
    end

    def name
      attributes[:name]
    end

    def geometry
      @geometry ||= Geometry.new(options[:geometry])
    end

    def options
      defaults.merge!(attributes)
    end

    # behaviour

    def initial_state
      # raise NotImplementedError, 'Subclasses implement this method.'
    end

    def input
      raise Collapse if evaluate == :stop
    end

    def output
      write
    end

    private

    def evaluate
      @result = CommandRepository.execute(read)
    end

    def read
      Terminal.input
    end

    def write
      Compositor.arrange(@result, self)
    end

    def defaults
      {
        geometry: {
                    y:      1,
                    x:      1,
                    width:  :auto,
                    height: :auto
                  }
      }
    end
  end
end
