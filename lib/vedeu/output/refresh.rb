# frozen_string_literal: true

module Vedeu

  module Output

    # @see Vedeu::Bindings::System#refresh!
    #
    # @api private
    #
    class Refresh

      # @return (see #all)
      def self.all
        new.all
      end

      # Return a new instance of Vedeu::Output::Refresh.
      #
      # @return [Vedeu::Output::Refresh]
      def initialize; end

      # Refresh all registered interfaces.
      #
      # @return [Array<String|Symbol>]
      def all
        Vedeu.timer('Refreshing all') do
          Vedeu.interfaces.zindexed.each do |name|
            Vedeu.trigger(:_refresh_view_, name)
          end
        end
      end

    end # Refresh

  end # Output

end # Vedeu
