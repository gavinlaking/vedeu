module Vedeu

  module Generator

    # Provides functionality used by the generators to build the client
    # application.
    #
    # :nocov:
    module Helpers

      include Vedeu::Common

      # @return [String]
      def app_name
        @app_name ||= File.read('./config/app_name')
      end

      def app_bin_path
        name + '/bin/'
      end

      def app_config_path
        name + '/config/'
      end

      def app_controllers_path
        name + '/app/controllers/'
      end

      def app_helpers_path
        name + '/app/helpers/'
      end

      def app_models_path
        name + '/app/models/'
      end

      def app_keymaps_path
        name + '/app/models/keymaps/'
      end

      def app_views_path
        name + '/app/views/'
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
        if File.exist?(destination)
          skipped_file(destination)

        else
          Vedeu.log_stdout(type: :create, message: "#{destination}")

          FileUtils.cp(source, destination)
        end
      end

      # @param source [String]
      # @param destination [String]
      # @return [void]
      def make_file(source, destination)
        if File.exist?(destination)
          skipped_file(destination)

        else
          Vedeu.log_stdout(type: :create, message: "#{destination}")

          File.write(destination, parse(source))
        end
      end

      # @param destination [String]
      # @return [void]
      def skipped_file(destination)
        Vedeu.log_stdout(type:    :create,
                         message: "#{destination} " +
                                  Esc.red { "already exists, skipped." })
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
      alias_method :app_root_path, :name

      # @return [String]
      def name_as_class
        name.downcase.split(/_|-/).map(&:capitalize).join
      end

      # @return [String]
      def output(message = '')
        Vedeu.log_stdout(type: :info, message: message)

        message
      end

      # @param source [String]
      # @return [String]
      def parse(source)
        Vedeu::Templating::Template.parse(self, source)
      end

      # @return [String]
      def source
        File.dirname(__FILE__) + '/templates/application/.'
      end

    end # Helpers
    # :nocov:

  end # Generator

end # Vedeu
