module Vedeu

  # A Page represents an array of Vedeu::Row objects.
  #
  class Page

    include Enumerable

    # @!attribute [r] rows
    # @return [Array<NilClass|Vedeu::Row>]
    attr_reader :rows

    # @param value [Vedeu::Page|Vedeu::Row|Array<void>|void]
    # @return [Vedeu::Page]
    def self.coerce(value)
      if value.is_a?(Vedeu::Page)
        value

      elsif value.is_a?(Vedeu::Row)
        Vedeu::Page.new([value])

      elsif value.is_a?(Array) && value.empty?
        Vedeu::Page.new([Vedeu::Row.coerce(value)])

      elsif value.is_a?(Array)
        values = value.map do |v|
          if v.is_a?(Vedeu::Row)
            v

          else
            Vedeu::Row.coerce(v)

          end
        end
        Vedeu::Page.new(values)

      else
        fail Vedeu::Error::InvalidSyntax,
             'Cannot coerce as value is not an Array.'

      end
    end

    # Returns an instance of Vedeu::Page.
    #
    # @param rows [Array<NilClass|Vedeu::Row>]
    # @return [Vedeu::Page]
    def initialize(rows = [])
      @rows = rows || []
    end

    # Provides iteration over the collection.
    #
    # @param block [Proc]
    # @return [Enumerator]
    def each(&block)
      rows.each(&block)
    end

    # An object is equal when its values are the same.
    #
    # @param other [Vedeu::Page]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && rows == other.rows
    end
    alias_method :==, :eql?

    # @param index [Fixnum]
    # @return [NilClass|Vedeu::Row]
    def row(index = nil)
      return nil if index.nil?

      rows[index]
    end

    # @param row_index [Fixnum]
    # @param cell_index [Fixnum]
    # @return [NilClass|void]
    def cell(row_index = nil, cell_index = nil)
      return nil if row_index.nil? || cell_index.nil?
      return nil unless row(row_index)

      row(row_index)[cell_index]
    end

  end # Page

end # Vedeu
