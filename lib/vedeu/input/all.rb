require_relative 'mapper'
require_relative 'key'
require_relative 'input'
require_relative 'keymap'

module Vedeu

  # Define a keymap called '_global_' which will respond no matter which
  # interface is in focus.
  #
  # @note
  #   Initially, no keys are registered with the global keymap.
  Vedeu::DSL::Keymap.keymap('_global_') do
    # ...
  end

end # Vedeu
