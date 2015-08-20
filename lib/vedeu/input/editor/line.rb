module Vedeu

  module Editor

    class Line

      # @param console [IO]
      # @return [String|Symbol]
      def self.read(console)
        new(console).read
      end

      # @param console [IO]
      # @return [Vedeu::Editor::Line]
      def initialize(console)
        @console = console
      end

      # @return [String|Symbol]
      def read
        Vedeu::InputTranslator.translate(keys)
      end

      private

      # @return [String]
      def keys
        keys = console.getch

        if keys.ord == 27 # \e
          # Vedeu.log(type: :debug, message: "_::_::Line: Escape detected...")

          @chars = 3

          begin
            # Vedeu.log(type:    :debug,
            #           message: "_::_::Line: Attempting read_nonblock(#{@chars})")
            keys << console.read_nonblock(@chars)
          rescue IO::WaitReadable
            # Vedeu.log(type:    :debug,
            #           message: "_::_::Line: (#{@chars}) Rescuing IO::WaitReadable")
            IO.select([console])
            @chars -= 1
            retry
          rescue IO::WaitWritable
            # Vedeu.log(type:    :debug,
            #           message: "_::_::Line: (#{@chars}) Rescuing IO::WaitWritable")
            IO.select(nil, [console])
            @chars -= 1
            retry
          end
        end
        # Vedeu.log(type:    :debug,
        #           message: "_::_::Line: Sending result: #{keys.inspect}")

        keys
      end

      # @return [IO]
      def console
        @console || Vedeu::Terminal.console
      end

    end # Line

  end # Editor

end # Vedeu
