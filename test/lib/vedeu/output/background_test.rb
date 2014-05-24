require_relative '../../../test_helper'

module Vedeu
  describe Background do
    let(:described_class)    { Background }
    let(:described_instance) { described_class.new(colour) }
    let(:colour)             {}

    it { described_instance.must_be_instance_of(Background) }

    describe '#escape_sequence' do
      subject { described_instance.escape_sequence }

      it { subject.must_be_instance_of(String) }

      context 'with no colour' do
        it { subject.must_be_instance_of(String) }

        it { subject.must_equal("\e[48;5;49m") }
      end

      context 'with a named colour' do
        let(:colour) { :red }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal("\e[48;5;41m") }
      end

      context 'with a html colour' do
        let(:colour) { '#aadd00' }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal("\e[48;5;148m") }
      end

      context 'with a default colour' do
        let(:colour) { :undefined }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal("\e[48;5;49m") }
      end
    end
  end
end
