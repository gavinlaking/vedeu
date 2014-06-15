require_relative '../../../test_helper'

module Vedeu
  describe Foreground do
    let(:described_class)    { Foreground }
    let(:described_instance) { described_class.new(colour) }
    let(:colour)             {}

    it 'returns a Foreground instance' do
      described_instance.must_be_instance_of(Foreground)
    end

    describe '#escape_sequence' do
      let(:subject) { described_instance.escape_sequence }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      context 'with no colour' do
        it 'returns a String' do
          subject.must_be_instance_of(String)
        end

        it 'returns an escape sequence' do
          subject.must_equal("\e[38;5;39m")
        end
      end

      context 'with a named colour' do
        let(:colour) { :red }

        it 'returns a String' do
          subject.must_be_instance_of(String)
        end

        it 'returns an escape sequence' do
          subject.must_equal("\e[38;5;31m")
        end
      end

      context 'with a html colour' do
        let(:colour) { '#aadd00' }

        it 'returns a String' do
          subject.must_be_instance_of(String)
        end

        it 'returns an escape sequence' do
          subject.must_equal("\e[38;5;148m")
        end
      end

      context 'with a default colour' do
        let(:colour) { :undefined }

        it 'returns a String' do
          subject.must_be_instance_of(String)
        end

        it 'returns an escape sequence' do
          subject.must_equal("\e[38;5;39m")
        end
      end
    end
  end
end
