module Vedeu

  # Return the centre character position for a value (width or height), or
  # starting and ending coordinate.
  #
  # @example
  #   Vedeu::Centre.for_value(27) # => 13
  #
  #   Vedeu::Centre.for_points(3, 17) # => 10
  #
  # @note
  #   If initialized with a `:value` in the attributes, then :v and :vn are
  #   ignored.
  #
  class Centre

    # @param value [Fixnum] A width of height.
    # @return [Fixnum]
    def self.for_value(value)
      new({ value: value }).centre
    end

    # @param v [Fixnum] The starting coordinate value.
    # @param vn [Fixnum] The ending coordinate value.
    # @return [Fixnum]
    def self.for_points(v, vn)
      new({ v: v, vn: vn }).centre
    end

    # Returns a new instance of Vedeu::Centre.
    #
    # @param attributes [Hash<Symbol => Fixnum>]
    # @option attributes v [Fixnum] The starting coordinate value.
    # @option attributes vn [Fixnum] The ending coordinate value.
    # @option attributes value [Fixnum] A width of height.
    # @return [Vedeu::Centre]
    def initialize(attributes = {})
      @v     = attributes[:v]
      @vn    = attributes[:vn]
      @value = attributes[:value]
    end

    # @raise [InvalidSyntax] When :v or :vn is missing, or :vn is less than :v.
    # @return [Fixnum]
    def centre
      if value
        value / 2

      else
        v + (v_vn / 2)

      end
    end

    private

    # @!attribute [r] v
    # @return [Fixnum]
    attr_reader :v

    # @!attribute [r] vn
    # @return [Fixnum]
    attr_reader :vn

    # @!attribute [r] value
    # @return [Fixnum]
    attr_reader :value

    # @return [Fixnum]
    def v_vn
      if vn.nil? || v.nil?
        fail InvalidSyntax, 'Missing values for :v, :vn.'

      elsif vn < v
        fail InvalidSyntax, "Values invalid for :v (#{v}), :vn (#{vn})."

      else
        vn - v

      end
    end

  end # Centre

end # Vedeu
