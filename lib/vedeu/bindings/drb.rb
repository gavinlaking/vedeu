module Vedeu

  module Bindings

    # System events relating to the DRb server implementation.
    #
    module DRB

      extend self

      # Setup events relating to the DRb server. This method is called
      # by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        drb_input!
        drb_retrieve_output!
        drb_store_output!
        drb_restart!
        drb_start!
        drb_status!
        drb_stop!
      end

      private

      # See {file:docs/events/drb.md#\_drb_input_}
      def drb_input!
        Vedeu.bind(:_drb_input_) do |data, type|
          Vedeu.log(type: :drb, message: "Sending input (#{type})")

          case type
          when :command  then Vedeu.trigger(:_command_, data)
          when :keypress then Vedeu.trigger(:_keypress_, data)
          else Vedeu.trigger(:_keypress_, data)
          end
        end
      end

      # See {file:docs/events/drb.md#\_drb_retrieve_output_}
      def drb_retrieve_output!
        Vedeu.bind(:_drb_retrieve_output_) do
          Vedeu::Buffers::VirtualBuffers.retrieve
        end
      end

      # See {file:docs/events/drb.md#\_drb_store_output_}
      def drb_store_output!
        Vedeu.bind(:_drb_store_output_) do |data|
          Vedeu::Buffers::VirtualBuffers.store(
            Vedeu::Buffers::VirtualBuffer.output(data)
          )
        end
      end

      # See {file:docs/events/drb.md#\_drb_restart_}
      def drb_restart!
        Vedeu.bind(:_drb_restart_) { Vedeu::Distributed::Server.restart }
      end

      # See {file:docs/events/drb.md#\_drb_start_}
      def drb_start!
        Vedeu.bind(:_drb_start_) { Vedeu::Distributed::Server.start }
      end

      # See {file:docs/events/drb.md#\_drb_status_}
      def drb_status!
        Vedeu.bind(:_drb_status_) { Vedeu::Distributed::Server.status }
      end

      # See {file:docs/events/drb.md#\_drb_stop_}
      def drb_stop!
        Vedeu.bind(:_drb_stop_) { Vedeu::Distributed::Server.stop }
      end

    end # DRB

  end # Bindings

end # Vedeu
