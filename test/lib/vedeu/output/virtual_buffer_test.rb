require 'test_helper'

module Vedeu

  describe VirtualBuffer do

    let(:described) { Vedeu::VirtualBuffer }

    describe '#retrieve' do
      subject { described.retrieve }
    end

    describe '#store' do
      subject { described.store }
    end

    describe '#size' do
      subject { described.size }
    end

    describe '#clear' do
      subject { described.clear }

      it { described.must_respond_to(:reset) }
    end

  end # VirtualBuffer

end # Vedeu
