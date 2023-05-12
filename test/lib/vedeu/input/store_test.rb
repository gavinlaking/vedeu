# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Input

    describe Store do

      let(:described) { Vedeu::Input::Store }

      before { described.reset! }

      describe '#add_command' do
        let(:command) { 'command_1' }

        subject { described.add_command(command) }

        it { subject.must_equal(['command_1']) }
      end

      describe '#add_keypress' do
        let(:keypress) { 'a' }

        subject { described.add_keypress(keypress) }

        it { subject.must_equal(['a']) }
      end

      describe '#all_commands' do
        subject { described.all_commands }

        context 'when there are no stored commands' do
          it { subject.must_equal([]) }
        end

        context 'when there are stored commands' do
          before do
            described.add_command('command_1')
            described.add_command('command_2')
            described.add_command('command_3')
          end

          it { subject.must_equal(['command_1', 'command_2', 'command_3']) }
        end
      end

      describe '#all_keypresses' do
        subject { described.all_keypresses }

        context 'when there are no stored keypresses' do
          it { subject.must_equal([]) }
        end

        context 'when there are stored keypresses' do
          before do
            described.add_keypress('a')
            described.add_keypress('b')
            described.add_keypress('c')
          end

          it { subject.must_equal(['a', 'b', 'c']) }
        end
      end

      describe '#last_command' do
        subject { described.last_command }

        context 'when there are no stored commands' do
          it { assert_nil(subject) }
        end

        context 'when there are stored commands' do
          before do
            described.add_command('command_1')
            described.add_command('command_2')
            described.add_command('command_3')
          end

          it { subject.must_equal('command_3') }
        end
      end

      describe '#last_keypress' do
        subject { described.last_keypress }

        context 'when there are no stored keypresses' do
          it { assert_nil(subject) }
        end

        context 'when there are stored keypresses' do
          before do
            described.add_keypress('a')
            described.add_keypress('b')
            described.add_keypress('c')
          end

          it { subject.must_equal('c') }
        end
      end

    end # Store

  end # Input

end # Vedeu
