# frozen_string_literal: true

module Vedeu

  module Colours

    # Store foreground colour escape sequences by HTML/CSS code.
    #
    class Foregrounds < Vedeu::Colours::Repository

      # {include:file:docs/dsl/by_method/foreground_colours.md}
      # @return [Vedeu::Colours::Foregrounds]
      # @see Vedeu::Repositories::Repository
      def self.foreground_colours
        @foreground_colours ||= new
      end

    end # Foregrounds

  end # Colours

  # @api public
  # @!method foreground_colours
  # @return [Vedeu::Colours::Foregrounds]
  def_delegators Vedeu::Colours::Foregrounds,
                 :foreground_colours

end # Vedeu
