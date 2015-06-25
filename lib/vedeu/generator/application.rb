module Vedeu

  module Generator

    class Application

      include Vedeu::Generator::Helpers

      # @param name [String] The name of the application.
      # @return [Vedeu::Generator::Application]
      def self.generate(name)
        new(name).generate
      end

      # @param name [String] The name of the application.
      # @return [Vedeu::Generator::Application]
      def initialize(name)
        @name = name
      end

      # @return [void]
      def generate
        make_directory_structure

        copy_gemfile
        copy_application_controller
        copy_application_helper
        copy_global_keymap
        copy_system_keymap
        copy_application_executable
        make_application_executable
        copy_configuration
        copy_app_name
      end

      private

      # @return [void]
      def make_directory_structure
        directories.each do |directory|
          FileUtils.mkdir_p(name + directory)
        end
      end

      # @return [void]
      def copy_application_controller
        make_file(source + '/app/controllers/application_controller.erb',
                  name + '/app/controllers/application_controller.rb')
      end

      # @return [void]
      def copy_application_helper
        make_file(source + '/app/helpers/application_helper.erb',
                  name + '/app/helpers/application_helper.rb')
      end

      # @return [void]
      def copy_application_executable
        FileUtils.cp(source + '/bin/name',
                     "#{name}/bin/#{name}")
      end

      # @return [void]
      def copy_configuration
        FileUtils.cp(source + '/config/configuration.rb',
                     "#{name}/config/configuration.rb")
      end

      # @return [void]
      def copy_app_name
        make_file(source + '/config/app_name.erb',
                  name + '/config/app_name')
      end

      # @return [void]
      def copy_gemfile
        FileUtils.cp(source + '/Gemfile', "#{name}/Gemfile")
      end

      # @return [void]
      def make_application_executable
        FileUtils.chmod(0755, "#{name}/bin/#{name}")
      end

      # @return [void]
      def copy_global_keymap
        FileUtils.cp(source + '/app/models/keymaps/_global_.rb',
                     "#{name}/app/models/keymaps/_global_.rb")
      end

      # @return [void]
      def copy_system_keymap
        FileUtils.cp(source + '/app/models/keymaps/_system_.rb',
                     "#{name}/app/models/keymaps/_system_.rb")
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

  end # Generator

end # Vedeu
