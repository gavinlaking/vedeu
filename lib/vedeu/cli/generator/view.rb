require 'fileutils'

module Vedeu

  module Generator

    # Generates a view for the client application.
    #
    # @example
    #   ```bash
    #   vedeu view main_screen
    #   ```
    #
    # @api private
    class View

      include Vedeu::Generator::Helpers

      # @see Vedeu::Generator::View#initialize
      def self.generate(name)
        new(name).generate
      end

      # Returns a new instance of Vedeu::Generator::View.
      #
      # @param name [String] The name of the view.
      # @return [Vedeu::Generator::View]
      def initialize(name)
        @name = name
      end

      # @return [void]
      def generate
        make_controller_file
        make_helper_file
        make_keymap_file
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
      def make_keymap_file
        make_file(source + '/app/models/keymaps/name.erb',
                  '.' + "/app/models/keymaps/#{name}.rb")
      end

      # @return [void]
      def make_interface_file
        make_file(source + '/app/views/interfaces/name.erb',
                  '.' + "/app/views/interfaces/#{name}.rb")
      end

      # @return [void]
      def make_template_file
        touch_file('.' + "/app/views/templates/#{name}.erb")
      end

      # @return [void]
      def make_view_class_file
        make_file(source + '/app/views/name.erb',
                  '.' + "/app/views/#{name}.rb")
      end

    end # View

  end # Generator

end # Vedeu
