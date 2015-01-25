require 'test_helper'

require 'vedeu/support/visible'

module Vedeu

  describe Visible do

    let(:described) { Vedeu::Visible }
    let(:instance)  { described.new(visible) }
    let(:visible)   { true }

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, Visible) }

      context 'when visible is :hide' do
        let(:visible) { :hide }

        it { subject.instance_variable_get('@visible').must_equal(false) }
      end

      context 'when visible is :show' do
        let(:visible) { :show }

        it { subject.instance_variable_get('@visible').must_equal(true) }
      end

      context 'when visible is nil' do
        let(:visible) { nil }

        it { subject.instance_variable_get('@visible').must_equal(false) }
      end

      context 'when visible is false' do
        let(:visible) { false }

        it { subject.instance_variable_get('@visible').must_equal(false) }
      end

      context 'when visible is anything else that evaluates to true' do
        let(:visible) { 'yeah show it!' }

        it { subject.instance_variable_get('@visible').must_equal(true) }
      end
    end

    describe '#cursor' do
      subject { instance.cursor }

      it { return_type_for(subject, String) }

      context 'when visible' do
        it { return_value_for(subject, "\e[?25h") }
      end

      context 'when not visible' do
        let(:visible) { false }

        it { return_value_for(subject, "\e[?25l") }
      end
    end

    describe '#visible?' do
      subject { instance.visible? }

      context 'when visible' do
        it { return_type_for(subject, TrueClass) }
      end

      context 'when not visible' do
        let(:visible) { false }

        it { return_type_for(subject, FalseClass) }
      end
    end

    describe '#invisible?' do
      subject { instance.invisible? }

      context 'when not visible' do
        let(:visible) { false }

        it { return_type_for(subject, TrueClass) }
      end

      context 'when visible' do
        it { return_type_for(subject, FalseClass) }
      end
    end

    describe '#hide' do
      subject { instance.hide }

      it { return_type_for(subject, Visible) }
      it { return_value_for(subject.visible?, false) }
    end

    describe '#show' do
      subject { instance.show }
      it { return_type_for(subject, Visible) }
      it { return_value_for(subject.visible?, true) }
    end

    describe '#toggle' do
      subject { instance.toggle }

      it { return_type_for(subject, Visible) }

      context 'when visible' do
        it { return_type_for(subject.visible?, FalseClass) }
      end

      context 'when not visible' do
        let(:visible) { false }

        it { return_type_for(subject.visible?, TrueClass) }
      end
    end

  end # Visible

end # Vedeu
