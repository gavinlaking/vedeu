module Vedeu
  module Buffers

    extend self

    # @param attributes [Hash]
    # @return [Hash]
    def create(attributes)
      store_attributes(attributes)

      groups.add(attributes[:group], attributes[:name], attributes[:delay])

      focus.add(attributes[:name])

      store_interface(Interface.new(attributes))
    end

    # @return [Hash]
    def reset
      @_storage = {}
      @_buffers = {}
      groups.reset
    end

    # @param name [String]
    # @return [Hash]
    def retrieve_attributes(name)
      storage.fetch(name) { fail EntityNotFound, 'Interface was not found.' }
    end

    # @param name [String]
    # @return [Buffer]
    def retrieve_interface(name)
      buffers.fetch(name) { fail EntityNotFound, 'Interface was not found.' }
    end

    # @param attributes [Hash]
    # @return [Hash]
    def store_attributes(attributes)
      storage.store(attributes[:name], attributes)
    end

    # @param interface [Interface]
    # @return [Buffer]
    def store_interface(interface)
      update(interface.name,
        Buffer.new(interface: interface, back: nil, front: nil))
    end

    # @param name [String]
    # @param view [Interface]
    # @return []
    def enqueue(name, view)
      update(name, retrieve_interface(name).enqueue(view))
    end

    # @return [Array]
    def refresh_all
      buffers.keys.map { |name| refresh(name) }
    end

    # @return [Array]
    def refresh_group(group_name)
      groups.find(group_name).map { |name| refresh(name) }
    end

    # @param name [String]
    # @return []
    def refresh(name)
      update(name, retrieve_interface(name).refresh)
    end

    private

    # @return []
    def update(name, buffer)
      buffers.store(name, buffer)
    end

    # @return [Focus]
    def focus
      @_focus ||= Focus.new
    end

    # @return [Groups]
    def groups
      @_groups ||= Groups.new
    end

    # @return [Hash]
    def buffers
      @_buffers ||= {}
    end

    # @return [Hash]
    def storage
      @_storage ||= {}
    end

  end
end
