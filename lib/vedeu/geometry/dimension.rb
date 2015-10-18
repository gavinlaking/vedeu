module Vedeu

  module Geometry

    # A Dimension is either the height or width of an entity.
    #
    class Dimension

      # @param (see #initialize)
      # @return [Array<Fixnum>]
      def self.pair(attributes = {})
        new(attributes).pair
      end

      # Returns a new instance of Vedeu::Geometry::Dimension.
      #
      # @param attributes [Hash<Symbol => Fixnum, NilClass>]
      # @option attributes d [Fixnum|NilClass]
      #   The starting value (y or x).
      # @option attributes dn [Fixnum|NilClass]
      #   The ending value (yn or xn).
      # @option attributes d_dn [Fixnum|NilClass] A width or a height.
      # @option attributes default [Fixnum|NilClass]
      #   The terminal width or height.
      # @option attributes maximised [Boolean]
      # @option attributes centered [Boolean]
      # @option attributes alignment [Symbol]
      # @return [Vedeu::Geometry::Dimension]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Fetch the starting coordinate.
      #
      # @return [Fixnum]
      def d1
        dimension[0] #< 1 ? 1 : dimension[0]
      end

      # Fetch the ending coordinate.
      #
      # @return [Fixnum]
      def d2
        dimension[-1]
      end

      # Fetch the coordinates.
      #
      # @return [Array<Fixnum>]
      def pair
        dimension
      end

      protected

      # @!attribute [r] d
      # @return [Fixnum|NilClass] The starting value (y or x).
      attr_reader :d

      # @!attribute [r] dn
      # @return [Fixnum|NilClass] The ending value (yn or xn).
      attr_reader :dn

      # @!attribute [r] d_dn
      # @return [Fixnum|NilClass] A width or a height.
      attr_reader :d_dn

      # @!attribute [r] default
      # @return [Fixnum|NilClass] The terminal width or height.
      attr_reader :default

      # @!attribute [r] maximised
      # @return [Boolean]
      attr_reader :maximised
      alias_method :maximised?, :maximised

      # @!attribute [r] centred
      # @return [Boolean]
      attr_reader :centred
      alias_method :centred?, :centred

      # @!attribute [r] alignment
      # @return [Symbol]
      attr_reader :alignment

      private

      # Return the dimension.
      #
      # 1) If maximised, it will be from the first row/line or column/
      #    character to the last row/line or column/character of the
      #    terminal.
      # 2) If centred,
      #
      # @return [Array<Fixnum>]
      def dimension
        @dimension = if maximised?
                       [1, default]

                     elsif centre_aligned?
                       [centred_d, centred_dn]

                     elsif left_aligned?
                       [1, left_dn]

                     elsif right_aligned?
                       [right_d, default]

                     elsif centred? && length?
                       [centred_d, centred_dn]

                     else
                       [_d, _dn]

                     end
      end

      # Return a boolean indicating we know the length if a we know
      # either the terminal width or height, or we can determine a
      # length from the values provided.
      #
      # @return [Boolean]
      # @todo GL 2015-10-16 Investigate: should this be && or ||.
      def length?
        default && length
      end

      # Provide the number of rows/lines or columns/characters.
      #
      # 1) Use the starting (x or y) and ending (xn or yn) values.
      # 2) Or use the width or height value.
      # 3) Or use the default/current terminal width or height value.
      #
      # @return [Fixnum|NilClass]
      def length
        if d && dn
          (d..dn).size

        elsif d_dn
          d_dn

        else
          default

        end
      end

      # Ascertains the centred starting coordinate.
      #
      # @example
      #    default = 78 # => 39
      #    length = 24 # => 12
      #    centred_d = 27 # (39 - 12 = 27)
      #
      # @return [Fixnum]
      def centred_d
        d = (default / 2) - (length / 2)
        d < 1 ? 1 : d
      end

      # Ascertains the centred ending coordinate.
      #
      # @example
      #    default = 78 # => 39
      #    length = 24 # => 12
      #    centred_dn = 51 # (39 + 12 = 51)
      #
      # @return [Fixnum]
      def centred_dn
        dn = (default / 2) + (length / 2)
        dn > default ? default : dn
      end

      # @return [Fixnum]
      def left_dn
        if d_dn
          (d_dn > default) ? default : d_dn

        elsif dn
          dn

        else
          default

        end
      end

      # @return [Fixnum]
      def right_d
        if d_dn
          (default - d_dn) < 1 ? 1 : (default - d_dn)

        elsif d
          d

        else
          1

        end
      end

      # Fetch the starting coordinate, or use 1 when not set.
      #
      # @return [Fixnum]
      def _d
        d || 1
      end

      # Fetch the ending coordinate.
      #
      # 1) if an end value was given, use that.
      # 2) if a start value wasn't given, but a width or height was,
      #    use the width or height.
      # 3) if a start value was given and a width or height was given,
      #    add the width or height to the start and minus 1.
      # 4) otherwise, use the terminal default width or height.
      #
      # @return [Fixnum]
      def _dn
        if dn
          dn

        elsif d.nil? && d_dn
          d_dn

        elsif d && d_dn
          (d + d_dn) - 1

        elsif default
          default

        else
          1

        end
      end

      # Return a boolean indicating alignment was set to :left.
      #
      # @return [Boolean]
      def left_aligned?
        alignment == :left
      end

      # Return a boolean indicating alignment was set to :centre.
      #
      # @return [Boolean]
      def centre_aligned?
        alignment == :centre
      end

      # Return a boolean indicating alignment was set to :right.
      #
      # @return [Boolean]
      def right_aligned?
        alignment == :right
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
          alignment: Vedeu::Geometry::Alignment.align(:none),
        }
      end

    end # Dimension

  end # Geometry

end # Vedeu
