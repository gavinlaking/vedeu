require 'test_helper'

module Vedeu

  describe Mapper do

    let(:described)  { Vedeu::Mapper }
    let(:instance)   { described.new(key, keymap, repository) }
    let(:key)        {}
    let(:keymap)     {}
    let(:repository) {}

    before do
      Vedeu.keymaps.reset
    end

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@key').must_equal(key) }
      it { instance.instance_variable_get('@name').must_equal(keymap) }
      it { instance.instance_variable_get('@repository').
                    must_equal(Vedeu.keymaps) }

      context 'when the repository is provided' do
        let(:repository) { Vedeu::Repository.new }

        it { instance.instance_variable_get('@repository').
                      must_equal(repository) }
      end
    end

    describe '.keypress' do
      let(:keymap) { 'test' }

      subject { described.keypress(key, keymap) }

      context 'when the key is not provided' do
        it { subject.must_equal(false) }
      end

      context 'when the key is provided' do
        let(:key) { 'a' }

        context 'and the key is defined' do
          let(:key_test) { Key.new('a') { :do_something } }
          let(:keymap_test) { Keymap.new(name: 'test', keys: [key_test]) }

          before do
            Vedeu.keymaps.reset
            Vedeu.keymaps.store(keymap_test)
          end

          it { subject.must_equal(true) }
        end

        context 'and the key is not defined' do
          it { subject.must_equal(false) }
        end
      end
    end

    describe '.valid?' do
      let(:keymap) { 'test' }

      subject { described.valid?(key, keymap) }

      context 'when the key is not provided' do
        it { subject.must_equal(false) }
      end

      context 'when the key is provided' do
        let(:key) { 'a' }

        context 'and the key is defined' do
          let(:key_test) { Key.new('a') { :do_something } }
          let(:keymap_test) { Keymap.new(name: 'test', keys: [key_test]) }

          before do
            Vedeu.keymaps.reset
            Vedeu.keymaps.store(keymap_test)
          end

          it { subject.must_equal(false) }
        end

        context 'and the key is not defined' do
          it { subject.must_equal(true) }
        end
      end
    end

  end # Mapper

end # Vedeu
