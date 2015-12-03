module Vedeu

  module Borders

    # Provides the mechanism to set attributes on a
    # {Vedeu::Borders::Border} object. At the moment, it is used for
    # setting the title and caption for a named border.
    #
    # @api private
    #
    class SetAttribute

      include Vedeu::Common

      # @param (see #initialize)
      # @return [Vedeu::Borders::Border]
      def self.update(name, attribute, value)
        new(name, attribute, value).update
      end

      # @param name [String|Symbol]
      # @param attribute [Symbol]
      # @param value [String]
      # @return [Vedeu::Borders::SetAttribute]
      def initialize(name, attribute, value)
        @name      = name
        @attribute = attribute
        @value     = value
      end

      # @return [Vedeu::Borders::Border]
      def update
        border.send(attribute, value)
        border.store { Vedeu.trigger(:_refresh_border_, name) }
        border
      end

      protected

      # @!attribute [r] name
      # @return [String|Symbol] The name of the border.
      attr_reader :name

      private

      # @return [Symbol]
      def attribute
        fail Vedeu::Error::MissingRequired if @attribute.nil?

        (@attribute.to_s + '=').to_sym
      end

      # @return [Vedeu::Borders::Border]
      def border
        @_border ||= Vedeu.borders.by_name(name)
      end

      # @return [String] The new value.
      def value
        if present?(@value)
          @value

        else
          ''

        end
      end

    end # SetAttribute

  end # Borders

end # Vedeu
