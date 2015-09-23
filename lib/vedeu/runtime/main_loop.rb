module Vedeu

  module Runtime

    # Provides the main loop for a Vedeu application.
    #
    class MainLoop

      trap('SIGTERM') { stop! }
      trap('TERM')    { stop! }
      trap('INT')     { stop! }

      class << self

        # :nocov:
        # Start the main loop.
        #
        # @return [void]
        # @yieldreturn [void] The client application.
        def start!
          @started = true
          @loop    = true

          while @loop
            yield

            Vedeu::Cursors::Cursor.hide_cursor

            Vedeu::Terminal::Buffer.render

            Vedeu::Cursors::Cursor.show_cursor

            safe_exit_point!
          end
        rescue Vedeu::Error::Interrupt
          Vedeu.log(type:    :info,
                    message: 'Vedeu execution interrupted, exiting.')
        end
        # :nocov:

        # Signal that we wish to terminate the running application.
        #
        # @return [void]
        def stop!
          @loop = false
        end

        # :nocov:
        # Check the application has started and we wish to continue
        # running.
        #
        # @raise [Vedeu::Error::Interrupt] When we wish to terminate
        #   the running application.
        # @return [void]
        def safe_exit_point!
          fail Vedeu::Error::Interrupt if @started && !@loop
        end
        # :nocov:

      end # Eigenclass

    end # MainLoop

  end # Runtime

end # Vedeu
