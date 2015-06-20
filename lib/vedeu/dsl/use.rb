module Vedeu

  module DSL

    # Provides helper methods for building views.
    #
    module Use

      # Duplicate a stored model.
      #
      # This DSL method copies the attributes of a stored model, changes the
      # name to that of the current model, and stores the duplicate as a new
      # model in model's repository.
      #
      # @example
      #   # Here the attributes of 'my_geometry' are used to create the
      #   # new model 'my_other_geometry'.
      #   Vedeu.geometry 'my_other_geometry' do
      #     duplicate('my_geometry')
      #   end
      #
      # @note
      #   - Only models of the same repository can be used in this way.
      #   - If the stored model cannot be found, the duplicate may not have
      #     the values you required.
      #   - Values defined before will be overwritten by the new values from
      #     the stored model.
      #   - Values defined after will overwrite the values of the new
      #     duplicate model.
      #
      # @param name [String] The name of the model to duplicate.
      # @return [void] The new model based on the original.
      def duplicate(name)
        duplicated      = model.repository.by_name(name).dup
        duplicated.name = model.name
        duplicated.store
      end

      # Use the attribute of stored model.
      #
      # This DSL method provides access to a stored model by name. You can
      # then request an attribute of that model for use within the current
      # model.
      #
      # @example
      #   # Here the character used for 'my_border' is used in
      #   # 'my_other_border'.
      #   Vedeu.border 'my_other_border' do
      #     top_right use('my_border').top_right
      #   end
      #
      # @note
      #   - Only models of the same repository can be used in this way.
      #   - If the stored model cannot be found, a ModelNotFound exception may
      #     be raised, or the request for an attribute may raise a
      #     NoMethodError exception.
      #
      # @param name [String] The name of the model with the value you wish to
      #   use.
      # @raise [ModelNotFound|NoMethodError] The model or attribute cannot be
      #   found.
      # @return [void] The stored model.
      def use(name)
        model.repository.by_name(name)
      end

    end # Use

  end # DSL

end # Vedeu
