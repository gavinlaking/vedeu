# frozen_string_literal: true

module Vedeu

  module Editor

    # Allows the storing of documents.
    #
    class Repository < Vedeu::Repositories::Repository

      singleton_class.send(:alias_method, :documents, :repository)

      real Vedeu::Editor::Document
      null Vedeu::Editor::Document

    end # Repository

  end # Editor

  # Manipulate the repository of documents.
  #
  # @example
  #   Vedeu.documents
  #
  # @!method documents
  # @return [Vedeu::Editor::Repository]
  def_delegators Vedeu::Editor::Repository,
                 :documents

  # :nocov:

  # See {file:docs/events/document.md#\_editor_execute_}
  Vedeu.bind(:_editor_execute_) do |name|
    Vedeu.documents.by_name(name).execute
  end

  # See {file:docs/events/document.md#\_editor_delete_character_}
  Vedeu.bind(:_editor_delete_character_) do |name|
    Vedeu.documents.by_name(name).delete_character
  end

  # See {file:docs/events/document.md#\_editor_delete_line_}
  Vedeu.bind(:_editor_delete_line_) do |name|
    Vedeu.documents.by_name(name).delete_line
  end

  # See {file:docs/events/document.md#\_editor_down_}
  Vedeu.bind(:_editor_down_) do |name|
    Vedeu.documents.by_name(name).down
  end

  # See {file:docs/events/document.md#\_editor_insert_character_}
  Vedeu.bind(:_editor_insert_character_) do |name, character|
    Vedeu.documents.by_name(name).insert_character(character)
  end

  # See {file:docs/events/document.md#\_editor_insert_line_}
  Vedeu.bind(:_editor_insert_line_) do |name|
    Vedeu.documents.by_name(name).insert_line
  end

  # See {file:docs/events/document.md#\_editor_left_}
  Vedeu.bind(:_editor_left_) { |name| Vedeu.documents.by_name(name).left }

  # See {file:docs/events/document.md#\_editor_right_}
  Vedeu.bind(:_editor_right_) do |name|
    Vedeu.documents.by_name(name).right
  end

  # See {file:docs/events/document.md#\_editor_up_}
  Vedeu.bind(:_editor_up_) { |name| Vedeu.documents.by_name(name).up }

  # :nocov:

end # Vedeu
