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

    # Return a boolean indicating content on the front buffer.
    #
    # @return [Boolean]
    def front?
      front.any? { |k, v| k == :lines && v.any? }
    end
    alias_method :current?, :front?

    # Return a boolean indicating content on the back buffer.
    #
    # @return [Boolean]
    def back?
      back.any? { |k, v| k == :lines && v.any? }
    end

    # Return a boolean indicating content on the previous buffer.
    #
    # @return [Boolean]
    def previous?
      previous.any? { |k, v| k == :lines && v.any? }
    end

    # Add the content to the back buffer, then update the repository. Returns
    # boolean indicating that the repository was updated.
    #
    # @param content [Hash]
    # @return [Boolean]
    def add(content = {})
      self.back = content

      update!
    end

    # Return a boolean indicating content was swapped between buffers. It also
    # resets the offsets (i.e. scroll/cursor position).
    #
    # @return [Boolean]
    def swap
      return false unless back?

      # Offsets.update({ name: name })

      self.previous = front
      self.front    = back
      self.back     = {}

      update!
    end

    private

    attr_writer :back, :front, :previous

    # @see Buffers#update
    def update!
      Buffers.update(self)
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
