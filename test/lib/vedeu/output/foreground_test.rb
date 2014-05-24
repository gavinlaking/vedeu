require_relative '../../../test_helper'

module Vedeu
  describe Foreground do
    let(:described_class)    { Foreground }
    let(:described_instance) { described_class.new(colour) }
    let(:colour)             {}

    it { described_instance.must_be_instance_of(Foreground) }

    describe '#escape_sequence' do
      subject { described_instance.escape_sequence }

      it { subject.must_be_instance_of(String) }

      context 'with no colour' do
        it { subject.must_be_instance_of(String) }

        it { subject.must_equal("\e[38;5;39m") }
      end

      context 'with a named colour' do
        let(:colour) { :red }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal("\e[38;5;31m") }
      end

      context 'with a html colour' do
        let(:colour) { '#aadd00' }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal("\e[38;5;148m") }
      end

      context 'with a default colour' do
        let(:colour) { :undefined }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal("\e[38;5;39m") }
      end
    end
  end
end
