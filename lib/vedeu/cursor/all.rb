require 'vedeu/repositories/repository'
require 'vedeu/cursor/cursor'
require 'vedeu/cursor/move_cursor'
require 'vedeu/cursor/toggle_cursor'

module Vedeu

  class Cursors < Repository
  end

  extend self

  # @return [Cursors]
  def cursors
    @_cursors ||= Vedeu::Cursors.new(Vedeu::Cursor)
  end

  # @return [Cursor|NilClass]
  def cursor
    cursors.current
  end

end # Vedeu
