# frozen_string_literal: true

module Vedeu

  module Models

    # The Focus repository is simply a collection of interface names,
    # this module serving to store and manipulate the which interface
    # is currently being focussed.
    #
    # @note
    #   - Interfaces are added to the collection in the order they are
    #     defined.
    #   - If the interface definition contains `focus!`,
    #     (see Vedeu::Interfaces::DSL#focus!) then that interface is
    #     prepended to the list.
    #   - If the `Vedeu.focus_by_name 'some_interface'` declaration is
    #     used, then the list pointer (`current`) is set to the
    #     interface of that name.
    #
    module Focus

      extend self

      # Add an interface name to the focus list unless it is already
      # registered.
      #
      # @macro param_name
      # @param focus [Boolean] When true, prepends the interface name
      #   to the collection, making that interface the currently
      #   focussed interface.
      # @return [Array] The collection of interface names.
      def add(name, focus = false)
        if registered?(name)
          return storage unless focus

          by_name(name)

        else
          Vedeu.log(type:    :store,
                    message: "Storing focus entry: '#{name}'")

          focus ? storage.unshift(name) : storage.push(name)
        end
      end

      # Focus an interface by name. Used after defining an interface
      # or interfaces to set the initially focussed interface.
      #
      # @example
      #   Vedeu.trigger(:_focus_by_name_, name)
      #   Vedeu.focus_by_name('name')
      #
      # @macro param_name
      # @raise [Vedeu::Error::ModelNotFound] When the interface cannot
      #   be found.
      # @return [String|Symbol] The name of the interface now in
      #   focus.
      def by_name(name)
        not_registered!(name) unless registered?(name)

        storage.rotate!(storage.index(name))

        update
      end
      alias focus_by_name by_name

      # Return the interface currently focussed.
      #
      # @example
      #   Vedeu.focus
      #
      # @return [NilClass|String|Symbol]
      def current
        return nil if storage.empty?

        storage[0]
      end
      alias focus current
      alias name current

      # Returns a boolean indicating whether the named interface is
      # focussed.
      #
      # @example
      #   Vedeu.focussed?(name)
      #
      # @macro param_name
      # @return [Boolean]
      def current?(name)
        current == name
      end
      alias focussed? current?

      # Returns a boolean indicating whether there are interfaces
      # registered.
      #
      # @return [Boolean]
      def focus?
        !storage.empty?
      end

      # Put the next interface relative to the current interfaces in
      # focus.
      #
      # @example
      #   Vedeu.trigger(:_focus_next_)
      #   Vedeu.focus_next
      #
      # @return [String|Symbol]
      def next_item
        storage.rotate!

        update
      end
      # alias next_item

      # Put the next visible interface relative to the current
      # interfaces in focus.
      #
      # @return [String|Symbol]
      def next_visible_item
        return update unless visible_items?

        loop do
          storage.rotate!
          break if interface.visible?
        end

        update
      end
      alias focus_next next_visible_item

      # Put the previous interface relative to the current interface
      # in focus.
      #
      # @example
      #   Vedeu.trigger(:_focus_prev_)
      #   Vedeu.focus_previous
      #
      # @return [String|Symbol]
      def prev_item
        storage.rotate!(-1)

        update
      end
      alias prev prev_item
      alias previous prev_item

      # Put the previous visible interface relative to the current
      # interfaces in focus.
      #
      # @return [String|Symbol]
      def prev_visible_item
        return update unless visible_items?

        loop do
          storage.rotate!(-1)
          break if interface.visible?
        end

        update
      end
      alias focus_previous prev_visible_item

      # Refresh the interface in focus.
      #
      # @return [Array]
      def refresh
        Vedeu.trigger(:_refresh_view_, current)

        Vedeu.trigger(:_refresh_cursor_, current)
      end

      # Access to the storage for this repository.
      #
      # @return [Array]
      def storage
        @storage ||= in_memory
      end
      alias registered storage

      # Returns a boolean indicating whether the named model is
      # registered.
      #
      # @macro param_name
      # @return [Boolean]
      def registered?(name)
        return false if storage.empty?

        storage.include?(name)
      end

      # Reset the repository.
      #
      # @return [Array|Hash|Set]
      def reset!
        @storage = in_memory
      end
      alias reset reset!

      private

      # @return [Vedeu::Interfaces::Interface]
      def interface
        Vedeu.interfaces.by_name(current)
      end

      # @raise [Vedeu::Error::ModelNotFound]
      def not_registered!(name)
        raise Vedeu::Error::ModelNotFound,
              "Cannot focus '#{name}' as this interface has not been " \
              'registered.'
      end

      # Return the name of the interface in focus after triggering the
      # refresh event for that interface. Returns false when the
      # storage is empty.
      #
      # @return [String|Boolean]
      def update
        return false if storage.empty?

        Vedeu.log(message: "Interface in focus: '#{current}'")

        refresh

        current
      end

      # Returns an empty collection ready for the storing of interface
      # names.
      #
      # @return [Array]
      def in_memory
        []
      end

      # @return [Boolean]
      def visible_items?
        storage.any? { |name| Vedeu.interfaces.by_name(name).visible? }
      end

    end # Focus

  end # Models

  # @api public
  # @!method focus
  #   @see Vedeu::Models::Focus#focus
  # @api public
  # @!method focus?
  #   @see Vedeu::Models::Focus#focus?
  # @api public
  # @!method focus_by_name
  #   @see Vedeu::Models::Focus#focus_by_name
  # @api public
  # @!method focussed?
  #   @see Vedeu::Models::Focus#focussed?
  # @api public
  # @!method focus_next
  #   @see Vedeu::Models::Focus#focus_next
  # @api public
  # @!method focus_previous
  #   @see Vedeu::Models::Focus#focus_previous
  def_delegators Vedeu::Models::Focus,
                 :focus,
                 :focus?,
                 :focus_by_name,
                 :focussed?,
                 :focus_next,
                 :focus_previous

end # Vedeu
