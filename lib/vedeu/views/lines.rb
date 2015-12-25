# frozen_string_literal: true

module Vedeu

  module Views

    # A collection of {Vedeu::Views::Line} instances.
    #
    # @api private
    #
    class Lines < Vedeu::Repositories::Collection

      # @param (see Vedeu::Repositories::Collection#initialize)
      # @raise [Vedeu::Error::InvalidSyntax] When the collection
      #   cannot be coerced since it is unrecognised or unsupported.
      # @return [Vedeu::Views::Lines]
      def self.coerce(collection = [], parent = nil, name = nil)
        if collection.is_a?(Vedeu::Views::Lines)
          collection

        elsif collection.is_a?(Array)
          return new(collection, parent, name) if collection.empty?

          coerced_collection = []
          collection.each do |element|
            coerced_collection << element if element.is_a?(Vedeu::Views::Line)
          end

          new(coerced_collection, parent, name)

        elsif collection.is_a?(Vedeu::Views::Line)
          new([collection], parent, name)

        else
          fail Vedeu::Error::InvalidSyntax,
               'Cannot coerce for Vedeu::View::Lines, as collection ' \
               'unrecognised.'

        end
      end

      alias_method :lines, :value

    end # Lines

  end # Views

end # Vedeu
