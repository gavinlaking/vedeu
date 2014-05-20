require_relative '../../test_helper'

module Vedeu
  describe Application do
    let(:described_class){ Application }
    let(:instance)   { described_class.new(interfaces, options) }
    let(:interfaces) {}
    let(:options)    { {} }

    describe '#start' do
      before { Esc.stubs(:clear).returns('') }

      subject { instance.start }

      it { skip }

      context 'when the user sets the clear option' do
        # subject { described_class.clear_screen }

        # it { subject.must_be_instance_of(NilClass) }

        # context 'capturing output' do
        #   let(:io) { capture_io { subject }.join }

        #   it { io.must_be_instance_of(String) }
        # end
      end

      context 'when the user unsets the clear option' do

      end
    end
  end
end
