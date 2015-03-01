require 'test_helper'

module Vedeu

  describe Limit do

    let(:described) { Vedeu::Limit }
    let(:instance)  { described.new(v, vn, max, min) }
    let(:v)         {}
    let(:vn)        {}
    let(:max)       {}
    let(:min)       { 2 }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Limit) }
      it { instance.instance_variable_get('@v').must_equal(v) }
      it { instance.instance_variable_get('@vn').must_equal(vn) }
      it { instance.instance_variable_get('@max').must_equal(max) }
      it { instance.instance_variable_get('@min').must_equal(min) }

      context 'when min is nil' do
        let(:min) {}

        it { instance.instance_variable_get('@min').must_equal(1) }
      end
    end

  end # Limit

end # Vedeu
