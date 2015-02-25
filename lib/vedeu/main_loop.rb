module Vedeu

  # Provides the main loop for a Vedeu application.
  #
  class MainLoop

    trap('SIGTERM') { stop! }
    trap('TERM')    { stop! }
    trap('INT')     { stop! }

    # Start the main loop.
    #
    # @param block [Proc]
    # @return [void]
    def self.start!(&block)
      @started = true
      @loop    = true

      while(@loop) do
        Vedeu.trigger(:_tick_)

        yield

        safe_exit_point!
      end
    rescue VedeuInterrupt

    end

    # Signal that we wish to terminate the running application.
    #
    # @return [void]
    def self.stop!
      @loop = false
    end

    # Check the application has started and we wish to continue running.
    #
    # @raise [VedeuInterrupt] When we wish to terminate the running application.
    # @return [void]
    def self.safe_exit_point!
      if @started && !@loop
        fail VedeuInterrupt

      else
        Vedeu.trigger(:_tock_)

      end
    end

  end # MainLoop

end # Vedeu
