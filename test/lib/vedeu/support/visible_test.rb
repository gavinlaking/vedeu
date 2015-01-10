require 'test_helper'

require 'vedeu/support/visible'

module Vedeu

  describe Visible do

    let(:described) { Vedeu::Visible }
    let(:instance)  { described.new(visible) }
    let(:visible)   { true }

    describe '#initialize' do
      it { return_type_for(instance, Visible) }

      context 'when visible is :hide' do
        let(:visible) { :hide }

        it { assigns(instance, '@visible', false) }
      end

      context 'when visible is :show' do
        let(:visible) { :show }

        it { assigns(instance, '@visible', true) }
      end

      context 'when visible is nil' do
        let(:visible) { nil }

        it { assigns(instance, '@visible', false) }
      end

      context 'when visible is false' do
        let(:visible) { false }

        it { assigns(instance, '@visible', false) }
      end

      context 'when visible is anything else that evaluates to true' do
        let(:visible) { 'yeah show it!' }

        it { assigns(instance, '@visible', true) }
      end
    end

    describe '#cursor' do
      it { return_type_for(instance.cursor, String) }

      context 'when visible' do
        it { return_value_for(instance.cursor, "\e[?25h") }
      end

      context 'when not visible' do
        let(:visible) { false }

        it { return_value_for(instance.cursor, "\e[?25l") }
      end
    end

    describe '#visible?' do
      context 'when visible' do
        it { return_type_for(instance.visible?, TrueClass) }
      end

      context 'when not visible' do
        let(:visible) { false }

        it { return_type_for(instance.visible?, FalseClass) }
      end
    end

    describe '#invisible?' do
      context 'when not visible' do
        let(:visible) { false }

        it { return_type_for(instance.invisible?, TrueClass) }
      end

      context 'when visible' do
        it { return_type_for(instance.invisible?, FalseClass) }
      end
    end

    describe '#hide' do
      it { return_type_for(instance.hide, Visible) }
      it { return_value_for(instance.hide.visible?, false) }
    end

    describe '#show' do
      it { return_type_for(instance.show, Visible) }
      it { return_value_for(instance.show.visible?, true) }
    end

    describe '#toggle' do
      it { return_type_for(instance.toggle, Visible) }

      context 'when visible' do
        it { return_type_for(instance.toggle.visible?, FalseClass) }
      end

      context 'when not visible' do
        let(:visible) { false }

        it { return_type_for(instance.toggle.visible?, TrueClass) }
      end
    end

  end # Visible

end # Vedeu
