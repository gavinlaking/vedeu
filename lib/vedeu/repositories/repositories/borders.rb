module Vedeu

  # Allows the storing of interface/view borders independent of the interface
  # instance.
  #
  class Borders < Repository

    class << self

      # @return [Vedeu::Borders]
      def borders
        @borders ||= reset!
      end
      alias_method :repository, :borders

      # Remove all stored models from the repository.
      #
      # @return [Vedeu::Borders]
      def reset!
        @borders = Vedeu::Borders.register_repository(Vedeu::Border)
      end

    end

    # @param name [String] The name of the stored border.
    # @return [Vedeu::Border|Vedeu::Null::Border]
    def by_name(name)
      if registered?(name)
        find(name)

      else
        Vedeu::Null::Border.new(name)

      end
    end

  end # Borders

end # Vedeu
