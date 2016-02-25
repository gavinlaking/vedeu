# frozen_string_literal: true

module Vedeu

  # Provide a mechanism to edit individual lines of the view.
  #
  module Editor

  end # Editor

  # :nocov:

  # See {file:docs/events/system.md#\_editor_}
  Vedeu.bind(:_editor_) do |key|
    Vedeu.timer('Executing editor keypress') do
      Vedeu.trigger(:key, key)

      Vedeu::Editor::Editor.keypress(name: Vedeu.focus, input: key)
    end
  end

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

require 'vedeu/editor/collection'
require 'vedeu/editor/cropper'
require 'vedeu/editor/delete'
require 'vedeu/editor/editor'
require 'vedeu/editor/insert'
require 'vedeu/editor/item'
require 'vedeu/editor/line'
require 'vedeu/editor/lines'
require 'vedeu/editor/cursor'
require 'vedeu/editor/document'
require 'vedeu/editor/repository'
