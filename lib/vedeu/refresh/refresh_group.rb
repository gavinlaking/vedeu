module Vedeu

  # Refresh an interface, or collection of interfaces belonging to a group.
  #
  # The interfaces will be refreshed in z-index order, meaning that interfaces
  # with a lower z-index will be drawn first. This means overlapping interfaces
  # will be drawn as specified.
  #
  # @example
  #   Vedeu.trigger(:_refresh_group_, group_name)
  #
  class RefreshGroup

    include Vedeu::Common

    # @param name [String] The name of the group to be refreshed.
    # @return [Array|Vedeu::Error::ModelNotFound] A collection of the names of
    #   interfaces refreshed, or an exception when the group was not found.
    def self.by_name(name)
      new(name).by_name
    end

    # Return a new instance of Vedeu::RefreshGroup.
    #
    # @param name [String]
    # @return [Vedeu::RefreshGroup]
    def initialize(name)
      @name = name
    end

    # @return [void]
    def by_name
      Vedeu.timer("Refresh Group: '#{group_name}'") do
        Vedeu.groups.by_name(group_name).by_zindex.each do |name|
          Vedeu::RefreshBuffer.by_name(name)
        end
      end
    end

    protected

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    private

    # @raise [Vedeu::Error::MissingRequired] When the name is empty or nil.
    # @return [String]
    def group_name
      return name if present?(name)

      fail Vedeu::Error::MissingRequired,
           'Cannot refresh group with an empty group name.'
    end

  end # RefreshGroup

end # Vedeu
