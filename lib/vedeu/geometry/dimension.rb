module Vedeu

  # A Dimension is either the height or width of an entity.
  #
  class Dimension

    # @param (see #initialize)
    # @return [Array<Fixnum>]
    def self.pair(attributes = {})
      new(attributes).pair
    end

    # Returns a new instance of Vedeu::Dimension.
    #
    # @param attributes [Hash<Symbol => Fixnum, NilClass>]
    # @option attributes d [Fixnum|NilClass] The starting value (y or x).
    # @option attributes dn [Fixnum|NilClass] The ending value (yn or xn).
    # @option attributes d_dn [Fixnum|NilClass] A width or a height.
    # @option attributes default [Fixnum|NilClass] The terminal width or height.
    # @option attributes options [Hash]
    # @return [Vedeu::Dimension]
    def initialize(attributes = {})
      @d       = attributes[:d]
      @dn      = attributes[:dn]
      @d_dn    = attributes[:d_dn]
      @default = attributes[:default]
      @options = attributes.fetch(:options, {})
    end

    # @return [Fixnum]
    def d1
      dimension.first < 1 ? 1 : dimension.first
    end

    # @return [Fixnum]
    def d2
      dimension.last
    end

    # @return [Array<Fixnum>]
    def pair
      dimension
    end

    private

    # @!attribute [r] d
    # @return [Fixnum]
    attr_reader :d

    # @!attribute [r] dn
    # @return [Fixnum]
    attr_reader :dn

    # @!attribute [r] d_dn
    # @return [Fixnum]
    attr_reader :d_dn

    # @!attribute [r] default
    # @return [Fixnum]
    attr_reader :default

    # @return [Array<Fixnum>]
    def dimension
      @dimension ||= if centred? && length?
        [(default / 2) - (length / 2), (default / 2) + (length / 2)]

                     elsif d && dn
        [d, dn]

                     elsif d && d_dn
        [d, ((d + d_dn) - 1)]

                     elsif d_dn
        [1, d_dn]

                     elsif d
        [d, default]

                     elsif dn
        [1, dn]

                     else
        [1, default]

      end
    end

    # @return [Boolean]
    def length?
      !!(default) && !!(length)
    end

    # @return [Fixnum|NilClass]
    def length
      if d && dn
        (d..dn).size

      elsif d_dn
        d_dn

      elsif default
        default

      else
        nil

      end
    end

    # @return [Boolean]
    def centred?
      options[:centred]
    end

    # @return [Hash<Symbol => Boolean>]
    def options
      defaults.merge!(@options)
    end

    # @return [Hash<Symbol => Boolean>]
    def defaults
      {
        centred: false,
      }
    end

  end # Dimension

end # Vedeu
