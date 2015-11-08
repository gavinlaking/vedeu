module Vedeu

  # Vedeu creates an individual cursor for each interface defined,
  # these take their name from the interface, which means that your
  # position within the view for each interface is maintained.
  #
  # The cursor also manages the content offset for a particular view.
  # For example, if the user has moved around within the content and
  # then moved to another interface, when they return their position
  # will be restored.
  #
  module Cursors

  end # Cursors

end # Vedeu

require 'vedeu/cursors/cursor'
require 'vedeu/cursors/dsl'
require 'vedeu/cursors/refresh'
require 'vedeu/cursors/reposition'
require 'vedeu/cursors/repository'
