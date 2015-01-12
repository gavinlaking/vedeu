require 'vedeu/support/repository'

module Vedeu

  # class BufferRepository# < Repository

  #   def store(model)

  #   end

  #   def update(name)
  #     return find(name).update! if Vedeu.buffers_repository.registered?(name)
  #   end

  #   private



  # end

  module DisplayBuffer

    # def store_immediate
    #   store_geometry

    #   store_deferred

    #   Vedeu::Refresh.by_name(name)

    #   self
    # end

    # def store_deferred
    #   store_geometry

    #   if Vedeu.buffers_repository.registered?(name)
    #     # Vedeu.buffers_repository.update(name)

    #     BufferModel.new(self).store # store on back buffer

    #   else
    #     BufferModel.new(self).store # store on back buffer

    #   end

    #   self
    # end

    # private

    # # @todo Consider that storing the geometry for a deferred view would overwrite
    # # the geometry for all buffers; leading to undesirable effects. Perhaps a buffer
    # # should store the geometry?
    # def store_geometry
    #   if geometry
    #     if Vedeu.geometries_repository.registered?(name)
    #       # update geometry
    #     else
    #       # store geometry
    #     end
    #   else
    #     geometry.name = name
    #     geometry.store
    #   end
    # end

  end # DisplayBuffer

end # Vedeu
