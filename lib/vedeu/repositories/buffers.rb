module Vedeu

  # Stores interface views to be later combined with interface geometry to be
  # displayed.
  #
  # @api private
  module Buffers

    include Vedeu::Common
    extend self

    # Add an interface view into the back buffer. If the buffer is already
    # registered, then we preserve its front buffer. Returns the name of the
    # buffer added to storage.
    #
    # @param attributes [Hash]
    # @return [String]
    def add(attributes)
      if registered?(attributes[:name])
        buffer = find(attributes[:name])

        buffer[:back_buffer] = attributes

      else
        storage.store(attributes[:name], {
          back_buffer:  attributes,
          front_buffer: nil,
        })

      end

      attributes[:name]
    end

    # Find the buffer by name.
    #
    # @param name [String]
    # @return [Hash]
    def find(name)
      storage.fetch(name) do
        fail BufferNotFound, "Cannot find buffer with this name: #{name.to_s}."
      end
    end

    # Returns the latest content for the named buffer. The latest content always
    # goes on to the back buffer. The content which was last output is on the
    # front buffer.
    #
    # When the back buffer has new content, we swap the back onto the front and
    # return the front buffer to be rendered.
    #
    # When the back buffer has no new content, we display that which we
    # previously displayed, by returning the front buffer.
    #
    # If both the back and front buffers have no content, then the view is blank
    # and we should return nothing.
    #
    # @param name [String]
    # @return [Hash]
    def latest(name)
      if new_content?(name)
        swap_buffers(name)
        front_buffer(name)

      elsif old_content?(name)
        front_buffer(name)

      else
        nil

      end
    end

    # Returns a collection of the names of all registered buffers.
    #
    # @return [Array]
    def registered
      storage.keys
    end

    # Returns a boolean indicating whether the named buffer is registered.
    #
    # @api private
    # @param name [String]
    # @return [TrueClass|FalseClass]
    def registered?(name)
      storage.key?(name)
    end

    # Reset the buffers repository; removing all buffers. This does not delete
    # the interfaces themselves.
    #
    # @return [Hash]
    def reset
      @_storage = in_memory
    end

    private

    # Swap the named back buffer into the front buffer of the same name.
    #
    # @api private
    # @param name [String]
    # @return [Hash]
    def swap_buffers(name)
      buffer = find(name)

      storage.store(name, {
        front_buffer: buffer[:back_buffer],
        back_buffer:  nil,
      })
    end

    # Return a boolean indicating whether the named back buffer has new content.
    #
    # @api private
    # @param name [String]
    # @return [TrueClass|FalseClass]
    def new_content?(name)
      defined_value?(back_buffer(name))
    end

    # Return a boolean indicating whether the named front buffer has content.
    #
    # @api private
    # @param name [String]
    # @return [TrueClass|FalseClass]
    def old_content?(name)
      defined_value?(front_buffer(name))
    end

    # Return the named back buffer.
    #
    # @api private
    # @param name [String]
    # @return [Hash|Nil]
    def back_buffer(name)
      find(name).fetch(:back_buffer, nil)
    end

    # Return the named front buffer.
    #
    # @api private
    # @param name [String]
    # @return [Hash|Nil]
    def front_buffer(name)
      find(name).fetch(:front_buffer, nil)
    end

    # Access to the storage for this repository.
    #
    # @api private
    # @return [Hash]
    def storage
      @_storage ||= in_memory
    end

    # @api private
    # @return [Hash]
    def in_memory
      Hash.new do |hash, interface_name|
        hash[interface_name] = {
          front_buffer: nil,
          back_buffer:  nil,
        }
      end
    end

  end

end
