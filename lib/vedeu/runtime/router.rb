# frozen_string_literal: true

module Vedeu

  module Runtime

    # Stores all client application controllers with their respective
    # actions.
    #
    # @api public
    #
    module Router

      include Vedeu::Common

      extend Vedeu::Repositories::Storage
      extend self

      # Registers a controller with the given controller name for the
      # client application.
      #
      # @param controller [Symbol]
      # @param klass [String]
      # @macro raise_missing_required
      # @return [void]
      def add_controller(controller, klass)
        unless present?(controller)
          raise Vedeu::Error::MissingRequired,
                'Cannot store controller without a name attribute.'
        end

        Vedeu.log(type:    :create,
                  message: "Controller: ':#{controller}'")

        if registered?(controller)
          storage[controller][:klass] = klass

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
      # @macro raise_missing_required
      # @return [void]
      def add_action(controller, action)
        if present?(controller) && present?(action)
          Vedeu.log(type:    :create,
                    message: "Action: ':#{action}' " \
                             "(for ':#{controller}')")

          if registered?(controller)
            storage[controller][:actions] << action

          else
            add_controller(controller, '')
            add_action(controller, action)

          end

          storage

        else
          raise Vedeu::Error::MissingRequired,
                'Cannot store action without a controller or name ' \
                'attribute.'

        end
      end

      # {include:file:docs/dsl/by_method/goto.md}
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
      alias action goto

      # Returns a boolean indicating whether the given controller name
      # is already registered.
      #
      # @param controller [Symbol]
      # @return [Boolean]
      def registered?(controller)
        storage.key?(controller)
      end

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

          raise Vedeu::Error::ActionNotFound,
                "#{action} is not registered for #{controller}."

        else
          raise Vedeu::Error::ControllerNotFound,
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
      # @macro raise_missing_required
      # @return [String]
      def klass_for(controller)
        if registered?(controller) && klass_defined?(controller)
          storage[controller][:klass]

        else
          raise Vedeu::Error::MissingRequired,
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

      # Returns an empty collection ready for the storing of client
      # application controllers and actions.
      #
      # @return [Hash<void>]
      def in_memory
        {}
      end

    end # Router

  end # Runtime

  # @api public
  # @!method goto
  #   @see Vedeu::Runtime::Router#goto
  def_delegators Vedeu::Runtime::Router,
                 :goto

end # Vedeu
