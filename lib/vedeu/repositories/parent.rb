module Vedeu

  module Repositories

    # When included into a class, provides the mechanism to retrieve
    # the parent object for the class if available.
    #
    module Parent

      include Vedeu::Common

      # @return [NilClass|void]
      def parent
        present?(@parent) ? @parent : nil
      end

      # @return [NilClass|String|Symbol]
      def name
        if present?(@name)
          @name

        elsif parent && present?(parent.name)
          parent.name

        end
      end

    end # Parent

  end # Repositories

end # Vedeu
