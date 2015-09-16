require 'test_helper'

module Vedeu

  module Cursors

    describe Repository do

      let(:described) { Vedeu::Cursors::Repository }

      it { described.must_respond_to(:cursors) }

      describe '.cursor' do
        subject { Vedeu.cursor }

        context 'when there are cursors are defined' do
          before do
            Vedeu::Models::Focus.reset
            Vedeu.cursors.reset
            Vedeu::Models::Focus.add('Vedeu.cursor')
            Vedeu::Cursors::Cursor.new(name: 'Vedeu.cursor').store
          end

          it { subject.must_be_instance_of(Vedeu::Cursors::Cursor) }
        end

        context 'when there are no cursors defined' do
          before do
            Vedeu::Models::Focus.reset
            Vedeu.cursors.reset
          end

          it { subject.must_be_instance_of(NilClass) }
        end
      end

    end # Repository

  end # Cursors

end # Vedeu
