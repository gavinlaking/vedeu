require 'vedeu/dsl/dsl'
require 'vedeu/models/model'

module Vedeu

  # A Keymap is the binding of a keypress to one or more interfaces; or globally
  # to perform a client application defined action.
  #
  # @api private
  class Keymap

    extend Vedeu::DSL
    include Vedeu::Model

    attr_accessor :interfaces, :keys

    # Instantiate a new instance of the Keymap model.
    #
    # @param attributes [Hash]
    # @return [Keymap]
    def initialize(interfaces = [], keys = [])
      @interfaces = interfaces || []
      @keys       = keys       || []
    end

    # Returns the class responsible for defining the DSL methods of this model.
    #
    # @return [DSL::Keymap]
    def deputy
      Vedeu::DSL::Keymap.new(self)
    end

    private

    # @return [Class] The repository class for this model.
    def repository
      Vedeu::Keymaps
    end

  end # Keymap

end # Vedeu
