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

      # @param destination [String]
      # @return [void]
      def make_directory(destination)
        Vedeu.log_stdout(type: :create, message: "#{destination}")

        FileUtils.mkdir_p(destination)
      end

      # @param source [String]
      # @param destination [String]
      # @return [void]
      def copy_file(source, destination)
        Vedeu.log_stdout(type: :create, message: "#{destination}")

        FileUtils.cp(source, destination)
      end

      # @param source [String]
      # @param destination [String]
      # @return [void]
      def make_file(source, destination)
        Vedeu.log_stdout(type: :create, message: "#{destination}")

        File.write(destination, parse(source))
      end

      # @param destination [String]
      # @return [void]
      def touch_file(destination)
        Vedeu.log_stdout(type: :create, message: "#{destination}")

        FileUtils.touch(destination)
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
