module Vedeu

  module Runtime

    # Stores all client application controllers with their respective
    # actions.
    #
    module Router

      include Vedeu::Common

      extend self

      # Registers a controller with the given controller name for the
      # client application.
      #
      # @param controller [Symbol]
      # @param klass [String]
      # @raise [Vedeu::Error::MissingRequired] When the controller
      #   name is not given.
      # @return [void]
      def add_controller(controller, klass)
        unless present?(controller)
          fail Vedeu::Error::MissingRequired,
               'Cannot store controller without a name attribute.'
        end

        Vedeu.log(type:    :create,
                  message: "Controller: ':#{controller}'")

        if registered?(controller)
          storage[controller].merge!(klass: klass)

        else
          storage.store(controller, klass: klass, actions: [])

        end

        storage
      end

      # Registers an action to the given controller name for the
      # client application.
      #
      # @param controller [Symbol]
      # @param action [Symbol]
      # @raise [Vedeu::Error::MissingRequired] When the controller
      #   name or action name is not given.
      # @return [void]
      def add_action(controller, action)
        if present?(controller) && present?(action)
          Vedeu.log(type:    :create,
                    message: "Action: ':#{action}' (for ':#{controller}')")

          if registered?(controller)
            storage[controller][:actions] << action

          else
            add_controller(controller, '')
            add_action(controller, action)

          end

          storage

        else
          fail Vedeu::Error::MissingRequired,
               'Cannot store action without a controller or name attribute.'

        end
      end

      # Instruct Vedeu to load the client application controller
      # action with parameters.
      #
      # @example
      #   Vedeu.goto(controller, action, args)
      #
      # @param controller [Symbol]
      # @param action [Symbol]
      # @param args [void]
      # @raise [Vedeu::Error::ModelNotFound] When the controller is
      #   not registered.
      # @return [void]
      def goto(controller, action, **args)
        Vedeu.log(type:    :debug,
                  message: "Routing: #{controller} #{action}")

        route(controller, action, args) if action_defined?(action, controller)
      end
      alias_method :action, :goto

      # Returns a boolean indicating whether the given controller name
      # is already registered.
      #
      # @param controller [Symbol]
      # @return [Boolean]
      def registered?(controller)
        storage.key?(controller)
      end

      # Removes all stored controllers with their respective actions.
      #
      # @return [Hash<void>]
      def reset!
        @storage = in_memory
      end
      alias_method :reset, :reset!

      private

      # Returns a boolean indicating whether the given action name is
      # defined for the given controller.
      #
      # @param action [Symbol]
      # @param controller [Symbol]
      # @return [Boolean]
      def action_defined?(action, controller)
        if registered?(controller)
          return true if storage[controller][:actions].include?(action)

          fail Vedeu::Error::ActionNotFound,
               "#{action} is not registered for #{controller}."

        else
          fail Vedeu::Error::ControllerNotFound,
               "#{controller} is not registered."

        end
      end

      # Instantiate the given controller by name, the call the action
      # (method) with any given arguments.
      #
      # @param controller [Symbol]
      # @param action [Symbol]
      # @param args [Symbol]
      # @return [void]
      def route(controller, action, **args)
        klass = Object.const_get(klass_for(controller)).new(**args)
        klass.send(action)
      end

      # Fetch the class for the controller by name.
      #
      # @param controller [Symbol]
      # @raise [Vedeu::Error::MissingRequired] When the given
      #   controller name does not have a class defined.
      # @return [String]
      def klass_for(controller)
        if registered?(controller) && klass_defined?(controller)
          storage[controller][:klass]

        else
          fail Vedeu::Error::MissingRequired,
               "Cannot route to #{controller} as no class defined."

        end
      end

      # Returns a boolean indicating whether the given controller name
      # has a class defined.
      #
      # @param controller [Symbol]
      # @return [Boolean]
      def klass_defined?(controller)
        present?(storage[controller][:klass])
      end

      # Returns all the stored controllers and their respective
      # actions.
      #
      # @return [Hash<Symbol => Hash<Symbol => String|Array<Symbol>>>]
      def storage
        @storage ||= in_memory
      end

      # Returns an empty collection ready for the storing of client
      # application controllers and actions.
      #
      # @return [Hash<void>]
      def in_memory
        {}
      end

    end # Router

  end # Runtime

end # Vedeu
