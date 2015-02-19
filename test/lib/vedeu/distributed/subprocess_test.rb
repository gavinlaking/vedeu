require 'test_helper'

module Vedeu

  describe Subprocess do

    let(:described) { Vedeu::Subprocess }
    let(:instance)  { described.new() }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Vedeu::Subprocess) }
      it { skip }
    end

  end # Subprocess

end # Vedeu
