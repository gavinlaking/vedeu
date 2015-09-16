module Vedeu

  module Bindings

    # System events relating to the document/editor/fake terminal
    # implementation.
    #
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

      # See {file:docs/events/document.md#\_editor_execute_}
      def editor_execute!
        Vedeu.bind(:_editor_execute_) do |name|
          Vedeu.documents.by_name(name).execute
        end
      end

      # See {file:docs/events/document.md#\_editor_delete_character_}
      def editor_delete_character!
        Vedeu.bind(:_editor_delete_character_) do |name|
          Vedeu.documents.by_name(name).delete_character
        end
      end

      # See {file:docs/events/document.md#\_editor_delete_line_}
      def editor_delete_line!
        Vedeu.bind(:_editor_delete_line_) do |name|
          Vedeu.documents.by_name(name).delete_line
        end
      end

      # See {file:docs/events/document.md#\_editor_down_}
      def editor_down!
        Vedeu.bind(:_editor_down_) do |name|
          Vedeu.documents.by_name(name).down
        end
      end

      # See {file:docs/events/document.md#\_editor_insert_character_}
      def editor_insert_character!
        Vedeu.bind(:_editor_insert_character_) do |name, character|
          Vedeu.documents.by_name(name).insert_character(character)
        end
      end

      # See {file:docs/events/document.md#\_editor_insert_line_}
      def editor_insert_line!
        Vedeu.bind(:_editor_insert_line_) do |name|
          Vedeu.documents.by_name(name).insert_line
        end
      end

      # See {file:docs/events/document.md#\_editor_left_}
      def editor_left!
        Vedeu.bind(:_editor_left_) { |name| Vedeu.documents.by_name(name).left }
      end

      # See {file:docs/events/document.md#\_editor_right_}
      def editor_right!
        Vedeu.bind(:_editor_right_) do |name|
          Vedeu.documents.by_name(name).right
        end
      end

      # See {file:docs/events/document.md#\_editor_up_}
      def editor_up!
        Vedeu.bind(:_editor_up_) { |name| Vedeu.documents.by_name(name).up }
      end

    end # Document

  end # Bindings

end # Vedeu
