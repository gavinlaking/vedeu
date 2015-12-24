require 'test_helper'

module Vedeu

  module Input

    describe Keymap do

      let(:described)  { Vedeu::Input::Keymap }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          name: map_name,
          keys: keys
        }
      }
      let(:map_name)  { 'zirconium' }
      let(:keys)      { [] }
      let(:key)       { Vedeu::Input::Key.new('a') { :output } }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(map_name) }
        it { instance.instance_variable_get('@keys').must_be_instance_of(Array) }
        it do
          instance.instance_variable_get('@repository').must_equal(Vedeu.keymaps)
        end
      end

      describe '#name' do
        it { instance.must_respond_to(:name) }
      end

      describe '#name=' do
        it { instance.must_respond_to(:name=) }
      end

      describe '#add' do
        before { Vedeu.stubs(:log) }

        subject { instance.add(key) }

        context 'when the key is already defined' do
          before do
            Vedeu.keymaps.reset
            instance.add(key)
          end

          it { subject.must_equal(false) }
        end

        context 'when the key is not already defined' do
          it { subject.must_be_instance_of(Vedeu::Input::Keys) }
        end
      end

      describe '#deputy' do
        subject { instance.deputy }

        it 'returns the DSL instance' do
          subject.must_be_instance_of(Vedeu::Input::DSL)
        end
      end

      describe '#key_defined?' do
        let(:input) { 'a' }

        subject { instance.key_defined?(input) }

        context 'when the input is defined' do
          let(:keys) { Vedeu::Input::Keys.new([key]) }

          it { subject.must_be_instance_of(TrueClass) }
        end

        context 'when the input is not defined' do
          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#use' do
        let(:input) { 'b' }

        before { Vedeu.stubs(:log) }

        subject { instance.use(input) }

        context 'when the input is defined' do
          let(:key_a) { Vedeu::Input::Key.new('a') { :key_a } }
          let(:key_b) { Vedeu::Input::Key.new('b') { :key_b } }
          let(:key_c) { Vedeu::Input::Key.new('c') { :key_c } }
          let(:keys)  { Vedeu::Input::Keys.new([key_a, key_b, key_c]) }

          it { subject.must_be_instance_of(Array) }
          it { subject.must_equal([:key_b]) }
        end

        context 'when the input is not defined' do
          it { subject.must_be_instance_of(FalseClass) }
        end
      end

      describe '#keys' do
        subject { instance.keys }

        it { subject.must_be_instance_of(Vedeu::Input::Keys) }
      end

    end # Keymap

  end # Input

end # Vedeu
