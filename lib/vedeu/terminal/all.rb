# frozen_string_literal: true

module Vedeu

  # This module is the direct interface between Vedeu and your
  # terminal/ console, via Ruby's IO core library.
  #
  module Terminal

  end # Terminal

  # :nocov:

  # See {file:docs/events/view.md#\_resize_}
  Vedeu.bind(:_resize_, delay: 0.25) { Vedeu.resize }

  # :nocov:

end # Vedeu

require 'vedeu/terminal/mode'
require 'vedeu/terminal/terminal'
