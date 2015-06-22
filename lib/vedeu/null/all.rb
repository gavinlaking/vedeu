module Vedeu

  # A group of objects that serve to intercept messages destined for their
  # real counterpart. In most cases the call is muted or returns a generic
  # value that does not halt processing.
  #
  # @api private
  module Null

  end

end

require_relative 'border'
require_relative 'buffer'
require_relative 'generic'
require_relative 'geometry'
require_relative 'interface'
