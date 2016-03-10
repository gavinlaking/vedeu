# frozen_string_literal: true

module Vedeu

  module Buffers

    # Used by Vedeu internally to manage the buffers of each interface
    # defined.
    #
    class Buffer

      include Vedeu::Common
      include Vedeu::Repositories::Model

      # The next buffer to be displayed; contains the content which
      # will be shown on next refresh.
      #
      # @!attribute [rw] back
      # @return [Vedeu::Views::View]
      attr_accessor :back

      # The currently displayed buffer, contains the content which was
      # last output.
      #
      # @!attribute [rw] front
      # @return [Vedeu::Views::View]
      attr_accessor :front

      # The previous buffer which was displayed; contains the content
      # that was shown before 'front'.
      #
      # @!attribute [rw] previous
      # @return [Vedeu::Views::View]
      attr_accessor :previous

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      # Return a new instance of Buffer. Generally a Buffer is
      # initialized with only a 'name' and 'back' parameter.
      #
      # @option attributes name [String|Symbol] The name of the
      #   interface for which the buffer belongs.
      # @option attributes back [Vedeu::Views::View]
      # @option attributes front [Vedeu::Views::View]
      # @option attributes previous [Vedeu::Views::View]
      # @option attributes repository [Vedeu::Buffers::Repository]
      # @return [Vedeu::Buffers::Buffer]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Add the view to the back buffer, then update the repository.
      # Returns boolean indicating that the repository was updated.
      #
      # @param view [Vedeu::Views::View]
      # @param refresh [Boolean] Should the view be refreshed once
      #   stored? Default: false.
      # @return [Boolean]
      def add(view, refresh = false)
        @back = view

        store

        Vedeu.trigger(:_refresh_view_, view.name) if boolean(refresh)

        true
      end

      # Return a boolean indicating content presence on the buffer
      # type.
      #
      # @return [Boolean] Whether the buffer targetted has content.
      def back?
        (back.nil? || back.lines.empty?) ? false : true
      end

      # Return a boolean indicating whether the cursor should be
      # visible for this view.
      #
      # On a per-view (and per-interface) basis, the cursor can be
      # set to be visible or not visible.
      #
      # - If the cursor is visible, then refresh actions or events
      #   involving the cursor will act as normal; hiding and showing
      #   as the view is rendered or as events are triggered to change
      #   the visibility state.
      # - If the cursor is not visible, then refresh actions and
      #   events involving the cursor will be ignored- the cursor is
      #   not shown, so do no work.
      #
      # @return [Boolean]
      def cursor_visible?
        if front?
          front.cursor_visible?

        elsif previous?
          previous.cursor_visible?

        else
          interface.cursor_visible?

        end
      end

      # Return a boolean indicating content presence on the buffer
      # type.
      #
      # @return [Boolean] Whether the buffer targetted has content.
      def front?
        (front.nil? || front.lines.empty?) ? false : true
      end

      # Return a boolean indicating content presence on the buffer
      # type.
      #
      # @return [Boolean] Whether the buffer targetted has content.
      def previous?
        (previous.nil? || previous.lines.empty?) ? false : true
      end

      # Retrieve the latest content from the buffer.
      #
      # - If we have new content (i.e. content on 'back') to be shown,
      #   we first clear the area occupied by the previous content,
      #   then clear the area for the new content, and then finally
      #   render the new content.
      # - If there is no new content (i.e. 'back' is empty), check the
      #   'front' buffer and display that.
      # - If there is no new content, and the front buffer is empty,
      #   display the 'previous' buffer.
      # - If the 'previous' buffer is empty, return an empty
      #   collection.
      #
      # @return [Array<Array<Array<Vedeu::Cells::Char>>>]
      def render
        Vedeu::Output::Viewport.render(current)
      end

      # Returns the number of lines of content for the buffer or 0 if
      # the buffer is empty.
      #
      # @return [Fixnum]
      def size
        if back?
          back.lines.size

        elsif front?
          front.lines.size

        elsif previous?
          previous.lines.size

        else
          0

        end
      end

      private

      # @return [Vedeu::Views::View|NilClass]
      def current
        if back?
          swap

          front

        elsif front?
          front

        elsif previous?
          previous

        end
      end

      # @macro defaults_method
      def defaults
        {
          back:       nil,
          front:      nil,
          name:       nil,
          previous:   nil,
          repository: Vedeu.buffers,
        }
      end

      # @macro interface_by_name
      def interface
        Vedeu.interfaces.by_name(name)
      end

      # Return a boolean indicating content was swapped between
      # buffers.
      #
      # @return [Boolean]
      def swap
        Vedeu.log(type: :buffer, message: "Buffer swapping: '#{name}'")

        @previous = front
        @front    = back
        @back     = nil

        store

        true
      end

    end # Buffer

  end # Buffers

end # Vedeu
