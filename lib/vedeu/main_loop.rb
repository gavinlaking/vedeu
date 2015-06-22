module Vedeu

  # Provides the main loop for a Vedeu application.
  #
  # @api private
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

          safe_exit_point!
        end
      rescue VedeuInterrupt
        Vedeu.log(type:    :debug,
                  message: 'Vedeu execution interrupted, exiting.')

      end
      # :nocov:

      # Signal that we wish to terminate the running application.
      #
      # @return [void]
      def stop!
        @loop = false
      end

      # Check the application has started and we wish to continue running.
      #
      # @raise [VedeuInterrupt] When we wish to terminate the running
      #   application.
      # @return [void]
      def safe_exit_point!
        fail VedeuInterrupt if @started && !@loop
      end

    end

  end # MainLoop

end # Vedeu
