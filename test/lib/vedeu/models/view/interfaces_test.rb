require 'test_helper'

module Vedeu

  describe Interfaces do

    let(:described) { Vedeu::Interfaces }
    let(:instance)  { described.new }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Vedeu::Interfaces) }
    end

  end # Interfaces

end # Vedeu
