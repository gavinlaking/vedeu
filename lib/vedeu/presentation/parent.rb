# frozen_string_literal: true

module Vedeu

  module Presentation

    #
    # @api private
    #
    module Parent

      # @return [NilClass|void]
      def parent
        present?(@parent) ? @parent : nil
      end

    end # Parent

  end # Presentation

end # Vedeu
