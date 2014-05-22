require_relative '../../test_helper'

module Vedeu
  describe Application do
    let(:described_class) { Application }
    let(:instance)        { described_class.new(options) }
    let(:options)         { {} }

    describe '.start' do
      subject { described_class.start(options) }

      it { skip }
    end
  end
end
