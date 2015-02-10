require 'test_helper'

require 'vedeu/support/visible'

module Vedeu

  describe Visible do

    let(:described) { Vedeu::Visible }
    let(:instance)  { described.new(visible) }
    let(:visible)   { true }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Visible) }

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

    describe '.coerce' do
      subject { described.coerce(value) }

      context 'when the value is a Visible' do
        let(:value) { described.new }

        it { subject.must_be_instance_of(Visible) }
        it { subject.visible?.must_equal(false) }
      end

      context 'when the value is not a Visible' do
        let(:value) { :show }

        it { subject.must_be_instance_of(Visible) }
        it { subject.visible?.must_equal(true) }
      end
    end

    describe '#inspect' do
      subject { instance.inspect }

      it { subject.must_equal('<Vedeu::Visible (true)>') }
    end

    describe '#cursor' do
      subject { instance.cursor }

      it { subject.must_be_instance_of(String) }

      context 'when visible' do
        it { subject.must_equal("\e[?25h") }
      end

      context 'when not visible' do
        let(:visible) { false }

        it { subject.must_equal("\e[?25l") }
      end
    end

    describe '#visible?' do
      subject { instance.visible? }

      context 'when visible' do
        it { subject.must_be_instance_of(TrueClass) }
      end

      context 'when not visible' do
        let(:visible) { false }

        it { subject.must_be_instance_of(FalseClass) }
      end
    end

    describe '#invisible?' do
      subject { instance.invisible? }

      context 'when not visible' do
        let(:visible) { false }

        it { subject.must_be_instance_of(TrueClass) }
      end

      context 'when visible' do
        it { subject.must_be_instance_of(FalseClass) }
      end
    end

    describe '#hide' do
      subject { instance.hide }

      it { subject.must_be_instance_of(Visible) }
      it { subject.visible?.must_equal(false) }
    end

    describe '#show' do
      subject { instance.show }
      it { subject.must_be_instance_of(Visible) }
      it { subject.visible?.must_equal(true) }
    end

    describe '#toggle' do
      subject { instance.toggle }

      it { subject.must_be_instance_of(Visible) }

      context 'when visible' do
        it { subject.visible?.must_be_instance_of(FalseClass) }
      end

      context 'when not visible' do
        let(:visible) { false }

        it { subject.visible?.must_be_instance_of(TrueClass) }
      end
    end

  end # Visible

end # Vedeu
