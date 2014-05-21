require_relative '../../test_helper'

module Vedeu
  describe Application do
    let(:described_class) { Application }
    let(:instance)        { described_class.new(interfaces, options) }
    let(:interfaces)      {}
    let(:options)         { {} }

    describe '#start' do
      before { Esc.stubs(:clear).returns('') }

      subject { instance.start }

      it { skip }
    end
  end
end
