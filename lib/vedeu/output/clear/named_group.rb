module Vedeu

  # Provides the mechanisms to clear an interface or group of
  # interfaces.
  #
  module Clear

    # Clear the interfaces belonging to the named group.
    #
    class NamedGroup

      class << self

        # Clears the group of interfaces belonging to the given name.
        #
        # @example
        #   Vedeu.clear_by_group(name)
        #
        # @param name [String]
        # @return [void]
        def render(name)
          new(name).render
        end
        alias_method :clear_by_group, :render
        alias_method :by_group, :render

      end # Eigenclass

      # Return a new instance of Vedeu::Clear::NamedGroup.
      #
      # @param name [String]
      # @return [Vedeu::Clear::NamedGroup]
      def initialize(name)
        @name = name
      end

      # @return [void]
      def render
        members.each { |name| Vedeu::Clear::NamedInterface.render(name) }
      end

      protected

      # @!attribute [r] name
      # @return [String]
      attr_reader :name

      private

      # @return [Array<String>]
      def members
        Vedeu.groups.by_name(name).members
      end

    end # Group

  end # Clear

end # Vedeu
