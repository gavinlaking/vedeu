require_relative '../../../test_helper'

module Vedeu
  describe CommandRepository do
    let(:described_class) { CommandRepository }
    let(:input)           { }

    before do
      Command.create({ name:    'apple',
                       klass:   DummyCommand,
                       options: { keypress: 'a', keyword: 'apple' } })
      Command.create({ name:    'banana',
                       klass:   DummyCommand,
                       options: { keypress: 'b', keyword: 'banana' } })
    end

    after do
      CommandRepository.reset
    end

    describe '.find_by_input' do
      let(:subject) { described_class.find_by_input(input) }

      context 'when the command was found by keypress' do
        let(:input) { 'b' }

        it { subject.must_be_instance_of(Command) }

        it { subject.name.must_equal('banana') }

        it { subject.name.wont_equal('apple') }

        it { subject.keypress.must_equal('b') }
      end

      context 'when the command was found by keyword' do
        let(:input) { 'apple' }

        it { subject.must_be_instance_of(Command) }

        it { subject.keypress.must_equal('a') }

        it { subject.keypress.wont_equal('b') }

        it { subject.name.wont_equal('banana') }
      end
    end

    describe '.klass' do
      let(:subject) { described_class.klass }

      it { subject.must_equal(Command) }
    end
  end
end
