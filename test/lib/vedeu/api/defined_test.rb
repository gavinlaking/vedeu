require 'test_helper'

module Vedeu
  module API
    describe Defined do
      describe '#events' do
        it 'returns no events when none currently registered' do
          Vedeu.stub(:events, Events.new) do
            Defined.events.must_equal([])
          end
        end

        it 'returns all events currently registered' do
          Vedeu.event(:birthday) { :eat_too_much_cake }

          Defined.events.must_include(:birthday)
        end
      end

      describe '#groups' do
        before { Vedeu::Groups.reset }

        it 'returns no groups when none currently registered' do
          Defined.groups.must_equal([])
        end

        it 'returns all groups currently registered' do
          Vedeu.interface('hydrogen') { group 'elements' }

          Defined.groups.must_equal(['elements'])
        end
      end

      describe '#interfaces' do
        before { Vedeu::Interfaces.reset }

        it 'returns no interfaces when none currently registered' do
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
