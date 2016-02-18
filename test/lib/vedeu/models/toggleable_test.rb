# frozen_string_literal: true

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

  end # ToggleableTestClass

  describe Toggleable do

    let(:described)          { Vedeu::Toggleable }
    let(:included_described) { Vedeu::ToggleableTestClass }
    let(:included_instance)  { included_described.new(visible) }
    let(:visible)            { false }

    describe '#visible' do
      it { included_instance.must_respond_to(:visible) }
    end

    describe '#visible=' do
      it { included_instance.must_respond_to(:visible=) }
    end

    describe '#visible?' do
      it { included_instance.must_respond_to(:visible?) }
    end

    describe '#hide' do
      subject { included_instance.hide }

      it do
        subject
        included_instance.instance_variable_get('@visible').must_equal(false)
      end

      it { included_described.must_respond_to(:hide_cursor) }
      it { included_described.must_respond_to(:hide_group) }
      it { included_described.must_respond_to(:hide_interface) }
    end

    describe '#show' do
      subject { included_instance.show }

      it do
        subject
        included_instance.instance_variable_get('@visible').must_equal(true)
      end

      it { included_described.must_respond_to(:show_cursor) }
      it { included_described.must_respond_to(:show_group) }
      it { included_described.must_respond_to(:show_interface) }
    end

    describe '#toggle' do
      subject { included_instance.toggle }

      it { included_described.must_respond_to(:toggle_cursor) }
      it { included_described.must_respond_to(:toggle_group) }
      it { included_described.must_respond_to(:toggle_interface) }

      context 'when the model is visible' do
        let(:visible) { true }

        it do
          subject
          included_instance.instance_variable_get('@visible').must_equal(false)
        end
      end

      context 'when the model is not visible' do
        it do
          subject
          included_instance.instance_variable_get('@visible').must_equal(true)
        end
      end
    end

    describe '.hide_cursor' do
      subject { included_described.hide_cursor }

      context 'when the cursor is visible' do
        # @todo Add more tests.
      end

      context 'when the cursor is not visible' do
        # @todo Add more tests.
      end
    end

    describe '.included' do
      subject { described.included(included_described) }

      it { subject.must_be_instance_of(Class) }
    end

    describe '.show_cursor' do
      subject { included_described.show_cursor }

      context 'when the cursor is visible' do
        # @todo Add more tests.
      end

      context 'when the cursor is not visible' do
        # @todo Add more tests.
      end
    end

    describe '.toggle_cursor' do
      subject { included_described.toggle_cursor }

      context 'when the cursor is visible' do
        # @todo Add more tests.
      end

      context 'when the cursor is not visible' do
        # @todo Add more tests.
      end
    end
  end # Toggleable

end # Vedeu
