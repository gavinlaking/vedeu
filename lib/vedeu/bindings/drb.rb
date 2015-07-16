module Vedeu

  module Bindings

    # System events relating to the DRb server implementation.
    #
    # @api public
    # {include:file:docs/events/drb.md}
    # :nocov:
    module DRB

      extend self

      # Setup events relating to the DRb server.
      #
      # @return [void]
      def setup!
        drb_input!
        drb_retrieve_output!
        drb_store_output!
        drb_restart!
        drb_start!
        drb_status!
        drb_stop!
      end

      def drb_input!
        Vedeu.bind(:_drb_input_) do |data, type|
          Vedeu.log(type: :drb, message: "Sending input (#{type})")

          case type
          when :command then Vedeu.trigger(:_command_, data)
          else Vedeu.trigger(:_keypress_, data)
          end
        end
      end

      # @todo This event queries Vedeu. Events should only be commands.
      def drb_retrieve_output!
        Vedeu.bind(:_drb_retrieve_output_) { Vedeu::VirtualBuffer.retrieve }
      end

      def drb_store_output!
        Vedeu.bind(:_drb_store_output_) do |data|
          Vedeu::VirtualBuffer.store(Vedeu::Terminal.virtual.output(data))
        end
      end

      def drb_restart!
        Vedeu.bind(:_drb_restart_) { Vedeu::Distributed::Server.restart }
      end

      def drb_start!
        Vedeu.bind(:_drb_start_) { Vedeu::Distributed::Server.start }
      end

      def drb_status!
        Vedeu.bind(:_drb_status_) { Vedeu::Distributed::Server.status }
      end

      def drb_stop!
        Vedeu.bind(:_drb_stop_) { Vedeu::Distributed::Server.stop }
      end

    end # DRB
    # :nocov:

  end # Bindings

end # Vedeu
