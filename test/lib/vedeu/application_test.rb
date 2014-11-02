require 'test_helper'

module Vedeu

  describe Application do

    before { Terminal.stubs(:open).returns(['']) }

    describe '.start' do
      it 'returns an Array' do
        Application.start.must_be_instance_of(Array)
      end

      context 'alias method: .restart' do
        it 'returns an Array' do
          Application.restart.must_be_instance_of(Array)
        end
      end
    end

    describe '.stop' do
      it 'raises an exception' do
        proc { Application.stop }.must_raise(StopIteration)
      end
    end

    describe '#initialize' do
      it 'returns an Application' do
        Application.new.must_be_instance_of(Application)
      end
    end

    describe '#start' do
      it 'returns an Array' do
        Application.new.start.must_be_instance_of(Array)
      end
    end

  end # Application

end # Vedeu
