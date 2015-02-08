require 'vedeu/repositories/repository'
require 'vedeu/input/mapper'
require 'vedeu/input/keys'
require 'vedeu/input/key'
require 'vedeu/input/input'
require 'vedeu/input/keymap'

module Vedeu

  extend self

  def keymaps
    @_keymaps ||= Vedeu::Repository.new(Vedeu::Keymap)
  end

  def_delegators Vedeu::Keymap, :keymap
  def_delegators Vedeu::Keymap, :keypress

  Vedeu.keymap('_system_') do |keymap|
    Vedeu::Configuration.system_keys.each do |label, keypress|
      keymap.key(keypress) { Vedeu.trigger(("_" + label.to_s + "_").to_sym) }
    end
  end

  Vedeu.keymap('_global_') do

  end

end # Vedeu
