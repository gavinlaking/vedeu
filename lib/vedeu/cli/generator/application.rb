module Vedeu

  module Generator

    # Generates the client application directory and file structure.
    #
    # @example
    #   ```bash
    #   vedeu new your_app_name_here
    #   ```
    #
    # :nocov:
    class Application

      include Vedeu::Generator::Helpers

      # @param name [String] The name of the application.
      # @return [Vedeu::Generator::Application]
      def self.generate(name)
        new(name).generate
      end

      # Returns a new instance of Vedeu::Generator::Application.
      #
      # @param name [String] The name of the application.
      # @return [Vedeu::Generator::Application]
      def initialize(name)
        @name = name
      end

      # @return [void]
      def generate
        make_directory_structure

        copy_app_root_files
        copy_application_bootstrapper
        copy_application_controller
        copy_application_helper
        copy_global_keymap
        copy_application_executable
        make_application_executable
        copy_configuration
        copy_app_name
      end

      private

      # @return [void]
      def make_directory_structure
        directories.each { |directory| make_directory(name + directory) }
      end

      # @return [void]
      def copy_application_bootstrapper
        make_file(source + '/application.erb',
                  app_root_path + '/application.rb')
      end

      # @return [void]
      def copy_application_controller
        make_file(source + '/app/controllers/application_controller.erb',
                  app_controllers_path + 'application_controller.rb')
      end

      # @return [void]
      def copy_application_executable
        copy_file(source + '/bin/name', app_bin_path + "#{name}")
      end

      # @return [void]
      def copy_application_helper
        make_file(source + '/app/helpers/application_helper.erb',
                  app_helpers_path + 'application_helper.rb')
      end

      # @return [void]
      def copy_configuration
        make_file(source + '/config/configuration.erb',
                  app_config_path + 'configuration.rb')
      end

      # @return [void]
      def copy_app_name
        make_file(source + '/config/app_name.erb',
                  app_config_path + 'app_name')
      end

      # @return [void]
      def copy_app_root_files
        [
          '/Gemfile',
          '/.gitignore',
          '/LICENSE.txt',
          '/README.md',
          '/.ruby-version'
        ].each do |file|
          copy_file((source + file), (app_root_path + file))
        end
      end

      # @return [void]
      def make_application_executable
        FileUtils.chmod(0755, "#{name}/bin/#{name}")
      end

      # @return [void]
      def copy_global_keymap
        copy_file(source + '/app/models/keymaps/_global_.rb',
                  app_keymaps_path + '_global_.rb')
      end

      # @return [Array<String>]
      def directories
        [
          '/app/controllers',
          '/app/helpers',
          '/app/models/keymaps',
          '/app/views/interfaces',
          '/app/views/templates',
          '/bin',
          '/config',
          '/lib',
          '/test',
          '/vendor',
        ]
      end

    end # Application
    # :nocov:

  end # Generator

end # Vedeu
