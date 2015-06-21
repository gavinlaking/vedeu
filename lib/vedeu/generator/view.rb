require 'fileutils'

module Vedeu

  module Generator

    class View

      include Vedeu::Generator::Helpers

      # @param name [String] The name of the view.
      # @return [Vedeu::Generator::View]
      def self.generate(name)
        new(name).generate
      end

      # @param name [String] The name of the view.
      # @return [Vedeu::Generator::View]
      def initialize(name)
        @name = name
      end

      # @return [void]
      def generate
        make_controller_file

        make_helper_file

        make_interface_file

        make_template_file

        make_view_class_file
      end

      private

      def make_controller_file
        make_file(source + '/app/controllers/name.erb',
                  name + "/app/controllers/#{name}.rb")
      end

      def make_helper_file
        make_file(source + '/app/helpers/name.erb',
                  name + "/app/helpers/#{name}.rb")
      end

      def make_interface_file
        make_file(source + '/app/views/interfaces/name.erb',
                  name + "/app/views/interfaces/#{name}.rb")
      end

      def make_template_file
        FileUtils.touch(name + "/app/views/templates/#{name}.erb")
      end

      def make_view_class_file
        make_file(source + '/app/views/name.erb',
                  name + "/app/views/#{name}.rb")
      end

    end # View

  end # Generator

end # Vedeu
