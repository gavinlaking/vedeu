module Vedeu

  # Refreshes the given named group of interfaces.
  #
  class RefreshGroup

    include Vedeu::Common

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
      unless present?(name)
        fail Vedeu::MissingRequired,
             'Cannot refresh group with an empty group name.'
      end

      Vedeu.groups.by_name(name).by_zindex.each do |name|
        Vedeu::Refresh.by_name(name)
      end
    end

    protected

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

  end # RefreshGroup

end # Vedeu
