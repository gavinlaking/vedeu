require 'test_helper'

module Vedeu

  module Cursors

    describe Repository do

      let(:described) { Vedeu::Cursors::Repository }

      it { described.must_respond_to(:cursors) }

      describe '.cursor' do
        before { Vedeu::Models::Focus.reset }

        subject { Vedeu.cursor }

        context 'when there are cursors are defined' do
          before do
            Vedeu.cursors.reset
            Vedeu::Cursors::Cursor.store(name: 'Vedeu.cursor')
            Vedeu::Models::Focus.add('Vedeu.cursor')
          end

          it 'returns the cursor of the interface/view currently in focus' do
            subject.must_be_instance_of(Vedeu::Cursors::Cursor)
          end
        end

        context 'when there are no cursors defined' do
          before {
            Vedeu::Models::Focus.add('Vedeu.cursor')
            Vedeu.cursors.reset
          }

          it {
            subject.must_be_instance_of(Vedeu::Cursors::Cursor)
          }
        end

        context 'when there are no interfaces or views defined' do
          it { proc { subject }.must_raise(Vedeu::Error::Fatal) }
        end
      end

    end # Repository

  end # Cursors

end # Vedeu
