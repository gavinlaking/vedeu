module Vedeu

  # Each available character space in the visible terminal is
  # represented in Vedeu as a cell of some type. Each type of cell
  # has specific behaviour when handled (including being rendered) by
  # Vedeu.
  #
  # @api private
  #
  module Cells

  end # Cells

end # Vedeu

require 'vedeu/models/cells/empty'
require 'vedeu/models/cells/border'
require 'vedeu/models/cells/char'
require 'vedeu/models/cells/clear'
require 'vedeu/models/cells/escape'
require 'vedeu/models/cells/html'
require 'vedeu/models/cells/json'
