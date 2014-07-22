require_relative '../../../../test_helper'
require_relative '../../../../../lib/vedeu/models/builders/command_builder'
require_relative '../../../../support/dummy_command'

module Vedeu
  describe CommandBuilder do
    it 'creates and stores a new command' do
      command = CommandBuilder.build('dummy') do
        entity   DummyCommand
        keyword  'dummy'
        keypress 'd'
      end
      command.must_be_instance_of(Command)
    end
  end
end
