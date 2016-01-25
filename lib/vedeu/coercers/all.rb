# frozen_string_literal: true

module Vedeu

  # Provides a mechanism to coerce values within Vedeu in to expected
  # objects.
  #
  # @api private
  #
  module Coercers

  end # Coercers

end # Vedeu

require 'vedeu/coercers/alignment'
require 'vedeu/coercers/horizontal_alignment'
require 'vedeu/coercers/vertical_alignment'

require 'vedeu/coercers/colour'
require 'vedeu/coercers/colour_attributes'
