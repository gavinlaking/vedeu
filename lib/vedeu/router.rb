module Vedeu

  # Stores all client application controllers with their respective actions.
  #
  module Router

    include Vedeu::Common

    extend self

    # @param controller_name [Symbol]
    # @param klass [String]
    # @return [void]
    def add_controller(controller_name, klass)
      unless present?(controller_name)
        fail Vedeu::MissingRequired,
             'Cannot store controller without a name attribute.'
      end

      if registered?(controller_name)
        storage[controller_name].merge!(klass: klass)

      else
        storage.store(controller_name, klass: klass, actions: [])

      end

      storage
    end

    # @param controller_name [Symbol]
    # @param action_name [Symbol]
    # @return [void]
    def add_action(controller_name, action_name)
      if present?(controller_name) && present?(action_name)
        if registered?(controller_name)
          storage[controller_name][:actions] << action_name

        else
          add_controller(controller_name, '')
          add_action(controller_name, action_name)

        end

        storage

      else
        fail Vedeu::MissingRequired,
             'Cannot store action without a controller or name attribute.'

      end
    end

    # @param controller_name [Symbol]
    # @param action_name [Symbol]
    # @param args [void]
    # @return [void]
    def goto(controller_name, action_name, **args)
      unless registered?(controller_name)
        fail Vedeu::ModelNotFound, "#{controller_name} is not registered."
      end

      controller_with(controller_name).send(action_name, args)
    end

    # @param controller_name [Symbol]
    # @return [Boolean]
    def registered?(controller_name)
      storage.key?(controller_name)
    end

    # @return [Hash<void>]
    def reset!
      @storage = in_memory
    end
    alias_method :reset, :reset!

    private

    # @param controller_name [Symbol]
    # @return [void]
    def controller_with(controller_name)
      Object.const_get(klass_for(controller_name)).new
    end

    # @param controller_name [Symbol]
    # @return [String]
    def klass_for(controller_name)
      if registered?(controller_name) && klass_defined?(controller_name)
        storage[controller_name][:klass]

      else
        fail Vedeu::MissingRequired,
             "Cannot route to #{controller_name} as no class defined."

      end
    end

    # @param controller_name [Symbol]
    # @return [Boolean]
    def klass_defined?(controller_name)
      present?(storage[controller_name][:klass])
    end

    # @return [Hash<Symbol => Hash<Symbol => String|Array<Symbol>>>]
    def storage
      @storage ||= in_memory
    end

    # @return [Hash<void>]
    def in_memory
      {}
    end

  end # Router

end # Vedeu
