require_relative '../test_helper'
require_relative '../../lib/vedeu'

describe Vedeu do
  describe '.logger' do
    def subject
      Vedeu.logger
    end

    it { subject.must_be_instance_of(Logger) }
  end
end
