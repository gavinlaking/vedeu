require 'test_helper'

module Vedeu

  describe TestApplication do

    let(:described) { Vedeu::TestApplication }
    let(:instance)  { described.new() }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Vedeu::TestApplication) }
      it { skip }
    end

  end # TestApplication

end # Vedeu
