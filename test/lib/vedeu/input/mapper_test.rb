require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_keypress_).must_equal(true) }
    it { Vedeu.bound?(:_drb_input_).must_equal(true) }
    it { Vedeu.bound?(:_command_).must_equal(true) }
  end

  module Input

    describe Mapper do

      let(:described)  { Vedeu::Input::Mapper }
      let(:instance)   { described.new(key, _name, repository) }
      let(:key)        {}
      let(:_name)      {}
      let(:repository) {}

      before { Vedeu.keymaps.reset }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@key').must_equal(key) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it do
          instance.instance_variable_get('@repository').must_equal(Vedeu.keymaps)
        end

        context 'when the repository is provided' do
          let(:repository) { Vedeu::Repositories::Repository.new }

          it do
            instance.instance_variable_get('@repository').must_equal(repository)
          end
        end
      end

      describe '.keypress' do
        let(:_name) { 'test' }

        before { Vedeu.stubs(:log) }

        subject { described.keypress(key, _name) }

        context 'when the key is not provided' do
          it { subject.must_equal(false) }
        end

        context 'when the key is provided' do
          let(:key) { 'a' }

          context 'and the key is defined' do
            let(:key_test) { Vedeu::Input::Key.new('a') { :do_something } }
            let(:keymap_test) {
              Vedeu::Input::Keymap.new(name: 'test', keys: [key_test])
            }

            before { Vedeu.keymaps.store(keymap_test) }

            it { subject.must_equal(true) }
          end

          context 'and the key is not defined' do
            it { subject.must_equal(false) }
          end
        end
      end

      describe '.registered?' do
        subject { described.registered?(key, _name) }

        context 'when the name was given' do
          let(:_name) { :some_keymap }

          context 'when the key was given' do
            let(:key) { 'a' }

            context 'when the key is defined for the keymap' do
              # @todo Add more tests.
              # it { skip }

              # it { subject.must_equal(true) }
            end

            context 'when the key is not defined for the keymap' do
              it { subject.must_equal(false) }
            end
          end

          context 'when the key was not given' do
            let(:key) {}

            it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
          end
        end

        context 'when the name was not given' do
          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end
      end

      describe '.valid?' do
        let(:_name) { 'test' }

        subject { described.valid?(key, _name) }

        context 'when the key is not provided' do
          it { subject.must_equal(false) }
        end

        context 'when the key is provided' do
          let(:key) { 'a' }

          context 'and the key is defined' do
            let(:key_test) { Vedeu::Input::Key.new('a') { :do_something } }
            let(:keymap_test) {
              Vedeu::Input::Keymap.new(name: 'test', keys: [key_test])
            }

            before { Vedeu.keymaps.store(keymap_test) }

            it { subject.must_equal(false) }
          end

          context 'and the key is not defined' do
            it { subject.must_equal(true) }
          end
        end
      end

    end # Mapper

  end # Input

end # Vedeu
