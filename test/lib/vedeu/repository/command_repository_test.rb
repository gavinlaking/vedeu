require_relative '../../../test_helper'

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

    describe '.by_keypress' do
      let(:subject) { described_class.by_keypress(input) }

      context 'when the command was found by keypress' do
        let(:input) { 'b' }

        it 'returns the Command instance' do
          subject.must_be_instance_of(Command)
        end

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
    end

    describe '.by_keyword' do
      let(:subject) { described_class.by_keyword(input) }

      context 'when the command was found by keyword' do
        let(:input) { 'apple' }

        it 'returns the Command instance' do
          subject.must_be_instance_of(Command)
        end

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

    describe '.entity' do
      let(:subject) { described_class.entity }

      it 'returns Command' do
        subject.must_equal(Command)
      end
    end
  end
end
