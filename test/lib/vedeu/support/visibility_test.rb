require 'test_helper'

module Vedeu

  class VisibilityTestModel
    attr_accessor :visible
    alias_method :visible?, :visible

    def initialize(visible = true)
      @visible = visible
    end

    def store
      self
    end
  end

  describe Visibility do

    let(:described) { Vedeu::Visibility }
    let(:instance)  { described.new(model) }
    let(:model)     { VisibilityTestModel.new(visible) }
    let(:visible)   { true }
    let(:_name)     { 'Vedeu::Visibility' }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@model').must_equal(model) }
    end

    describe '.for_cursor' do
      subject { described.for_cursor(_name) }

      it { subject.must_be_instance_of(described) }
    end

    describe '.show' do
      subject { described.show(model) }

      it { subject.must_equal(model) }

      it { subject; instance.state.must_equal(:visible) }
    end

    describe '.hide' do
      subject { described.hide(model) }

      it { subject.must_equal(model) }

      it { subject; instance.state.must_equal(:invisible) }
    end

    describe '.show_cursor' do
      subject { described.show_cursor(_name) }

      it { subject; instance.state.must_equal(:visible) }
    end

    describe '.hide_cursor' do
      subject { described.hide_cursor(_name) }

      # it { subject; instance.state.must_equal(:invisible) }
      # it { skip }
    end

    describe '.toggle' do
      subject { described.toggle(model) }

      it { subject.must_equal(model) }

      context 'when the model is visible' do
        it { subject; instance.state.must_equal(:invisible) }
      end

      context 'when the model is not visible' do
        let(:visible) { false }

        it { subject; instance.state.must_equal(:visible) }
      end
    end

    describe '#state' do
      subject { instance.state }

      it { subject.must_be_instance_of(Symbol) }

      context 'when the model is visible' do
        it { subject.must_equal(:visible) }
      end

      context 'when the model is not visible' do
        let(:visible) { false }

        it { subject.must_equal(:invisible) }
      end
    end

  end # Visibility

end # Vedeu
