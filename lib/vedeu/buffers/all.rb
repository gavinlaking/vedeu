require 'vedeu/buffers/buffer'
require 'vedeu/buffers/display_buffer'

module Vedeu

  def self.buffers
    @_buffers ||= Vedeu::Buffers.new(Vedeu::Buffer)
  end

end # Vedeu
