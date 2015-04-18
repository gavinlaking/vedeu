module Vedeu

  # Allows the storing of interface/view geometry independent of the interface
  # instance.
  #
  class Geometries < Repository

    class << self

      # @return [Vedeu::Geometries]
      def geometries
        @geometries ||= reset!
      end
      alias_method :repository, :geometries

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::Geometries]
      def reset!
        @geometries = Vedeu::Geometries.register_repository(Vedeu::Geometry)
      end

    end

    # @param name [String] The name of the stored geometry.
    # @return [Vedeu::Geometry|Vedeu::Null::Geometry]
    def by_name(name)
      if registered?(name)
        find(name)

      else
        Vedeu::Null::Geometry.new(name)

      end
    end

  end # Geometries

end # Vedeu
