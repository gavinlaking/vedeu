# frozen_string_literal: true

module Vedeu

  module Presentation

    #
    # @api private
    #
    module Parent

      include Vedeu::Common

      # @return [NilClass|String|Symbol]
      def name
        if present?(@name)
          @name

        elsif parent? && present?(parent.name)
          parent.name

        end
      end

      # @return [NilClass|void]
      def parent
        return @parent if parent?
      end

      # @return [Boolean]
      def parent?
        present?(@parent)
      end

    end # Parent

  end # Presentation

end # Vedeu
