# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Cursors

    describe Repository do

      let(:described) { Vedeu::Cursors::Repository }

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

          it do
            subject.must_be_instance_of(Vedeu::Cursors::Cursor)
          end
        end

        context 'when there are no interfaces or views defined' do
          it 'returns an unnamed cursor' do
            subject.must_be_instance_of(Vedeu::Cursors::Cursor)
          end
        end
      end

    end # Repository

  end # Cursors

end # Vedeu
