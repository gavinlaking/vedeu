require 'test_helper'

module Vedeu

  describe Trace do

    let(:described) { Trace.new(options) }
    let(:options)   { {} }

    describe '#initialize' do
      it { return_type_for(described, Trace) }
      it { assigns(described, '@options', options) }
    end

  end # Trace

end # Vedeu
