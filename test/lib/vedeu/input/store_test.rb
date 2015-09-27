require 'test_helper'

module Vedeu

  module Input

    describe Store do

      let(:described) { Vedeu::Input::Store }
      let(:instance)  { described.new }

      before { instance.reset }

      describe '#add_command' do
        let(:command) { 'command_1' }

        subject { instance.add_command(command) }

        it { subject.must_equal(['command_1']) }
      end

      describe '#add_keypress' do
        let(:keypress) { 'a' }

        subject { instance.add_keypress(keypress) }

        it { subject.must_equal(['a']) }
      end

      describe '#all' do
        subject { instance.all }

        context 'when empty' do
          it { subject.must_equal({ commands: [], keypresses: [] }) }
        end

        context 'when not empty' do
          let(:expected) {
            {
              commands:   ['command_1', 'command_2'],
              keypresses: ['a', 'b'],
            }
          }

          before do
            instance.add_command('command_1')
            instance.add_command('command_2')
            instance.add_keypress('a')
            instance.add_keypress('b')
          end

          it { subject.must_equal(expected) }
        end
      end

      describe '#all_commands' do
        subject { instance.all_commands }

        context 'when there are no stored commands' do
          it { subject.must_equal([]) }
        end

        context 'when there are stored commands' do
          before do
            instance.add_command('command_1')
            instance.add_command('command_2')
            instance.add_command('command_3')
          end

          it { subject.must_equal(['command_1', 'command_2', 'command_3']) }
        end
      end

      describe '#all_keypresses' do
        subject { instance.all_keypresses }

        context 'when there are no stored keypresses' do
          it { subject.must_equal([]) }
        end

        context 'when there are stored keypresses' do
          before do
            instance.add_keypress('a')
            instance.add_keypress('b')
            instance.add_keypress('c')
          end

          it { subject.must_equal(['a', 'b', 'c']) }
        end
      end

      describe '#last_command' do
        subject { instance.last_command }

        context 'when there are no stored commands' do
          it { subject.must_equal(nil) }
        end

        context 'when there are stored commands' do
          before do
            instance.add_command('command_1')
            instance.add_command('command_2')
            instance.add_command('command_3')
          end

          it { subject.must_equal('command_3') }
        end
      end

      describe '#last_keypress' do
        subject { instance.last_keypress }

        context 'when there are no stored keypresses' do
          it { subject.must_equal(nil) }
        end

        context 'when there are stored keypresses' do
          before do
            instance.add_keypress('a')
            instance.add_keypress('b')
            instance.add_keypress('c')
          end

          it { subject.must_equal('c') }
        end
      end

      describe '#reset' do
        subject { instance.reset }

        it { subject.must_equal({ commands: [], keypresses: [] }) }
      end

    end # Store

  end # Input

end # Vedeu
