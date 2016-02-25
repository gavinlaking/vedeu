# frozen_string_literal: true

module Vedeu

  # Classes within the Input namespace handle various aspects of
  # user input.
  #
  module Input

  end # Input

  # :nocov:

  # See {file:docs/events/system.md#\_keypress_}
  Vedeu.bind(:_keypress_) do |key, name|
    Vedeu.timer('Executing keypress') do
      Vedeu.add_keypress(key)

      Vedeu.keypress(key, name)
    end
  end

  # See {file:docs/events/drb.md#\_drb_input_}
  Vedeu.bind(:_drb_input_) do |data, type|
    Vedeu.log(type: :drb, message: "Sending input (#{type})")

    if type == :command
      Vedeu.trigger(:_command_, data)

    else
      Vedeu.trigger(:_keypress_, data)

    end
  end

  # See {file:docs/events/system.md#\_command_}
  Vedeu.bind(:_command_) do |command|
    Vedeu.timer('Executing command') do
      Vedeu.add_command(command)

      Vedeu.trigger(:command, command)
    end
  end

  # :nocov:

end # Vedeu

require 'vedeu/input/raw'
require 'vedeu/input/capture'
require 'vedeu/input/dsl'
require 'vedeu/input/keys'
require 'vedeu/input/key'
require 'vedeu/input/keymap'
require 'vedeu/input/mapper'
require 'vedeu/input/mouse'
require 'vedeu/input/read'
require 'vedeu/input/repository'
require 'vedeu/input/store'
require 'vedeu/input/translator'
