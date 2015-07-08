module Vedeu

  # Provide a command line interface to Vedeu.
  #
  # @api public
  module CLI

    # The main command line interface commands.
    #
    # @api public
    class Main < Thor

      desc 'new <name>', 'Create a skeleton Vedeu client application.'
      # @param name [String]
      # @return [String]
      def new(name)
        say Vedeu::Generator::Application.generate(name)
      end

      # 'Specify the interface name lowercase snakecase; e.g. main_interface'

      desc 'view <name>',
           'Create a new interface within the client application.'
      # @param name [String]
      # @return [String]
      def view(name)
        Vedeu::Generator::View.generate(name)
      end

      desc 'version',
           'Print the version.'
      # @return [String]
      def version
        say "vedeu #{Vedeu::VERSION}"
      end

    end # Main

  end # CLI

end # Vedeu
