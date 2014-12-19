require 'test_helper'

module Vedeu

  describe Application do

    let(:described) { Application.new }

    before { Terminal.stubs(:open).returns(['']) }

    describe '.start' do
      it { return_type_for(Application.start, Array) }

      context 'alias method: .restart' do
        it { return_type_for(Application.restart, Array) }
      end
    end

    describe '.stop' do
      it { proc { Application.stop }.must_raise(StopIteration) }
    end

    describe '#initialize' do
      it { return_type_for(described, Application) }
    end

    describe '#start' do
      it { return_type_for(described.start, Array) }
    end

  end # Application

end # Vedeu
