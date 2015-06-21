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
        FileUtils.mkdir_p(name + '/app/controllers')
        FileUtils.mkdir_p(name + '/app/helpers')
        FileUtils.mkdir_p(name + '/app/models/keymaps')
        FileUtils.mkdir_p(name + '/app/views/interfaces')
        FileUtils.mkdir_p(name + '/app/views/templates')
        FileUtils.mkdir_p(name + '/bin')
        FileUtils.mkdir_p(name + '/config')
        FileUtils.mkdir_p(name + '/lib')
        FileUtils.mkdir_p(name + '/log')
        FileUtils.mkdir_p(name + '/test')
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

    end # Application

  end # Generator

end # Vedeu
