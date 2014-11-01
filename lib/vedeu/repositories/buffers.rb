module Vedeu

  # Stores interface views to be later combined with interface geometry to be
  # displayed.
  #
  # @api private
  module Buffers

    include Repository
    extend self

    # Add an interface view into the back buffer. If the buffer is already
    # registered, then we preserve its front buffer. Returns the name of the
    # buffer added to storage.
    #
    # @param attributes [Hash]
    # @return [String]
    def add(attributes)
      validate_attributes!(attributes)

      if registered?(attributes[:name])
        buffer = find(attributes[:name])

        buffer[:back_buffer] = attributes

      else
        storage.store(attributes[:name], {
          back_buffer:     attributes,
          front_buffer:    nil,
          previous_buffer: nil,
        })

      end

      attributes[:name]
    end

    # Return the named back buffer.
    #
    # @param name [String]
    # @raise [BufferNotFound] When the named buffer cannot be found.
    # @return [Hash|Nil]
    def back(name)
      find(name)[:back_buffer]
    end

    # Return the named front buffer.
    #
    # @param name [String]
    # @raise [BufferNotFound] When the named buffer cannot be found.
    # @return [Hash|NilClass]
    def front(name)
      find(name)[:front_buffer]
    end
    alias_method :current, :front

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
    # @return [Hash|NilClass]
    def latest(name)
      if new_content?(name)
        Vedeu.log("New content found for '#{name}'")

        swap_buffers(name)
      end

      front(name)
    end

    # Returns a boolean indicating whether there is new content available to be
    # displayed.
    #
    # @param name [String] The name of the buffer.
    # @return [Boolean]
    def latest?(name)
      !!(latest(name))
    end

    # Returns the named, previous 'front' buffer; i.e. the buffer on the screen.
    # This may be empty if nothing has previously been shown.
    #
    # @param name [String]
    # @raise [BufferNotFound] When the named buffer cannot be found.
    # @return [Hash|NilClass]
    def previous(name)
      find(name)[:previous_buffer]
    end

    # Returns a boolean indicating whether there is a previous buffer available.
    #
    # @param name [String] The name of the buffer.
    # @return [Boolean]
    def previous?(name)
      !!(previous(name))
    end

    private

    # Swap the named back buffer into the front buffer of the same name. This is
    # called when the back buffer has new content (perhaps as part of a
    # refresh). It also resets the offsets (i.e. scroll position)
    #
    # @param name [String]
    # @raise [BufferNotFound] When the named buffer cannot be found.
    # @return [Hash]
    def swap_buffers(name)
      buffer = find(name)

      Offsets.update({ name: name })

      storage.store(name, {
        front_buffer:    buffer[:back_buffer],
        back_buffer:     nil,
        previous_buffer: buffer[:front_buffer],
      })
    end

    # Return a boolean indicating whether the named back buffer has new content.
    #
    # @param name [String]
    # @return [Boolean]
    def new_content?(name)
      defined_value?(back(name))
    end

    # @return [Hash]
    def in_memory
      Hash.new do |hash, interface_name|
        hash[interface_name] = {
          front_buffer:    nil,
          back_buffer:     nil,
          previous_buffer: nil,
        }
      end
    end

    # @param name [String]
    # @raise [BufferNotFound] When the entity cannot be found with this name.
    # @return [BufferNotFound]
    def not_found(name)
      fail BufferNotFound, "Cannot find buffer with this name: #{name}."
    end

  end # Buffers

end # Vedeu
