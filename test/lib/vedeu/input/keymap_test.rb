require 'test_helper'

module Vedeu

  describe Keymap do

    let(:described) { Vedeu::Keymap }
    let(:instance)  { described.new(map_name, keys) }
    let(:map_name)  { 'zirconium' }
    let(:keys)      { [] }
    let(:key)       { Vedeu::Key.new('a') { :output } }

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, Keymap) }
      it { assigns(subject, '@name', map_name) }
      it { subject.instance_variable_get('@keys').must_be_instance_of(Vedeu::Model::Collection) }
    end

    describe '#deputy' do
      subject { instance.deputy }

      it { return_type_for(subject, Vedeu::DSL::Keymap) }
    end

    describe '#add' do
      subject { instance.add(key) }

      context 'when the key is already defined' do
        let(:keys) { Vedeu::Model::Collection.new([key]) }

        it { proc { subject }.must_raise(KeyInUse) }
      end

      context 'when the key is not already defined' do
        it { return_type_for(subject, Vedeu::Model::Collection) }
      end
    end

    describe '#key_defined?' do
      let(:input) { 'a' }

      subject { instance.key_defined?(input) }

      context 'when the input is defined' do
        let(:keys) { Vedeu::Model::Collection.new([key]) }

        it { return_type_for(subject, TrueClass) }
      end

      context 'when the input is not defined' do
        it { return_type_for(subject, FalseClass) }
      end
    end

    describe '#use' do
      let(:input) { 'b' }

      subject { instance.use(input) }

      context 'when the input is defined' do
        let(:key_a) { Vedeu::Key.new('a') { :key_a } }
        let(:key_b) { Vedeu::Key.new('b') { :key_b } }
        let(:key_c) { Vedeu::Key.new('c') { :key_c } }
        let(:keys)  { Vedeu::Model::Collection.new([key_a, key_b, key_c]) }

        it { return_type_for(subject, Array) }
        it { return_value_for(subject, [:key_b]) }
      end

      context 'when the input is not defined' do
        it { return_type_for(subject, NilClass) }
      end
    end

    describe '#keys' do
      subject { instance.keys }

      it { return_type_for(subject, Vedeu::Model::Collection) }
    end

    describe '#name' do
      subject { instance.name }

      it { return_type_for(subject, String) }
    end

  end # Keymap

end # Vedeu
