require 'test_helper'

module Vedeu

  describe Compositor do

    let(:described) { Vedeu::Compositor }
    let(:instance)  { described.new(buffer) }
    let(:buffer)    { Buffer.new(interface.name, interface) }
    let(:interface) {
      Vedeu.interface('compositor') do
        geometry do
          height 5
          width  10
        end
        lines do
          line 'Some text...'
        end
      end
    }

    before { IO.console.stubs(:print) }

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, Compositor) }
      it { assigns(subject, '@buffer', buffer) }
    end

    describe '.compose' do
      subject { described.compose(buffer) }

      it { skip }

      context 'when there is no content' do
        it { skip }
      end

      context 'when there is content' do
        context 'when the view has redefined the geometry' do
          it { skip }
        end

        context 'when the view has not redefined the geometry' do
          it 'returns the escape sequences and content sent to the console' do
            subject.must_equal(
              [
                [
                  "\e[1;1H          \e[1;1H" \
                  "\e[2;1H          \e[2;1H" \
                  "\e[3;1H          \e[3;1H" \
                  "\e[4;1H          \e[4;1H" \
                  "\e[5;1H          \e[5;1H" \
                  "\e[1;1HSome text." \
                  "\e[2;1H          " \
                  "\e[3;1H          " \
                  "\e[4;1H          " \
                  "\e[5;1H          ",

                  "\e[1;1H\e[?25l"
                ]
              ]
            )
          end
        end
      end
    end

  end # Compositor

end # Vedeu
