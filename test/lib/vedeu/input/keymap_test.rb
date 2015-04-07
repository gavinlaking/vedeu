require 'test_helper'

module Vedeu

  describe Keymap do

    let(:described)  { Vedeu::Keymap }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        name: map_name,
        keys: keys
      }
    }
    let(:map_name)  { 'zirconium' }
    let(:keys)      { [] }
    let(:key)       { Vedeu::Key.new('a') { :output } }

    describe '#initialize' do
      it { instance.must_be_instance_of(Keymap) }
      it { instance.instance_variable_get('@name').must_equal(map_name) }
      it { instance.instance_variable_get('@keys').must_be_instance_of(Array) }
      it { instance.instance_variable_get('@repository').
                    must_equal(Vedeu.keymaps) }
    end

    describe '#add' do
      subject { instance.add(key) }

      context 'when the key is already defined' do
        before do
          Vedeu.keymaps.reset
          instance.add(key)
        end

        it { subject.must_equal(false) }
      end

      context 'when the key is not already defined' do
        it { subject.must_be_instance_of(Vedeu::Keys) }
      end
    end

    describe '#key_defined?' do
      let(:input) { 'a' }

      subject { instance.key_defined?(input) }

      context 'when the input is defined' do
        let(:keys) { Vedeu::Keys.new([key]) }

        it { subject.must_be_instance_of(TrueClass) }
      end

      context 'when the input is not defined' do
        it { subject.must_be_instance_of(FalseClass) }
      end
    end

    describe '#use' do
      let(:input) { 'b' }

      subject { instance.use(input) }

      context 'when the input is defined' do
        let(:key_a) { Vedeu::Key.new('a') { :key_a } }
        let(:key_b) { Vedeu::Key.new('b') { :key_b } }
        let(:key_c) { Vedeu::Key.new('c') { :key_c } }
        let(:keys)  { Vedeu::Keys.new([key_a, key_b, key_c]) }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal([:key_b]) }
      end

      context 'when the input is not defined' do
        it { subject.must_be_instance_of(FalseClass) }
      end
    end

    describe '#keys' do
      subject { instance.keys }

      it { subject.must_be_instance_of(Vedeu::Keys) }
    end

    describe '#name' do
      subject { instance.name }

      it { subject.must_be_instance_of(String) }
    end

  end # Keymap

end # Vedeu
