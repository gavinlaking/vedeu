require_relative '../../test_helper'

module Vedeu
  describe Application do
    let(:klass)      { Application }
    let(:instance)   { klass.new(interfaces, options) }
    let(:interfaces) {}
    let(:options)    { {} }

    describe '#start' do
      subject { instance.start }

      it { skip }
    end
  end
end
