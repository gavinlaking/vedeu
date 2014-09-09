module Vedeu
  module API

    # @see Vedeu::Composition
    class Composition < Vedeu::Composition

      # Directly write a view buffer to the terminal.
      #
      # @api public
      # @param block [Proc]
      # @return [Array] A collection of strings, each defining containing the
      #                 escape sequences and content. This data has already
      #                 been sent to the terminal to be output.
      def self.render(&block)
        fail InvalidSyntax, '`render` requires a block.' unless block_given?

        attributes = API::Composition.build({}, &block)

        Vedeu::Composition.new(attributes).interfaces.map do |interface|
          Buffers.add(interface.attributes)

          interface.name
        end.map { |name| Compositor.render(name) }
      end

      # @api public
      # @see Vedeu::API#view
      def view(name, &block)
        attributes[:interfaces] << API::Interface
          .build({ name: name, parent: self.view_attributes }, &block)
      end

    end
  end
end
