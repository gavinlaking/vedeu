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
      @attributes = defaults.merge!(attributes)

      @attributes.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # Fetch the starting coordinate.
    #
    # @return [Fixnum]
    def d1
      dimension.first < 1 ? 1 : dimension.first
    end

    # Fetch the ending coordinate.
    #
    # @return [Fixnum]
    def d2
      dimension.last
    end

    # Fetch the coordinates.
    #
    # @return [Array<Fixnum>]
    def pair
      dimension
    end

    protected

    # @!attribute [r] d
    # @return [Fixnum|NilClass]
    attr_reader :d

    # @!attribute [r] dn
    # @return [Fixnum|NilClass]
    attr_reader :dn

    # @!attribute [r] d_dn
    # @return [Fixnum|NilClass]
    attr_reader :d_dn

    # @!attribute [r] default
    # @return [Fixnum|NilClass]
    attr_reader :default

    # @!attribute [r] maximised
    # @return [Boolean]
    attr_reader :maximised
    alias_method :maximised?, :maximised

    # @!attribute [r] centred
    # @return [Boolean]
    attr_reader :centred
    alias_method :centred?, :centred

    private

    # @return [Array<Fixnum>]
    def dimension
      @dimension = if maximised?
                     [1, default]

                   elsif centred? && length?
                     [centred_d, centred_dn]

                   else
                     [_d, _dn]

                   end
    end

    # @return [Boolean]
    def length?
      default && length
    end

    # @return [Fixnum|NilClass]
    def length
      if d && dn
        (d..dn).size

      elsif d_dn
        d_dn

      elsif default
        default

      end
    end

    # Ascertains the centred starting coordinate.
    #
    # @return [Fixnum]
    def centred_d
      (default / 2) - (length / 2)
    end

    # Ascertains the centred ending coordinate.
    #
    # @return [Fixnum]
    def centred_dn
      (default / 2) + (length / 2)
    end

    # Fetch the starting coordinate, or use 1 when not set.
    #
    # @return [Fixnum]
    def _d
      d || 1
    end

    # Fetch the ending coordinate.
    #
    # @return [Fixnum]
    def _dn
      if dn
        dn

      elsif d.nil? && d_dn
        d_dn

      elsif d && d_dn
        (d + d_dn) - 1

      else
        default

      end
    end

    # Returns the default options/attributes for this class.
    #
    # @return [Hash<Symbol => NilClass,Boolean>]
    def defaults
      {
        d:         nil,
        dn:        nil,
        d_dn:      nil,
        default:   nil,
        centred:   false,
        maximised: false,
      }
    end

  end # Dimension

end # Vedeu
