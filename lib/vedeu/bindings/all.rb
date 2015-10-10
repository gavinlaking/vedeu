module Vedeu

  # Binds various events for running and manipulating Vedeu. When
  # called provide a variety of core functions and behaviours.
  # They are soft-namespaced using underscores.
  #
  # @note
  #   The methods these modules use are private, and should not be
  #   called directly, however the produced events are all public and
  #   are highly recommended to be used.
  #
  #   Unbinding any of these events is likely to cause problems, so I
  #   would advise leaving them alone. A safe rule: when the name
  #   starts and ends with an underscore, it's probably used by Vedeu
  #   internally.
  #
  module Bindings

    extend self

    # Setup events for running Vedeu. This method is called by Vedeu.
    #
    # @return [TrueClass]
    def setup!
      cleanup!
      command!
      drb_input!

      true
    end

    private

    # See {file:docs/events/system.md#\_cleanup_}
    def cleanup!
      Vedeu.bind(:_cleanup_) do
        Vedeu.trigger(:_drb_stop_)
        Vedeu.trigger(:cleanup)
      end
    end

    # See {file:docs/events/system.md#\_command_}
    def command!
      Vedeu.bind(:_command_) { |command| Vedeu.trigger(:command, command) }
    end

    # See {file:docs/events/drb.md#\_drb_input_}
    def drb_input!
      Vedeu.bind(:_drb_input_) do |data, type|
        Vedeu.log(type: :drb, message: "Sending input (#{type})".freeze)

        case type
        when :command  then Vedeu.trigger(:_command_, data)
        when :keypress then Vedeu.trigger(:_keypress_, data)
        else Vedeu.trigger(:_keypress_, data)
        end
      end
    end

  end # Bindings

  Vedeu::Bindings.setup!

end # Vedeu
