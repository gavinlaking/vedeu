module Vedeu

  module Buffers

    # Used by Vedeu internally to manage the buffers of each interface defined.
    #
    class Buffer

      include Vedeu::Model

      # The next buffer to be displayed; contains the content which will be
      # shown on next refresh.
      #
      # @!attribute [rw] back
      # @return [Vedeu::Views::View]
      attr_accessor :back

      # The currently displayed buffer, contains the content which was last
      # output.
      #
      # @!attribute [rw] front
      # @return [Vedeu::Views::View]
      attr_accessor :front

      # The previous buffer which was displayed; contains the content that was
      # shown before 'front'.
      #
      # @!attribute [rw] previous
      # @return [Vedeu::Views::View]
      attr_accessor :previous

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      # Return a new instance of Buffer. Generally a Buffer is initialized with
      # only a 'name' and 'back' parameter.
      #
      # @option attributes name [String] The name of the interface for which the
      #   buffer belongs.
      # @option attributes back [Vedeu::Views::View]
      # @option attributes front [Vedeu::Views::View]
      # @option attributes previous [Vedeu::Views::View]
      # @option attributes repository [Vedeu::Buffers::Repository]
      # @return [Vedeu::Buffers::Buffer]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Add the content to the back buffer, then update the repository.
      # Returns boolean indicating that the repository was updated.
      #
      # @param content [Vedeu::Views::View]
      # @return [Boolean]
      def add(content)
        @back = content

        store

        true
      end

      # Return a boolean indicating content presence on the buffer type.
      #
      # @return [Boolean] Whether the buffer targetted has content.
      def back?
        return false if back.nil? || back.lines.empty?

        true
      end

      # Clear the buffer.
      #
      # @return [Array<Array<Vedeu::Views::Char>>]
      def clear
        Vedeu::Output.render(Vedeu::Clear::NamedInterface.render(name))
      end

      # Return a boolean indicating content presence on the buffer type.
      #
      # @return [Boolean] Whether the buffer targetted has content.
      def front?
        return false if front.nil? || front.lines.empty?

        true
      end

      # Return a boolean indicating content presence on the buffer type.
      #
      # @return [Boolean] Whether the buffer targetted has content.
      def previous?
        return false if previous.nil? || previous.lines.empty?

        true
      end

      # Hide this buffer.
      #
      # @example
      #   Vedeu.trigger(:_hide_interface_, name)
      #   Vedeu.hide_interface(name)
      #
      # Will hide the named interface. If the interface is currently visible, it
      # will be cleared- rendered blank. To show the interface, the
      # ':_show_interface_' event should be triggered. Triggering the
      # ':_hide_group_' event to which this named interface belongs will also
      # hide the interface.
      #
      # @return [Array<Array<Array<Vedeu::Views::Char>>>]
      def hide
        Vedeu::Output.render(clear)
      end

      # Return the content for this buffer.
      #
      # - If we have new content (i.e. content on 'back') to be shown, we first
      #   clear the area occupied by the previous content, then clear the area
      #   for the new content, and then finally render the new content.
      # - If there is no new content (i.e. 'back' is empty), check the 'front'
      #   buffer and display that.
      # - If there is no new content, and the front buffer is empty, display the
      #   'previous' buffer.
      # - If the 'previous' buffer is empty, return an empty collection.
      #
      # @return [Array<Array<Array<Vedeu::Views::Char>>>]
      def render
        Vedeu::Output.render(buffer)
      end

      # Show this buffer.
      #
      # @example
      #   Vedeu.trigger(:_show_interface_, name)
      #   Vedeu.show_interface(name)
      #
      # Will show the named interface. If the interface is currently invisible,
      # it will be shown- rendered with its latest content. To hide the
      # interface, the ':_hide_interface_' event should be triggered. Triggering
      # the ':_show_group_' event to which this named interface belongs will
      # also show the interface.
      #
      # @return [Array<Array<Array<Vedeu::Views::Char>>>]
      def show
        Vedeu::Output.render(buffer)
      end

      private

      # Retrieve the latest content from the buffer.
      #
      # @return [Array<Array<Array<Vedeu::Views::Char>>>]
      def buffer
        swap if back?

        if front?
          [front.render]

        elsif previous?
          [previous.render]

        else
          []

        end
      end

      # Returns the default options/attributes for this class.
      #
      # @return [Hash<Symbol => NilClass, String>]
      def defaults
        {
          back:       nil,
          front:      nil,
          name:       '',
          previous:   nil,
          repository: Vedeu.buffers,
        }
      end

      # Return a boolean indicating content was swapped between buffers.
      #
      # @return [Boolean]
      def swap
        Vedeu.log(type: :output, message: "Buffer swapping: '#{name}'")

        @previous = front
        @front    = back
        @back     = nil

        store

        true
      end

    end # Buffer

  end # Buffers

end # Vedeu
