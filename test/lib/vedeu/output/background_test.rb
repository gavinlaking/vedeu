require_relative '../../../test_helper'

module Vedeu
  describe Background do
    let(:described_class)    { Background }
    let(:described_instance) { described_class.new(colour) }
    let(:colour)             {}

    it 'returns a Background instance' do
      described_instance.must_be_instance_of(Background)
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
          subject.must_equal("\e[48;5;49m")
        end
      end

      context 'with a named colour' do
        let(:colour) { :red }

        it 'returns a String' do
          subject.must_be_instance_of(String)
        end

        it 'returns an escape sequence' do
          subject.must_equal("\e[48;5;41m")
        end
      end

      context 'with a html colour' do
        let(:colour) { '#aadd00' }

        it 'returns a String' do
          subject.must_be_instance_of(String)
        end

        it 'returns an escape sequence' do
          subject.must_equal("\e[48;5;148m")
        end
      end

      context 'with a default colour' do
        let(:colour) { :undefined }

        it 'returns a String' do
          subject.must_be_instance_of(String)
        end

        it 'returns an escape sequence' do
          subject.must_equal("\e[48;5;49m")
        end
      end
    end
  end
end
