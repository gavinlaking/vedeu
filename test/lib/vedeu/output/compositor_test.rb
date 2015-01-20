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

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, Compositor) }
      it { assigns(subject, '@buffer', buffer) }
    end

    describe '.compose' do
      it { skip }

      context 'when there is no content' do
        it { skip }
      end

      context 'when there is content' do
        context 'when the view has redefined the geometry' do
          it { skip }
        end

        context 'when the view has not redefined the geometry' do
          it { skip }
        end
      end
    end

  end # Compositor

end # Vedeu
