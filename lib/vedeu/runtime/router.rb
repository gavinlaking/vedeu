module Vedeu

  # Stores all client application controllers with their respective actions.
  #
  module Router

    include Vedeu::Common

    extend self

    # Registers a controller with the given controller name for the client
    # application.
    #
    # @param controller_name [Symbol]
    # @param klass [String]
    # @raise [Vedeu::MissingRequired] When the controller name is not given.
    # @return [void]
    def add_controller(controller_name, klass)
      unless present?(controller_name)
        fail Vedeu::MissingRequired,
             'Cannot store controller without a name attribute.'
      end

      Vedeu.log(type:    :create,
                message: "Adding ':#{controller_name}'")

      if registered?(controller_name)
        storage[controller_name].merge!(klass: klass)

      else
        storage.store(controller_name, klass: klass, actions: [])

      end

      storage
    end

    # Registers an action to the given controller name for the client
    # application.
    #
    # @param controller_name [Symbol]
    # @param action_name [Symbol]
    # @raise [Vedeu::MissingRequired] When the controller name or action name is
    #   not given.
    # @return [void]
    def add_action(controller_name, action_name)
      if present?(controller_name) && present?(action_name)
        Vedeu.log(type:    :create,
                  message: "Adding ':#{action_name}' for ':#{controller_name}'")

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

    # Instruct Vedeu to load the client application controller action with
    # parameters.
    #
    # @example
    #   Vedeu.goto(controller_name, action_name, args)
    #
    # @param controller_name [Symbol]
    # @param action_name [Symbol]
    # @param args [void]
    # @raise [Vedeu::ModelNotFound] When the controller is not registered.
    # @return [void]
    def goto(controller_name, action_name, **args)
      if action_defined?(action_name, controller_name)
        Vedeu.log(type:    :debug,
                  message: "Routing: #{controller_name} #{action_name}")

        controller_with(controller_name).send(action_name, args)
      end
    end
    alias_method :action, :goto

    # Returns a boolean indicating whether the given controller name is already
    # registered.
    #
    # @param controller_name [Symbol]
    # @return [Boolean]
    def registered?(controller_name)
      storage.key?(controller_name)
    end

    # Removes all stored controllers with their respective actions.
    #
    # @return [Hash<void>]
    def reset!
      @storage = in_memory
    end
    alias_method :reset, :reset!

    private

    # Returns a boolean indicating whether the given action name is defined for
    # the given controller.
    #
    # @param action_name [Symbol]
    # @param controller_name [Symbol]
    # @return [Boolean]
    def action_defined?(action_name, controller_name)
      if registered?(controller_name)
        return true if storage[controller_name][:actions].include?(action_name)

        fail Vedeu::ActionNotFound,
             "#{action_name} is not registered for #{controller_name}."

      else
        fail Vedeu::ControllerNotFound, "#{controller_name} is not registered."

      end
    end

    # Instantiate the given controller by name.
    #
    # @param controller_name [Symbol]
    # @return [void]
    def controller_with(controller_name)
      Object.const_get(klass_for(controller_name)).new
    end

    # Fetch the class for the controller by name.
    #
    # @param controller_name [Symbol]
    # @raise [Vedeu::MissingRequired] When the given controller name does not
    #   have a class defined.
    # @return [String]
    def klass_for(controller_name)
      if registered?(controller_name) && klass_defined?(controller_name)
        storage[controller_name][:klass]

      else
        fail Vedeu::MissingRequired,
             "Cannot route to #{controller_name} as no class defined."

      end
    end

    # Returns a boolean indicating whether the given controller name has a class
    # defined.
    #
    # @param controller_name [Symbol]
    # @return [Boolean]
    def klass_defined?(controller_name)
      present?(storage[controller_name][:klass])
    end

    # Returns all the stored controllers and their respective actions.
    #
    # @return [Hash<Symbol => Hash<Symbol => String|Array<Symbol>>>]
    def storage
      @storage ||= in_memory
    end

    # Returns an empty collection ready for the storing of client application
    # controllers and actions.
    #
    # @return [Hash<void>]
    def in_memory
      {}
    end

  end # Router

end # Vedeu
