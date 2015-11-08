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
          @chars = 5

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

        if keys.start_with?("\e[M")
          button, x, y = keys.chars[3..-1].map { |c| c.ord - 32 }

          Vedeu.log(type:    :input,
                    message: "Mouse pressed: '#{button}' (x: #{x}, y: #{y})")

          if button == 0 # left mouse button
            Vedeu.trigger(:_cursor_reposition_, Vedeu.focus, y, x)

          elsif button == 64 # scroll wheel up
            Vedeu.trigger(:_cursor_up_, Vedeu.focus)

          elsif button == 65 # scroll wheel down
            Vedeu.trigger(:_cursor_down_, Vedeu.focus)

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
