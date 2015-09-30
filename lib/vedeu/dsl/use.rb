module Vedeu

  module DSL

    # Provides helper methods for building views.
    #
    module Use

      # Use the attribute of stored model.
      #
      # This DSL method provides access to a stored model by name.
      # You can then request an attribute of that model for use within
      # the current model. The models which current support this are
      # Border, Geometry and Interface.
      #
      # @example
      #   # Here the character used for :my_border is used in
      #   # :my_other_border.
      #   Vedeu.border :my_other_border do
      #     top_right use(:my_border).top_right
      #   end
      #
      # @note
      #   - Only models of the same repository can be used in this
      #     way.
      #   - If the stored model cannot be found, a ModelNotFound
      #     exception may be raised, or the request for an attribute
      #     may raise a NoMethodError exception.
      #
      # @param name [String|Symbol] The name of the model with the
      #   value you wish to use.
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
