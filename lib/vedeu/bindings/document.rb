module Vedeu

  module Bindings

    # System events relating to the document/editor/fake terminal
    # implementation.
    #
    # :nocov:
    module Document

      extend self

      # Setup events relating to the document/editor/fake terminal. This method
      # is called by Vedeu.
      #
      # @return [TrueClass]
      def setup!
        editor_command!
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
      #   Vedeu.trigger(:_editor_command_, name)
      #
      # @return [TrueClass]
      def editor_command!
        Vedeu.bind(:_editor_command_) do |name|
          Vedeu.documents.by_name(name).command
        end
      end

      # @example
      #   Vedeu.trigger(:_editor_delete_character_, name)
      #
      # @return [TrueClass]
      def editor_delete_character!
        Vedeu.bind(:_editor_delete_character_) do |name|
          Vedeu.documents.by_name(name).delete_character
        end
      end

      # @example
      #   Vedeu.trigger(:_editor_delete_line_, name)
      #
      # @return [TrueClass]
      def editor_delete_line!
        Vedeu.bind(:_editor_delete_line_) do |name|
          Vedeu.documents.by_name(name).delete_line
        end
      end

      # @example
      #   Vedeu.trigger(:_editor_down_, name)
      #
      # @return [TrueClass]
      def editor_down!
        Vedeu.bind(:_editor_down_) do |name|
          Vedeu.documents.by_name(name).down
        end
      end

      # @example
      #   Vedeu.trigger(:_editor_insert_character_, name, character)
      #
      # @return [TrueClass]
      def editor_insert_character!
        Vedeu.bind(:_editor_insert_character_) do |name, character|
          Vedeu.documents.by_name(name).insert_character(character)
        end
      end

      # @example
      #   Vedeu.trigger(:_editor_insert_line_, name)
      #
      # @return [TrueClass]
      def editor_insert_line!
        Vedeu.bind(:_editor_insert_line_) do |name|
          Vedeu.documents.by_name(name).insert_line
        end
      end

      # @example
      #   Vedeu.trigger(:_editor_left_, name)
      #
      # @return [TrueClass]
      def editor_left!
        Vedeu.bind(:_editor_left_) { |name| Vedeu.documents.by_name(name).left }
      end

      # @example
      #   Vedeu.trigger(:_editor_right_, name)
      #
      # @return [TrueClass]
      def editor_right!
        Vedeu.bind(:_editor_right_) do |name|
          Vedeu.documents.by_name(name).right
        end
      end

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
