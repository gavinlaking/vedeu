require 'test_helper'

module Vedeu

  describe Keymap do

    let(:described) { Keymap.new(map_name, keymap) }
    let(:map_name)  { 'zirconium' }
    let(:keymap)    { {} }
    let(:key)       { 'a' }
    let(:action)    { proc { :noop } }

    describe '#initialize' do
      subject { described }

      it { return_type_for(subject, Keymap) }
      it { assigns(subject, '@name', map_name) }
      it { assigns(subject, '@keymap', keymap) }
    end

    describe '#define' do
      subject { described.define(key, action) }

      it { skip }

      # it { return_type_for(subject, Keymap) }

      context 'when the key/action pair is valid' do
        let(:key)    { 'b' }
        let(:action) { proc { :noop } }
      end

      context 'when the key/action pair is invalid' do
        context 'the key is already in use' do
          let(:keymap) { { 'a' => proc { :noop } } }

          it { skip }

          # it { proc { subject }.must_raise(KeyInUse) }
        end

        context 'the action is not callable' do
          let(:action) {}

          it { skip }

          # it { proc { subject }.must_raise(InvalidSyntax) }
        end
      end
    end

    describe '#defined?' do
      subject { described.defined?(key) }

      context 'when the key is defined' do
        let(:keymap) { { 'a' => proc { :noop } } }

        it { return_type_for(subject, TrueClass) }
      end

      context 'when the key is not defined' do
        it { return_type_for(subject, FalseClass) }
      end
    end

    describe '#keys' do
      subject { described.keys }

      it { return_type_for(subject, Array) }

      context 'when keys are defined' do
        it { skip }
      end

      context 'when no keys are defined' do
        it { skip }
      end
    end

    describe '#use' do
      subject { described.use(key) }

      context 'when the key is defined' do
        it { skip }
      end

      context 'when the key is not defined' do
        it { skip }
      end
    end

  end # Keymap

end # Vedeu
