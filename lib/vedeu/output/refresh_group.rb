require_relative 'refresh'

module Vedeu

  # Refreshes the given named group of interfaces.
  #
  # @api private
  class RefreshGroup

    # @param name [String]
    # @return [void]
    def self.by_name(name)
      new(name).by_name
    end

    # @param name [String]
    # @return [Vedeu::RefreshGroup]
    def initialize(name)
      @name = name
    end

    # @return [void]
    def by_name
      zindexed.each { |name| Vedeu::Refresh.by_name(name) }
    end

    protected

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    private

    # @return [Array<String>]
    def zindexed
      interfaces.sort { |a, b| a.zindex <=> b.zindex }.map(&:name)
    end

    # @return [Array<Vedeu::Interface>]
    def interfaces
      members.map { |name| Vedeu.interfaces.by_name(name) }
    end

    # @return [Set]
    def members
      Vedeu.groups.find!(name).members
    end

  end # RefreshGroup

end # Vedeu
