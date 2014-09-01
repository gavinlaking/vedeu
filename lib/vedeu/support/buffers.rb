module Vedeu
  module Buffers

    extend self

    # @param attributes [Hash]
    # @return [Hash]
    def create(attributes)
      store_attributes(attributes)

      groups.add(attributes[:group], attributes[:name], attributes[:delay])

      focus.add(attributes[:name])

      register_refresh_event(attributes)

      store_interface(Interface.new(attributes))
    end

    # @return [Hash]
    def reset
      @_storage = {}
      @_buffers = {}
      @_focus = Focus.new
      groups.reset
    end

    # Retrieves the attributes used to define the interface.
    #
    # @param name [String]
    # @return [Hash]
    def retrieve_attributes(name)
      storage.fetch(name) do
        fail InterfaceNotFound, "Interface was not found with #{name.to_s}"
      end
    end

    # Retrieves the last stored version of the interface.
    #
    # @param name [String]
    # @return [Buffer]
    def retrieve_interface(name)
      buffers.fetch(name) do
        fail InterfaceNotFound, "Interface was not found with #{name.to_s}"
      end
    end

    # Stores the interface attributes defined by the API.
    #
    # @param attributes [Hash]
    # @return [Hash]
    def store_attributes(attributes)
      storage.store(attributes[:name], attributes)
    end

    # Stores the latest version of the interface.
    #
    # @param interface [Interface]
    # @return [Buffer]
    def store_interface(interface)
      update(interface.name,
        Buffer.new(interface: interface, back: nil, front: nil))
    end

    # Pushes the view on to the 'back' buffer; next time a refresh occurs, this
    # view will be pulled on to the 'front' buffer to be displayed.
    #
    # @param name [String]
    # @param view [Interface]
    # @return []
    def enqueue(name, view)
      update(name, retrieve_interface(name).enqueue(view))
    end

    # Causes all registered interfaces to refresh. If they have new content,
    # that will be displayed. If they have no content, then the area will be
    # blank. Otherwise, the previous content will be displayed.
    #
    # @return [Array]
    def refresh_all
      buffers.keys.map { |name| refresh(name) }
    end

    # Causes all interfaces of a particular group to be refreshed.
    #
    # @return [Array]
    def refresh_group(group_name)
      groups.find(group_name).map { |name| refresh(name) }
    end

    # Causes a single interface by name to be refreshed. After refreshing, the
    # interface is stored as the latest version.
    #
    # @param name [String]
    # @return []
    def refresh(name)
      update(name, retrieve_interface(name).refresh)
    end

    # Returns all registered groups by name.
    #
    # @return [Array]
    def registered_groups
      groups.registered
    end

    # Returns all registered interfaces by name.
    #
    # @return [Array]
    def registered_interfaces
      storage.keys
    end

    private

    # @api private
    # @return []
    def update(name, buffer)
      buffers.store(name, buffer)
    end

    # @api private
    # @return []
    def register_refresh_event(attributes)
      name  = attributes[:name]
      delay = attributes[:delay]
      event = "_refresh_#{name}_".to_sym

      Vedeu.event(event, { delay: delay }) { Vedeu::Buffers.refresh(name) }
    end

    # @api private
    # @return [Focus]
    def focus
      @_focus ||= Focus.new
    end

    # @api private
    # @return [Groups]
    def groups
      @_groups ||= Groups.new
    end

    # @api private
    # @return [Hash]
    def buffers
      @_buffers ||= {}
    end

    # @api private
    # @return [Hash]
    def storage
      @_storage ||= {}
    end

  end
end
