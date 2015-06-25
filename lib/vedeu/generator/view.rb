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

      # @return [void]
      def make_controller_file
        make_file(source + '/app/controllers/name.erb',
                  '.' + "/app/controllers/#{name}_controller.rb")
      end

      # @return [void]
      def make_helper_file
        make_file(source + '/app/helpers/name.erb',
                  '.' + "/app/helpers/#{name}_helper.rb")
      end

      # @return [void]
      def make_interface_file
        make_file(source + '/app/views/interfaces/name.erb',
                  '.' + "/app/views/interfaces/#{name}.rb")
      end

      # @return [void]
      def make_template_file
        FileUtils.touch('.' + "/app/views/templates/#{name}.erb")
      end

      # @return [void]
      def make_view_class_file
        make_file(source + '/app/views/name.erb',
                  '.' + "/app/views/#{name}.rb")
      end

    end # View

  end # Generator

end # Vedeu
