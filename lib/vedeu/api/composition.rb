module Vedeu

  module API

    # @see Vedeu::Composition
    #
    # @api public
    class Composition < Vedeu::Composition

      # Directly write a view buffer to the terminal.
      #
      # @param block [Proc]
      # @return [Array] A collection of strings, each defining containing the
      #   escape sequences and content. This data has already been sent to the
      #   terminal to be output.
      def self.render(&block)
        fail InvalidSyntax, '`render` requires a block.' unless block_given?

        attributes = API::Composition.build({}, &block)

        Vedeu::Composition.new(attributes).interfaces.map do |interface|
          Buffers.add(interface.attributes)

          interface.name
        end.map { |name| Vedeu::Refresh.by_name(name) }
      end

      # @param name [String]
      # @param block [Proc]
      # @return []
      # @see Vedeu::API#view
      def view(name, &block)
        attributes[:interfaces] << API::Interface
          .build({ name: name, parent: self.view_attributes }, &block)
      end

    end # Composition

  end # API

end # Vedeu
