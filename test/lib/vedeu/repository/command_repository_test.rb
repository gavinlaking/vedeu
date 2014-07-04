require_relative '../../../test_helper'
require_relative '../../../support/dummy_command'
require_relative '../../../../lib/vedeu/repository/command_repository'

module Vedeu
  describe CommandRepository do
    let(:described_class) { CommandRepository }
    let(:input)           {}

    before do
      CommandRepository.create({
        name:     'apple',
        entity:   DummyCommand,
        keypress: 'a',
        keyword:  'apple'
      })
      CommandRepository.create({
        name:     'banana',
        entity:   DummyCommand,
        keypress: 'b',
        keyword:  'banana'
      })
    end

    after { CommandRepository.reset }

    describe '.by_input' do
      let(:subject) { described_class.by_input(input) }
      let(:input)   { 'b' }

      it 'returns the Command instance' do
        subject.must_be_instance_of(Command)
      end

      context 'when the command was found by keypress' do
        it 'returns the correct command' do
          subject.name.must_equal('banana')
        end

        it 'returns the correct command' do
          subject.name.wont_equal('apple')
        end

        it 'returns the correct command' do
          subject.keypress.must_equal('b')
        end
      end

      context 'when the command was found by keyword' do
        let(:input) { 'apple' }

        it 'returns the correct command' do
          subject.keypress.must_equal('a')
        end

        it 'returns the correct command' do
          subject.keypress.wont_equal('b')
        end

        it 'returns the correct command' do
          subject.name.wont_equal('banana')
        end
      end
    end

    describe '.create' do
      let(:subject)    { described_class.create(attributes) }
      let(:attributes) { {} }

      it 'returns a Command' do
        subject.must_be_instance_of(Command)
      end
    end

    describe '.entity' do
      let(:subject) { described_class.entity }

      it 'returns a Class instance' do
        subject.must_be_instance_of(Class)
      end

      it 'returns Command' do
        subject.must_equal(Command)
      end
    end
  end
end
