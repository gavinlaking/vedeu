module Vedeu

  class ColourCoercer

    # @param value [Vedeu::Colour|Hash<Symbol => Fixnum|String|Symbol>]
    # @return [Vedeu::Colour]
    def self.coerce(value)
      new(value).coerce
    end

    # @param value [Hash<Symbol => Fixnum|String|Symbol>]
    def self.from_hash(value)
      new(value).from_hash
    end

    # @param value [Vedeu::Colour|Hash<Symbol => Fixnum|String|Symbol]
    # @return [Vedeu::ColourCoercer]
    def initialize(value)
      @value = value
    end

    # @return [Vedeu::Colour]
    def coerce
      return value if colour?

      if hash?
        Vedeu::ColourCoercer.from_hash(value)

      else
        build

      end
    end

    # @return [Vedeu::Colour]
    def from_hash
      return build unless value

      if colour_key?
        Vedeu::ColourCoercer.coerce(value[:colour])

      elsif background? || foreground?
        build_from_hash(value)

      else
        build

      end
    end

    protected

    # @!attribute [r] colour
    # @return [void]
    attr_reader :value

    private

    # @return [Vedeu::Colour]
    def build
      Vedeu::Colour.new
    end

    # @param value [Hash<Symbol => Fixnum|String|Symbol>]
    # @return [Vedeu::Colour]
    def build_from_hash(value)
      Vedeu::Colour.new(value)
    end

    # @return [Boolean]
    def colour?
      value.is_a?(Vedeu::Colour)
    end

    # @return [Boolean]
    def hash?
      value.is_a?(Hash)
    end

    # @return [Boolean]
    def background?
      value.key?(:background)
    end

    # @return [Boolean]
    def colour_key?
      value.key?(:colour)
    end

    # @return [Boolean]
    def foreground?
      value.key?(:foreground)
    end

  end # ColourCoercer

end # Vedeu
