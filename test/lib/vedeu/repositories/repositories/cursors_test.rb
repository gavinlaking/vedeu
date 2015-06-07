require 'test_helper'

module Vedeu

  describe Cursors do

    let(:described) { Vedeu::Cursors }

    describe '.cursor' do
      subject { Vedeu.cursor }

      context 'when there are cursors are defined' do
        before do
          Vedeu::Focus.add('Vedeu.cursor')
          Vedeu::Cursor.new(name: 'Vedeu.cursor').store
        end

        it { subject.must_be_instance_of(Vedeu::Cursor) }
      end

      context 'when there are no cursors defined' do
        before do
          Vedeu::Focus.reset
          Vedeu.cursors.reset
        end

        it { subject.must_be_instance_of(NilClass) }
      end
    end

  end # Cursors

end # Vedeu
