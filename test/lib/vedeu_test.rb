require_relative '../test_helper'
require_relative '../../lib/vedeu'

describe Vedeu do
  let(:described_class) { Vedeu }

  describe '.logger' do
    let(:subject) { described_class.logger }

    it { subject.must_be_instance_of(Logger) }
  end
end
