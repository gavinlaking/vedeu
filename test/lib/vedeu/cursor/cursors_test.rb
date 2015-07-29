require 'test_helper'

module Vedeu

  describe Cursors do

    let(:described) { Vedeu::Cursors }

    it { described.must_respond_to(:cursors) }

    describe '.cursor' do
      subject { Vedeu.cursor }

      context 'when there are cursors are defined' do
        before {
          Vedeu::Focus.add('Vedeu.cursor')
          Vedeu::Cursor.new(name: 'Vedeu.cursor').store
        }

        it { subject.must_be_instance_of(Vedeu::Cursor) }
      end

      context 'when there are no cursors defined' do
        before {
          Vedeu::Focus.reset
          Vedeu.cursors.reset
        }

        it { subject.must_be_instance_of(NilClass) }
      end
    end

  end # Cursors

end # Vedeu
