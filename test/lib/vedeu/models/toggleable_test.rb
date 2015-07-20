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

    let(:described) { Vedeu::Toggleable }
    let(:instance) { Vedeu::ToggleableTestClass.new(visible) }
    let(:visible) { false }

    describe 'accessors' do
      it { instance.must_respond_to(:visible) }
      it { instance.must_respond_to(:visible=) }
      it { instance.must_respond_to(:visible?) }
    end

    describe '#hide' do
      subject { instance.hide }

      it {
        subject
        instance.instance_variable_get('@visible').must_equal(false)
      }
    end

    describe '#show' do
      subject { instance.show }

      it {
        subject
        instance.instance_variable_get('@visible').must_equal(true)
      }
    end

    describe '#toggle' do
      subject { instance.toggle }

      context 'when the model is visible' do
        let(:visible) { true }

        it {
          subject
          instance.instance_variable_get('@visible').must_equal(false)
        }
      end

      context 'when the model is not visible' do
        it {
          subject
          instance.instance_variable_get('@visible').must_equal(true)
        }
      end
    end

  end # Toggleable

end # Vedeu
