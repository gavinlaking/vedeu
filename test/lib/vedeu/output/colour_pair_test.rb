require_relative '../../../test_helper'

module Vedeu
  describe Colour do
    let(:described_class)    { Colour }
    let(:described_instance) { described_class.new }
    let(:subject)            { described_instance }
    let(:pair)               { [] }

    it 'returns a Colour instance' do
      subject.must_be_instance_of(Colour)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get('@pair').must_equal([])
    end

    describe '.set' do
      let(:subject) { described_class.set(pair) }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      context 'when the foreground and background are specified as symbols' do
        context 'when both the foreground and background is specified' do
          let(:pair) { [:red, :yellow] }

          it 'returns the code for red on yellow' do
            subject.must_equal("\e[38;2;31m\e[48;2;43m")
          end
        end

        context 'when a foreground is specified' do
          let(:pair) { [:blue] }

          it 'returns the code for blue on default' do
            subject.must_equal("\e[38;2;34m\e[48;2;49m")
          end
        end

        context 'when a background is specified' do
          let(:pair) { [nil, :cyan] }

          it 'returns the code for default with cyan background' do
            subject.must_equal("\e[38;2;39m\e[48;2;46m")
          end
        end

        context 'when an invalid foreground/background is specified' do
          let(:pair) { [:melon, :raspberry] }

          it 'returns the default code' do
            subject.must_equal("\e[38;2;39m\e[48;2;49m")
          end
        end

        context 'when no foreground/background is specified' do
          let(:pair) { [] }

          it 'return an empty string' do
            subject.must_equal('')
          end
        end
      end

      context 'when the foreground and background are specified as strings' do
        let(:pair) { ['#ff0000', '#0000ff'] }

        it 'returns the default code' do
          subject.must_equal("\e[38;5;196m\e[48;5;21m")
        end
      end
    end

    describe '.reset' do
      let(:subject) { described_class.reset }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      it 'returns an escape sequence' do
        subject.must_equal("\e[38;2;39m\e[48;2;49m")
      end
    end

    describe '#foreground' do
      let(:subject) { described_instance.foreground }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end
    end

    describe '#background' do
      let(:subject) { described_instance.background }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end
    end
  end
end
