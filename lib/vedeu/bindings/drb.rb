module Vedeu

  module Bindings

    # System events relating to the DRb server implementation.
    #
    # @api public
    module DRB

      # Triggering this event will send input to the running application as long
      # as it has the DRb server running.
      Vedeu.bind(:_drb_input_) do |data, type|
        Vedeu.log(type: :drb, message: "Sending input (#{type})")

        case type
        when :command then Vedeu.trigger(:_command_, data)
        else Vedeu.trigger(:_keypress_, data)
        end
      end

      # @todo This event queries Vedeu. Events should only be commands.
      Vedeu.bind(:_drb_retrieve_output_) { Vedeu::VirtualBuffer.retrieve }

      # Triggering this event with 'data' will push data into the running
      # application's virtual buffer.
      Vedeu.bind(:_drb_store_output_) do |data|
        Vedeu::VirtualBuffer.store(Vedeu::Terminal.virtual.output(data))
      end

      # Use the DRb server to request the client application to restart.
      Vedeu.bind(:_drb_restart_) { Vedeu::Distributed::Server.restart }

      # Use the DRb server to request the client application to start.
      Vedeu.bind(:_drb_start_) { Vedeu::Distributed::Server.start }

      # Use the DRb server to request the status of the client application.
      Vedeu.bind(:_drb_status_) { Vedeu::Distributed::Server.status }

      # Use the DRb server to request the client application to stop.
      Vedeu.bind(:_drb_stop_) { Vedeu::Distributed::Server.stop }

    end # DRB

  end # Bindings

end # Vedeu
