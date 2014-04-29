require_relative '../../../test_helper'

module Vedeu
  module Colours
    describe Colour do
      let(:klass)    { Colour }
      let(:instance) { klass.new }
      let(:mask)     { [] }

      it { instance.must_be_instance_of(Colours::Colour) }

      describe '.set' do
        subject { klass.set(mask) }

        it { subject.must_be_instance_of(String) }

        context 'when the foreground and background are specified as symbols' do
          context 'when both the foreground and background is specified' do
            let(:mask) { [:red, :yellow] }

            it 'returns the code for red on yellow' do
              subject.must_equal("\e[38;5;31m\e[48;5;43m")
            end
          end

          context 'when a foreground is specified' do
            let(:mask) { [:blue] }

            it 'returns the code for blue on default' do
              subject.must_equal("\e[38;5;34m\e[48;5;49m")
            end
          end

          context 'when a background is specified' do
            let(:mask) { [nil, :cyan] }

            it 'returns the code for default with cyan background' do
              subject.must_equal("\e[38;5;39m\e[48;5;46m")
            end
          end

          context 'when an invalid foreground/background is specified' do
            let(:mask) { [:melon, :raspberry] }

            it 'returns the default code' do
              subject.must_equal("\e[38;5;39m\e[48;5;49m")
            end
          end

          context 'when no foreground/background is specified' do
            let(:mask) { [] }

            it 'returns the reset code' do
              subject.must_equal("\e[0m")
            end
          end
        end

        context 'when the foreground and background are specified as strings' do
          let(:mask) { ['#ff0000', '#0000ff'] }

          it 'returns the default code' do
            subject.must_equal("\e[38;5;196m\e[48;5;21m")
          end
        end
      end

      describe '.reset' do
        subject { klass.reset }

        it { subject.must_be_instance_of(String) }

        it 'returns the reset code' do
          subject.must_equal("\e[0m")
        end
      end
    end
  end
end
