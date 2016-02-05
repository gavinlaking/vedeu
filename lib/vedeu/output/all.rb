# frozen_string_literal: true

module Vedeu

  # Classes within the Output namespace handle various aspects of
  # rendering content.
  #
  module Output

  end # Output

end # Vedeu

require 'vedeu/output/compressors/simple'
require 'vedeu/output/compressors/character'

require 'vedeu/output/compressor_cache'
require 'vedeu/output/compressor'
require 'vedeu/output/output'
require 'vedeu/output/viewport'
require 'vedeu/output/refresh'
require 'vedeu/output/write'
