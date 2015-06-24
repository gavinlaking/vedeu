module Vedeu

  module Generator

    module Helpers

      # @return [String]
      def app_name
        @app_name ||= File.read('./config/app_name')
      end

      # @param name [String]
      # @return [String]
      def app_name_as_snake_case(name = app_name)
        name.gsub!(/::/, '/')
        name.gsub!(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        name.gsub!(/([a-z\d])([A-Z])/, '\1_\2')
        name.tr!('-', '_')
        name.downcase!
        name
      end

      # @param source [String]
      # @param destination [String]
      # @return [void]
      def make_file(source, destination)
        File.write(destination, parse(source))
      end

      # @return [String]
      def name
        @_name ||= @name.downcase
      end

      # @return [String]
      def name_as_class
        name.downcase.split(/_|-/).map(&:capitalize).join
      end

      # @param source [String]
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
