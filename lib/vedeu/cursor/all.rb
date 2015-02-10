require 'vedeu/repositories/repository'
require 'vedeu/cursor/cursor'
require 'vedeu/cursor/move_cursor'
require 'vedeu/cursor/toggle_cursor'

module Vedeu

  extend self

  # @return [Vedeu::Repository]
  def cursors
    @_cursors ||= Vedeu::Repository.new(Vedeu::Cursor)
  end

  # @return [Vedeu::Cursor|NilClass]
  def cursor
    cursors.current
  end

end # Vedeu
