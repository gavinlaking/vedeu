require_relative '../../test_helper'

module Vedeu
  describe Application do
    let(:klass)    { Application }
    let(:instance) { klass.new }

    describe '#main' do
      subject { instance.main }

      it { skip }
    end
  end
end
