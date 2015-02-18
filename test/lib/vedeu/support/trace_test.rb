require 'test_helper'

module Vedeu

  describe Trace do

    let(:described) { Vedeu::Trace }
    let(:instance)  { described.new(options) }
    let(:options)   { {} }

    describe '#initialize' do
      it { instance.must_be_instance_of(Trace) }
      it { instance.instance_variable_get('@options').must_equal(options) }
    end

    describe '.call' do
      subject { described.call(options) }

      context 'when trace is enabled in the configuration' do
      end

      context 'when trace is disabled in the configuration' do
        context 'and not enabled via the options' do

        end
        context 'but enabled via the options' do
          let(:options) { { trace: true } }

        end
      end
    end

  end # Trace

end # Vedeu
