require 'test_helper'

require 'vedeu/support/visible'

module Vedeu

  describe Visible do

    let(:described) { Visible.new(visible) }
    let(:visible)   { true }

    describe '#initialize' do
      it { return_type_for(described, Visible) }

      context 'when visible is :hide' do
        let(:visible) { :hide }

        it { assigns(described, '@visible', false) }
      end

      context 'when visible is :show' do
        let(:visible) { :show }

        it { assigns(described, '@visible', true) }
      end

      context 'when visible is nil' do
        let(:visible) { nil }

        it { assigns(described, '@visible', false) }
      end

      context 'when visible is false' do
        let(:visible) { false }

        it { assigns(described, '@visible', false) }
      end

      context 'when visible is anything else that evaluates to true' do
        let(:visible) { 'yeah show it!' }

        it { assigns(described, '@visible', true) }
      end
    end

    describe '#visible?' do
      context 'when visible' do
        it { return_type_for(described.visible?, TrueClass) }
      end

      context 'when not visible' do
        let(:visible) { false }

        it { return_type_for(described.visible?, FalseClass) }
      end
    end

    describe '#invisible?' do
      context 'when not visible' do
        let(:visible) { false }

        it { return_type_for(described.invisible?, TrueClass) }
      end

      context 'when visible' do
        it { return_type_for(described.invisible?, FalseClass) }
      end
    end

    describe '#hide' do
      it { return_type_for(described.hide, Visible) }
      it { return_value_for(described.hide.visible?, false) }
    end

    describe '#show' do
      it { return_type_for(described.show, Visible) }
      it { return_value_for(described.show.visible?, true) }
    end

    describe '#toggle' do
      it { return_type_for(described.toggle, Visible) }

      context 'when visible' do
        it { return_type_for(described.toggle.visible?, FalseClass) }
      end

      context 'when not visible' do
        let(:visible) { false }

        it { return_type_for(described.toggle.visible?, TrueClass) }
      end
    end

  end # Visible

end # Vedeu
