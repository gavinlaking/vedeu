require 'vedeu/cursor/cursor'
require 'vedeu/cursor/move_cursor'
require 'vedeu/cursor/toggle_cursor'

module Vedeu

  def self.cursor
    cursors.current
  end

  def self.cursors
    @_cursors ||= Vedeu::Cursors.new(Vedeu::Cursor)
  end

end # Vedeu
