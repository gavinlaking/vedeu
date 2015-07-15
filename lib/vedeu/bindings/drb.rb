module Vedeu

  module Bindings

    # System events relating to the DRb server implementation.
    #
    # @api public
    # {include:file:docs/events/drb.md}
    # :nocov:
    module DRB

      # Setup events relating to the DRb server.
      #
      # @return [void]
      def self.setup!
        Vedeu.bind(:_drb_input_) do |data, type|
          Vedeu.log(type: :drb, message: "Sending input (#{type})")

          case type
          when :command then Vedeu.trigger(:_command_, data)
          else Vedeu.trigger(:_keypress_, data)
          end
        end

        # @todo This event queries Vedeu. Events should only be commands.
        Vedeu.bind(:_drb_retrieve_output_) { Vedeu::VirtualBuffer.retrieve }

        Vedeu.bind(:_drb_store_output_) do |data|
          Vedeu::VirtualBuffer.store(Vedeu::Terminal.virtual.output(data))
        end

        Vedeu.bind(:_drb_restart_) { Vedeu::Distributed::Server.restart }
        Vedeu.bind(:_drb_start_) { Vedeu::Distributed::Server.start }
        Vedeu.bind(:_drb_status_) { Vedeu::Distributed::Server.status }
        Vedeu.bind(:_drb_stop_) { Vedeu::Distributed::Server.stop }
      end

    end # DRB
    # :nocov:

  end # Bindings

end # Vedeu
