require_relative '../../test_helper'

module Vedeu
  describe Application do
    let(:described_class)    { Application }
    let(:described_instance) { described_class.new(options) }
    let(:options)            { {} }

    it { described_instance.must_be_instance_of(Application) }

    describe '.start' do
      subject { described_class.start(options) }

      it { skip }
    end
  end
end
