require 'test_helper'

module Vedeu

  describe Streams do

    let(:described) { Vedeu::Streams }
    let(:instance)  { described.new }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Vedeu::Streams) }
    end

  end # Streams

end # Vedeu
