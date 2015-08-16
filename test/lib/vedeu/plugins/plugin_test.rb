require 'test_helper'

module Vedeu

  describe Plugin do

    let(:described) { Vedeu::Plugin }
    let(:instance)  { described.new(_name, _gem) }
    let(:_name)     {}
    let(:_gem)      {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
      it { instance.instance_variable_get('@gem').must_equal(_gem) }
      it {
        instance.instance_variable_get('@gem_name').
          must_equal("vedeu_#{_name}")
      }
      it { instance.instance_variable_get('@enabled').must_equal(false) }
    end

    describe 'accessors' do
      it { instance.must_respond_to(:name) }
      it { instance.must_respond_to(:gem) }
      it { instance.must_respond_to(:gem_name) }
      it { instance.must_respond_to(:enabled) }
      it { instance.must_respond_to(:enabled=) }
      it { instance.must_respond_to(:enabled?) }
    end

    describe '#load!' do
      subject { instance.load! }

      context 'when the plugin gem cannot be loaded' do
        before do
          Kernel.stubs(:require).raises(LoadError)
        end

        it { proc { subject }.must_raise(Vedeu::VedeuError) }
        it { instance.enabled.must_equal(false) }
      end

      # @todo Add more tests.
      # it { skip }
    end

  end # Plugin

end # Vedeu
