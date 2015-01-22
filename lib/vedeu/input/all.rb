require 'vedeu/support/repository'
require 'vedeu/input/mapper'
require 'vedeu/input/key'
require 'vedeu/input/input'
require 'vedeu/input/keymap'

module Vedeu

  extend self

  def keymaps
    @_keymaps ||= Vedeu::Keymaps.new(Vedeu::Keymap)
  end

  def_delegators Vedeu::Keymap, :keymap

end # Vedeu

Vedeu.keymap('_system_') do |keymap|
  Vedeu::Configuration.system_keys.each do |label, keypress|
    keymap.key(keypress) do
      Vedeu.trigger(("_" + label.to_s + "_").to_sym)
    end
    #nil

  end
  #nil

end

Vedeu.keymap('_global_') do

end
