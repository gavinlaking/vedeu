# frozen_string_literal: true

module Vedeu

  module Groups

    # Clear the interfaces belonging to the named group.
    #
    class Clear

      class << self

        # {include:file:docs/dsl/by_method/clear_by_group.md}
        # @param name [String|Symbol]
        # @return [void]
        def render(name)
          new(name).render
        end
        alias clear_by_group render
        alias by_group render

      end # Eigenclass

      # Return a new instance of Vedeu::Groups::Clear.
      #
      # @param name [String|Symbol]
      # @return [Vedeu::Groups::Clear]
      def initialize(name)
        @name = name
      end

      # @return [void]
      def render
        members.each { |name| Vedeu.trigger(:_clear_view_, name) }
      end

      protected

      # @!attribute [r] name
      # @return [String|Symbol]
      attr_reader :name

      private

      # @return [Vedeu::Groups::Group]
      def group
        Vedeu.groups.by_name(name)
      end

      # @return [Array<String>]
      def members
        group.members
      end

    end # Clear

  end # Groups

  # @api public
  # @!method clear_by_group
  #   @see Vedeu::Groups::Clear.render
  def_delegators Vedeu::Groups::Clear,
                 :clear_by_group

  # :nocov:

  # See {file:docs/events/visibility.md#\_clear_group_}
  Vedeu.bind(:_clear_group_) do |name|
    Vedeu.clear_by_group(name) if Vedeu.ready?
  end

  # :nocov:

end # Vedeu
