require_relative '../../../test_helper'

module Vedeu
  describe Encoder do
    let(:klass) { Encoder }
    let(:key)   {}

    describe '.convert' do
      subject { klass.convert(key) }

      it { subject.must_be_instance_of(NilClass) }
    end
  end
end
