require_relative '../../../test_helper'
require_relative '../../../support/dummy_command'
require_relative '../../../../lib/vedeu/models/command'

module Vedeu
  describe Command do
    it 'has a name attribute' do
      Command.new({ name: 'dummy' }).name.must_equal('dummy')
    end

    it 'has an entity attribute' do
      Command.new({ entity: DummyCommand }).entity
        .must_equal(DummyCommand)
    end

    it 'has a keypress attribute' do
      Command.new({ keypress: 'd' }).keypress.must_equal('d')
    end

    it 'has an keyword attribute' do
      Command.new({ keyword: 'dummy' }).keyword.must_equal('dummy')
    end

    it 'has an arguments attribute' do
      Command.new({ arguments: [] }).arguments.must_equal([])
    end

    describe '#execute' do
      it 'returns the result of execution' do
        Command.new({
          name:      'dummy',
          entity:    DummyCommand,
          keyword:   'dummy',
          keypress:  'd',
          arguments: []
        }).execute(:dummy).must_equal(:dummy)
      end
    end
  end
end
