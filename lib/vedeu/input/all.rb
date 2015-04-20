require_relative 'mapper'
require_relative 'key'
require_relative 'input'
require_relative 'keymap'

module Vedeu

  # Define a keymap called '_system_' which will hold some vital keys needed by
  # Vedeu to run effectively.
  Vedeu::DSL::Keymap.keymap('_system_') do |keymap|
    Vedeu::Configuration.system_keys.each do |label, keypress|
      keymap.key(keypress) { Vedeu.trigger(("_#{label}_").to_sym) }
    end
  end

  # Define a keymap called '_global_' which will respond no matter which
  # interface is in focus.
  #
  # @note
  #   Initially, no keys are registered with the global keymap.
  Vedeu::DSL::Keymap.keymap('_global_') do
    # ...
  end

end # Vedeu
