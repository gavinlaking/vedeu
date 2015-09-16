module Vedeu

  # @see Vedeu::Bindings::System#refresh!
  class Refresh

    # Refresh all registered interfaces.
    #
    # @return [Array<Vedeu::Models::Interface>]
    def self.all
      new.all
    end

    # Return a new instance of Vedeu::Refresh.
    #
    # @return [Vedeu::Refresh]
    def initialize; end

    # Refresh all registered interfaces.
    #
    # @return [Array<Vedeu::Models::Interface>]
    def all
      Vedeu.timer('Refreshing all') do
        Vedeu.interfaces.zindexed.each do |interface|
          Vedeu.trigger(:_refresh_, interface.name)
        end
      end
    end

  end # Refresh

end # Vedeu
