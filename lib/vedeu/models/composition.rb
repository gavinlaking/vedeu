module Vedeu
  class Composition

    attr_reader :attributes

    # @param attributes [Hash]
    # @param block [Proc]
    # @return [Hash]
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

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

    # @return [Array]
    def interfaces
      @interfaces ||= if attributes[:interfaces].nil? || attributes[:interfaces].empty?
        []

      else
        [ attributes[:interfaces] ].flatten.map do |attrs|
          stored = Buffers.retrieve_attributes(attrs[:name])

          combined = stored.merge(attrs) do |key, s, a|
            key == :lines && s.empty? ? a : s
          end

          Interface.new(combined)
        end

      end
    end

    # @return [String]
    def to_s
      interfaces.map(&:to_s).join
    end

    private

    def defaults
      {
        interfaces: []
      }
    end

  end
end
