module Vedeu

  module Bindings

    # System events relating to the document/editor/fake terminal
    # implementation.
    #
    # :nocov:
    module Document

      extend self

      # Setup events relating to the document/editor/fake terminal.
      # This method is called by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        editor_execute!
        editor_delete_character!
        editor_delete_line!
        editor_down!
        editor_insert_character!
        editor_insert_line!
        editor_left!
        editor_right!
        editor_up!
      end

      private

      # @example
      #   Vedeu.trigger(:_editor_execute_, name)
      #
      # @return [TrueClass]
      def editor_execute!
        Vedeu.bind(:_editor_execute_) do |name|
          Vedeu.documents.by_name(name).execute
        end
      end

      # This event attempts to delete the character in the named
      # document at the current virtual cursor position.
      #
      # @example
      #   Vedeu.trigger(:_editor_delete_character_, name)
      #
      # @return [TrueClass]
      def editor_delete_character!
        Vedeu.bind(:_editor_delete_character_) do |name|
          Vedeu.documents.by_name(name).delete_character
        end
      end

      # This event attempts to delete the line in the named document
      # at the current virtual cursor position.
      #
      # @example
      #   Vedeu.trigger(:_editor_delete_line_, name)
      #
      # @return [TrueClass]
      def editor_delete_line!
        Vedeu.bind(:_editor_delete_line_) do |name|
          Vedeu.documents.by_name(name).delete_line
        end
      end

      # This event attempts to move the virtual cursor down by one
      # line in the named document.
      #
      # @example
      #   Vedeu.trigger(:_editor_down_, name)
      #
      # @return [TrueClass]
      def editor_down!
        Vedeu.bind(:_editor_down_) do |name|
          Vedeu.documents.by_name(name).down
        end
      end

      # This event attempts to insert the given character in the named
      # document at the current virtual cursor position.
      #
      # @example
      #   Vedeu.trigger(:_editor_insert_character_, name, character)
      #
      # @return [TrueClass]
      def editor_insert_character!
        Vedeu.bind(:_editor_insert_character_) do |name, character|
          Vedeu.documents.by_name(name).insert_character(character)
        end
      end

      # This event attempts to insert a new line in the named document
      # at the current virtual cursor position.
      #
      # @example
      #   Vedeu.trigger(:_editor_insert_line_, name)
      #
      # @return [TrueClass]
      def editor_insert_line!
        Vedeu.bind(:_editor_insert_line_) do |name|
          Vedeu.documents.by_name(name).insert_line
        end
      end

      # This event attempts to move the virtual cursor left by one
      # character in the named document.
      #
      # @example
      #   Vedeu.trigger(:_editor_left_, name)
      #
      # @return [TrueClass]
      def editor_left!
        Vedeu.bind(:_editor_left_) { |name| Vedeu.documents.by_name(name).left }
      end

      # This event attempts to move the virtual cursor right by one
      # character in the named document.
      #
      # @example
      #   Vedeu.trigger(:_editor_right_, name)
      #
      # @return [TrueClass]
      def editor_right!
        Vedeu.bind(:_editor_right_) do |name|
          Vedeu.documents.by_name(name).right
        end
      end

      # This event attempts to move the virtual cursor up by one line
      # in the named document.
      #
      # @example
      #   Vedeu.trigger(:_editor_up_, name)
      #
      # @return [TrueClass]
      def editor_up!
        Vedeu.bind(:_editor_up_) { |name| Vedeu.documents.by_name(name).up }
      end

    end # Document
    # :nocov:

  end # Bindings

end # Vedeu
