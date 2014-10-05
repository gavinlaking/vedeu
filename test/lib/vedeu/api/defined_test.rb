require 'test_helper'

module Vedeu
  module API
    describe Defined do
      describe '#events' do
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

      describe '#keymaps' do
        before { Vedeu::Keymaps.reset }

        it 'returns the default keymap when no others are registered' do
          Defined.keymaps.must_equal(['_global_keymap_'])
        end

        it 'returns all keymaps currently registered' do
          Vedeu.keys('flerovium') do
            key('u') { :some_action }
          end

          Defined.keymaps.must_equal(['_global_keymap_', 'flerovium'])
        end
      end

      describe '#menus' do
        before { Vedeu::Menus.reset }

        it 'returns no menus when none currently registered' do
          Defined.menus.must_equal([])
        end

        it 'returns all menus currently registered' do
          Vedeu.menu('seaborgium') { items [:promethium, :astatine, :niobium] }

          Defined.menus.must_equal(['seaborgium'])
        end
      end
    end
  end
end
