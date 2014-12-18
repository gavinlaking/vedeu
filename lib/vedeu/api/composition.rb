require 'vedeu/support/common'

module Vedeu

  module API

    # @see Vedeu::Composition
    #
    # @api public
    class Composition < Vedeu::Composition

      include Vedeu::Common

      # @param block [Proc]
      # @return [Array]
      # @see Vedeu::API#render
      def self.render(&block)
        return Vedeu.requires_block(__callee__) unless block_given?

        attributes = API::Composition.build({}, &block)

        Vedeu::Composition.new(attributes).interfaces.map do |interface|
          Buffers.add(interface.attributes)

          interface.name
        end.map { |name| Vedeu::Refresh.by_name(name) }
      end

      # @param name [String]
      # @param block [Proc]
      # @return [Hash]
      # @see Vedeu::API#view
      def view(name, &block)
        attributes[:interfaces] << API::Interface
          .build({ name: name, parent: self.view_attributes }, &block)
      end

    end # Composition

  end # API

end # Vedeu
