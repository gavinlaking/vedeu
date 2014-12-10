module Vedeu

  # The Buffer object represents the states of display for an interface. The
  # states are 'front', 'back' and 'previous'.
  #
  # - 'front':    The currently displayed buffer; contains the content which was
  #               last output.
  # - 'back':     The next buffer to be displayed; contains the content which
  #               will be shown on next refresh.
  # - 'previous': The previous buffer which was displayed; contains the content
  #               that was shown before 'front'.
  #
  class Buffer

    include Model

    attr_reader :back, :front, :name, :previous
    alias_method :current, :front

    # Return a new instance of Buffer.
    #
    # @param attributes [Hash]
    # @return [Buffer]
    def initialize(attributes = {})
      @attributes = defaults.merge(attributes)

      @name     = @attributes[:name]
      @back     = @attributes[:back]
      @front    = @attributes[:front]
      @previous = @attributes[:previous]
    end

    # Add the content to the back buffer, then update the repository. Returns
    # boolean indicating that the repository was updated.
    #
    # @param content [Hash]
    # @return [Boolean]
    def add(content = {})
      self.back = content

      store

      true
    end

    # Return a boolean indicating content was swapped between buffers. It also
    # resets the offsets (i.e. scroll/cursor position).
    #
    # @return [Boolean]
    def swap
      return false unless content_for?(:back)

      # Offsets.update({ name: name })

      self.previous = front
      self.front    = back
      self.back     = {}

      store

      true
    end

    # Return the content for this buffer.
    #
    # - If we have new content (i.e. content on 'back') to be shown, we first
    #   clear the area occupied by the previous content, then clear the area for
    #   the new content, and then finally render the new content.
    # - If there is no new content (i.e. 'back' is empty), check the 'front'
    #   buffer and display that.
    # - If there is no new content, and the front buffer is empty, display the
    #   'previous' buffer.
    # - If the 'previous' buffer is empty, return an empty hash.
    #
    # @return [Array<Hash>]
    def content
      if content_for?(:back)
        swap

        [clear_if_previous, front]

      elsif content_for?(:front)
        [front]

      elsif content_for?(:previous)
        [previous]

      else
        [{}]

      end
    end

    private

    attr_writer :back, :front, :previous

    def clear_if_previous
      if content_for?(:previous)
        previous

      else
        {}

      end
    end

    # Return a boolean indicating content presence on the buffer type.
    #
    # @param buffer [Symbol] One of; :back, :current/:front or :previous.
    # @return [Boolean] Whether the buffer targetted has content.
    def content_for?(buffer)
      public_send(buffer).any? do |k, v|
        k == :lines && v.any?
      end
    end

    # @return [Class] The repository class for this model.
    def repository
      Vedeu::Buffers
    end

    # Return the default attributes of a Buffer.
    #
    # @return [Hash]
    def defaults
      {
        name:     '',
        back:     {},
        front:    {},
        previous: {},
      }
    end

  end # Buffer

end # Vedeu
