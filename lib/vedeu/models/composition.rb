module Vedeu
  class Composition

    attr_reader :attributes

    # Builds a new composition, which is a collection of interfaces, ready to be
    # rendered to the screen.
    #
    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Hash]
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

    # Initialises a new Composition object which is a container for a collection
    # of interfaces.
    #
    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Composition]
    def initialize(attributes = {}, &block)
      @attributes = defaults.merge!(attributes)

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    # Returns a collection of interface attributes associated with this
    # composition. When used to create views, the stored interface geometry is
    # combined with the view attributes to create a new interface.
    #
    # @return [Array]
    def interfaces
      return [] if no_interfaces_defined?

      @interfaces ||= [ attributes[:interfaces] ].flatten.map do |attrs|
        stored = Buffers.retrieve_attributes(attrs[:name])

        combined = stored.merge(attrs) do |key, s, a|
          key == :lines && s.empty? ? a : s
        end

        Interface.new(combined)
      end
    end

    # Returns the complete escape sequence which this composition renders to.
    # This is used by {Vedeu::Terminal.output} to draw the view.
    #
    # @return [String]
    def to_s
      interfaces.map(&:to_s).join
    end

    private

    # A new Composition will have no interfaces associated by default.
    #
    # @api private
    # @return [Hash]
    def defaults
      {
        interfaces: []
      }
    end

    # Returns a boolean depending on whether there are associated interfaces.
    #
    # @api private
    # @return [TrueClass|FalseClass]
    def no_interfaces_defined?
      attributes[:interfaces].nil? || attributes[:interfaces].empty?
    end

    # @api private
    def method_missing(method, *args, &block)
      @self_before_instance_eval.send(method, *args, &block)
    end

  end
end
