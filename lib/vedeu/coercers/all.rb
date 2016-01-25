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

require 'vedeu/coercers/coercer'

require 'vedeu/coercers/alignment'
require 'vedeu/coercers/horizontal_alignment'
require 'vedeu/coercers/vertical_alignment'

require 'vedeu/coercers/chars'

require 'vedeu/coercers/colour'
require 'vedeu/coercers/colour_attributes'

require 'vedeu/coercers/editor_line'
require 'vedeu/coercers/editor_lines'
require 'vedeu/coercers/lines'
require 'vedeu/coercers/page'
require 'vedeu/coercers/position'
require 'vedeu/coercers/row'
require 'vedeu/coercers/streams'
