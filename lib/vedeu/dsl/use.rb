# frozen_string_literal: true

module Vedeu

  module DSL

    # Provides helper methods for building views.
    #
    module Use

      # {include:file:docs/dsl/by_method/use.md}
      # @macro param_name
      # @raise
      #   [Vedeu::Error::ModelNotFound|Vedeu::Error::NoMethodError]
      #   The model or attribute cannot be found.
      # @return [void] The stored model.
      def use(name)
        model.repository.by_name(name)
      end

    end # Use

  end # DSL

end # Vedeu
