require 'vedeu/buffers/buffer'
require 'vedeu/buffers/display_buffer'

module Vedeu

  # @return [Vedeu::Repository]
  def self.buffers
    @_buffers ||= Vedeu::Repository.new(Vedeu::Buffer)
  end

end # Vedeu
