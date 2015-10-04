module Vedeu

  module Buffers

    # Used by Vedeu internally to manage the buffers of each interface
    # defined.
    #
    class Buffer

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
      # @return [String]
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

      # Add the content to the back buffer, then update the
      # repository. Returns boolean indicating that the repository was
      # updated.
      #
      # @param content [Vedeu::Views::View]
      # @return [Boolean]
      def add(content)
        @back = content

        store

        true
      end

      # Return a boolean indicating content presence on the buffer
      # type.
      #
      # @return [Boolean] Whether the buffer targetted has content.
      def back?
        return false if back.nil? || back.lines.empty?

        true
      end

      # Return a boolean indicating content presence on the buffer
      # type.
      #
      # @return [Boolean] Whether the buffer targetted has content.
      def front?
        return false if front.nil? || front.lines.empty?

        true
      end

      # Return a boolean indicating content presence on the buffer
      # type.
      #
      # @return [Boolean] Whether the buffer targetted has content.
      def previous?
        return false if previous.nil? || previous.lines.empty?

        true
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
      # @return [Array<Array<Array<Vedeu::Views::Char>>>]
      def render
        swap if back?

        if front?
          Vedeu::Output::Viewport.render(front)

        elsif previous?
          Vedeu::Output::Viewport.render(previous)

        end
      end

      private

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

      # Return a boolean indicating content was swapped between
      # buffers.
      #
      # @return [Boolean]
      def swap
        Vedeu.log(type: :output, message: "Buffer swapping: '#{name}'".freeze)

        @previous = front
        @front    = back
        @back     = nil

        store

        true
      end

    end # Buffer

  end # Buffers

end # Vedeu
