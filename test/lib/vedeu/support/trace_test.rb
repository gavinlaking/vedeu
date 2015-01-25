require 'test_helper'

module Vedeu

  describe Trace do

    let(:described) { Vedeu::Trace }
    let(:instance)  { described.new(options) }
    let(:options)   { {} }

    describe '#initialize' do
      subject { instance }

      it { return_type_for(subject, Trace) }
      it { subject.instance_variable_get('@options').must_equal(options) }
    end

  end # Trace

end # Vedeu
