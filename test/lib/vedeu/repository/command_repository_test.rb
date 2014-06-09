require_relative '../../../test_helper'

module Vedeu
  describe CommandRepository do
    let(:described_class) { CommandRepository }
    let(:input)           { }

    describe '.find_by_input' do
      let(:subject) { described_class.find_by_input(input) }

      context 'when the command was found by key press' do
        it { skip }
      end

      context 'when the command was found by keyword' do
        it { skip }
      end
    end

    describe '.klass' do
      let(:subject) { described_class.klass }

      it { subject.must_equal(Command) }
    end
  end
end
