require 'vedeu/models/model'

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

    include Vedeu::Model

    attr_reader :back, :front, :name, :previous, :repository

    # Return a new instance of Buffer.
    #
    # @param name [String] The name of the interface for which the buffer
    #   belongs.
    # @param back [Interface]
    # @param front [Interface]
    # @param previous [Interface]
    # @return [Buffer]
    def initialize(name, back = nil, front = nil, previous = nil, repository = nil)
      @name       = name
      @back       = back
      @front      = front
      @previous   = previous
      @repository = repository || Vedeu.buffers
    end

    # Add the content to the back buffer, then update the repository. Returns
    # boolean indicating that the repository was updated.
    #
    # @param content [Interface]
    # @return [Boolean]
    def add(content)
      @back = content

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
    # - If the 'previous' buffer is empty, return an empty collection.
    #
    # @return [Array<Hash>]
    def content
      if content_for?(:back)
        swap

        [clear_if_previous, front].compact

      elsif content_for?(:front)
        [front]

      elsif content_for?(:previous)
        [previous]

      else
        []

      end
    end

    # Return a boolean indicating content was swapped between buffers. It also
    # resets the cursors position.
    #
    # @return [Boolean]
    def swap
      # TODO: Investigate if this is needed. (GL: 2015-01-20 19:43)
      # Vedeu.trigger(:_cursor_origin_)

      @previous = front
      @front    = back
      @back     = nil

      store

      true
    end

    private

    def clear_if_previous
      if content_for?(:previous)
        previous

      else
        nil

      end
    end

    # Return a boolean indicating content presence on the buffer type.
    #
    # @param buffer [Symbol] One of; :back, :front or :previous.
    # @return [Boolean] Whether the buffer targetted has content.
    def content_for?(buffer)
      return false if public_send(buffer).nil?

      return false if public_send(buffer).lines.empty?

      true
    end

  end # Buffer

end # Vedeu
