module Vedeu

  # The Buffer object represents the states of display for an
  # interface. The states are 'front', 'back' and 'previous'.
  #
  # [Back] -> [Front] -> [Previous]
  #
  # The content on the screen, or last output will always be the
  # 'Front' buffer. Content due to be displayed on next refresh will
  # come from the 'Back' buffer when available, otherwise from the
  # current 'Front' buffer. When new content is copied to the 'Front'
  # buffer, the current 'Front' buffer is also copied to the
  # 'Previous' buffer.
  #
  module Buffers

  end # Buffers

end # Vedeu

require 'vedeu/buffers/empty'
require 'vedeu/buffers/view'
require 'vedeu/buffers/buffer'
require 'vedeu/buffers/null'
require 'vedeu/buffers/repository'
require 'vedeu/buffers/refresh'
require 'vedeu/buffers/terminal'
