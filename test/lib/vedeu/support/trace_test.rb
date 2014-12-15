require 'test_helper'

module Vedeu

  describe Trace do

    let(:described) { Trace.new(options) }
    let(:options)   { {} }

    describe '.call' do
      it { skip }
    end

    describe '#initialize' do
      it { return_type_for(described, Trace) }
      it { assigns(described, '@options', options) }
    end

    describe '#trace' do
      it { skip }
    end

  end # Trace

end # Vedeu
