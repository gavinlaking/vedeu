require 'test_helper'

module Vedeu
  module API
    describe Defined do
      describe '#events' do
        before { Vedeu.events.reset }

        it 'returns no events when none currently registered' do
          Defined.events.must_equal([])
        end

        it 'returns all events currently registered' do
          Vedeu.event(:birthday) { :eat_too_much_cake }

          Defined.events.must_equal([:birthday])
        end
      end

      describe '#groups' do
        it 'returns no groups when none currently registered' do
          Vedeu::Groups.reset

          Defined.groups.must_equal([])
        end

        it 'returns all groups currently registered' do
          Vedeu.interface('hydrogen') { group 'elements' }

          Defined.groups.must_equal(['elements'])
        end
      end

      describe '#interfaces' do
        it 'returns no interfaces when none currently registered' do
          Vedeu::Interfaces.reset

          Defined.interfaces.must_equal([])
        end

        it 'returns all interfaces currently registered' do
          Vedeu.interface('hydrogen') { group 'elements' }

          Defined.interfaces.must_equal(['hydrogen'])
        end
      end
    end
  end
end
