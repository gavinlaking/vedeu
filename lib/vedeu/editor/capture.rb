module Vedeu

  module Editor

    # Capture input from the terminal via 'getch'.
    #
    class Capture

      ESCAPE_KEY_CODE = 27 # \e

      # @param console [IO]
      # @return [String|Symbol]
      def self.read(console)
        new(console).read
      end

      # Returns a new instance of Vedeu::Editor::Capture.
      #
      # @param console [IO]
      # @return [Vedeu::Editor::Capture]
      def initialize(console)
        @console = console
      end

      # @return [String|Symbol]
      def read
        Vedeu::Input::Translator.translate(keys)
      end

      private

      # @return [String]
      def keys
        keys = console.getch

        if keys.ord == ESCAPE_KEY_CODE
          @chars = 3

          begin
            keys << console.read_nonblock(@chars)

          rescue IO::WaitReadable
            IO.select([console])
            @chars -= 1
            retry

          rescue IO::WaitWritable
            IO.select(nil, [console])
            @chars -= 1
            retry

          end
        end

        keys
      end

      # @return [IO]
      def console
        @console || Vedeu::Terminal.console
      end

    end # Capture

  end # Editor

end # Vedeu
