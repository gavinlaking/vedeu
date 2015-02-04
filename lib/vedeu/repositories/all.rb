require 'vedeu/repositories/repository'
require 'vedeu/repositories/menus'

module Vedeu

  Repositories = %w[
    Buffers
    Events
    Geometries
    Groups
    Interfaces
    Keymaps
  ]
  Repositories.each { |r| const_set(r, Class.new(Repository)) }

end # Vedeu
