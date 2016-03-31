# frozen_string_literal: true

module Vedeu

  module Runtime

    # Provides the main loop for a Vedeu application.
    #
    # @api private
    #
    class MainLoop

      trap('SIGTERM') { stop! }
      trap('TERM')    { stop! }
      trap('INT')     { stop! }

      class << self

        # :nocov:

        # @param mode [Symbol]
        def mode_switch!(mode = nil)
          @loop        = false
          @mode_switch = true

          Vedeu::Terminal::Mode.switch_mode!(mode)

          Vedeu.trigger(:_drb_restart_)

          raise Vedeu::Error::ModeSwitch
        end

        # Start the main loop.
        #
        # @return [void]
        # @yieldreturn [void] The client application.
        def start!
          @started     = true
          @loop        = true
          @mode_switch = false

          Vedeu.trigger(:_refresh_cursor_, Vedeu.focus)

          Vedeu.trigger(:_refresh_)

          while @loop
            yield

            safe_exit_point!
          end
        rescue Vedeu::Error::Interrupt
          Vedeu.log(message: 'Vedeu execution interrupted, exiting.')
        end

        # Signal that we wish to terminate the running application.
        #
        # @return [void]
        def stop!
          @loop = false
        end

        # Check the application has started and we wish to continue
        # running.
        #
        # @raise [Vedeu::Error::Interrupt] When we wish to terminate
        #   the running application.
        # @return [void]
        def safe_exit_point!
          raise Vedeu::Error::Interrupt if @started && !@loop
        end

        # :nocov:

      end # Eigenclass

    end # MainLoop

  end # Runtime

end # Vedeu
