module Vedeu

  module Generator

    module Helpers

      # @param source []
      # @param destination []
      # @return [void]
      def make_file(source, destination)
        File.open(destination, 'w') { |file| file.write(parse(source)) }
      end

      # @return [String]
      def name
        @_name ||= @name.downcase
      end

      # @return [String]
      def name_as_class
        name.downcase.split(/_|-/).map(&:capitalize).join
      end

      # @param source []
      # @return [String]
      def parse(source)
        Vedeu::Template.parse(self, source)
      end

      # @return [String]
      def source
        File.dirname(__FILE__) + '/templates/application/.'
      end

    end # Helpers

  end # Generator

end # Vedeu
