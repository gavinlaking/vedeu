# frozen_string_literal: true

module Vedeu

  module Output

    # Provides different mechanisms to compress content. Compressing
    # content is performed to:
    #
    # 1) Reduce the amount of data sent to the renderer with each
    #    refresh or render.
    # 2) Reduce the time spent converting a terminal buffer into data
    #    suitable to send to the renderer.
    #
    # @api private
    #
    module Compressors

    end # Compressors

  end # Output

end # Vedeu

require 'vedeu/output/compressors/simple'
require 'vedeu/output/compressors/empty'
require 'vedeu/output/compressors/character'
