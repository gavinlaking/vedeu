module Vedeu

  # This module is the direct interface between Vedeu and your
  # terminal/ console, via Ruby's IO core library.
  #
  module Terminal

  end # Terminal

end # Vedeu

require 'vedeu/terminal/mode'
require 'vedeu/terminal/terminal'
require 'vedeu/terminal/buffer'
