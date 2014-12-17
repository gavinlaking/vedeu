module Vedeu

  # A composition is a collection of interfaces.
  #
  # @api private
  class Composition

    attr_reader :attributes

    # Builds a new composition, ready to be rendered to the screen.
    #
    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Hash]
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

    # Returns a new instance of Composition.
    #
    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Composition]
    def initialize(attributes = {}, &block)
      @attributes = defaults.merge(attributes)

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    # Returns the class responsible for defining the DSL methods of this model.
    #
    # @return [DSL::Composition]
    def deputy
      Vedeu::DSL::Composition.new(self)
    end

    # Returns a collection of interfaces associated with this composition.
    #
    # @return [Array]
    def interfaces
      @interfaces ||= Interface.coercer(attributes[:interfaces])
    end

    # Returns the view attributes for a Composition, which will always be none,
    # as a composition is a merely a collection of interfaces.
    #
    # @return [Hash]
    def view_attributes
      {}
    end

    private

    # The default values for a new instance of Composition.
    #
    # @return [Hash]
    def defaults
      {
        interfaces: []
      }
    end

  end # Composition

end # Vedeu
