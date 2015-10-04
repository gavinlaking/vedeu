module Vedeu

  module Output

    # @see Vedeu::Bindings::System#refresh!
    class Refresh

      # @see #all
      def self.all
        new.all
      end

      # Return a new instance of Vedeu::Output::Refresh.
      #
      # @return [Vedeu::Output::Refresh]
      def initialize; end

      # Refresh all registered interfaces.
      #
      # @return [Array<Vedeu::Models::Interface>]
      def all
        Vedeu.timer('Refreshing all'.freeze) do
          Vedeu.interfaces.zindexed.each do |interface|
            Vedeu.trigger(:_refresh_view_, interface.name)
          end
        end
      end

    end # Refresh

  end # Output

end # Vedeu
