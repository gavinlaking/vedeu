require 'test_helper'

module Vedeu

  class ToggleableTestClass
    include Vedeu::Toggleable

    def initialize(boolean)
      @visible = boolean
    end

    def store
      self
    end
  end

  describe Toggleable do

    let(:described)          { Vedeu::Toggleable }
    let(:described_included) { Vedeu::ToggleableTestClass }
    let(:instance)           { described_included.new(visible) }
    let(:visible)            { false }

    describe 'accessors' do
      it do
        instance.must_respond_to(:visible)
        instance.must_respond_to(:visible=)
        instance.must_respond_to(:visible?)
      end
    end

    describe '#hide' do
      subject { instance.hide }

      it do
        subject
        instance.instance_variable_get('@visible').must_equal(false)
      end

      it { Vedeu::ToggleableTestClass.must_respond_to(:hide_cursor) }
      it { Vedeu::ToggleableTestClass.must_respond_to(:hide_group) }
      it { Vedeu::ToggleableTestClass.must_respond_to(:hide_interface) }
    end

    describe '#show' do
      subject { instance.show }

      it do
        subject
        instance.instance_variable_get('@visible').must_equal(true)
      end

      it { Vedeu::ToggleableTestClass.must_respond_to(:show_cursor) }
      it { Vedeu::ToggleableTestClass.must_respond_to(:show_group) }
      it { Vedeu::ToggleableTestClass.must_respond_to(:show_interface) }
    end

    describe '#toggle' do
      subject { instance.toggle }

      it { Vedeu::ToggleableTestClass.must_respond_to(:toggle_cursor) }
      it { Vedeu::ToggleableTestClass.must_respond_to(:toggle_group) }
      it { Vedeu::ToggleableTestClass.must_respond_to(:toggle_interface) }

      context 'when the model is visible' do
        let(:visible) { true }

        it do
          subject
          instance.instance_variable_get('@visible').must_equal(false)
        end
      end

      context 'when the model is not visible' do
        it do
          subject
          instance.instance_variable_get('@visible').must_equal(true)
        end
      end
    end

    describe '.hide_cursor' do
      subject { described_included.hide_cursor }

      context 'when the cursor is visible' do
        # @todo Add more tests.
      end

      context 'when the cursor is not visible' do
        # @todo Add more tests.
      end
    end

    describe '.show_cursor' do
      subject { described_included.show_cursor }

      context 'when the cursor is visible' do
        # @todo Add more tests.
      end

      context 'when the cursor is not visible' do
        # @todo Add more tests.
      end
    end

    describe '.toggle_cursor' do
      subject { described_included.toggle_cursor }

      context 'when the cursor is visible' do
        # @todo Add more tests.
      end

      context 'when the cursor is not visible' do
        # @todo Add more tests.
      end
    end
  end # Toggleable

end # Vedeu
