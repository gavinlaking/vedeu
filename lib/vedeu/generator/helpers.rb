module Vedeu

  module Generator

    module Helpers

      # @return [String]
      def name
        @_name ||= @name.downcase
      end

      # @return [String]
      def name_as_class
        name.downcase.split(/_|-/).map(&:capitalize).join
      end

      # @return [String]
      def source
        File.dirname(__FILE__) + '/templates/application/.'
      end

    end # Helpers

  end # Generator

end # Vedeu
