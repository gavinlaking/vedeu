# frozen_string_literal: true

module Vedeu

  # Classes within the Output namespace handle various aspects of
  # rendering content.
  #
  module Output

  end # Output

  # :nocov:

  # See {file:docs/events/refresh.md}
  Vedeu.bind(:_refresh_) { Vedeu::Output::Refresh.all if Vedeu.ready? }

  # :nocov:

end # Vedeu

require 'vedeu/output/compressors/all'
require 'vedeu/output/compressor_cache'
require 'vedeu/output/compressor'
require 'vedeu/output/output'
require 'vedeu/output/viewport'
require 'vedeu/output/refresh'
require 'vedeu/output/write'
