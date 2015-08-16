require 'test_helper'

module YourApp

  class SomeController
  end # SomeController

end # YourApp

module Vedeu

  describe Bootstrap do

    let(:described)   { Vedeu::Bootstrap }
    let(:instance)    { described.new(argv) }
    let(:argv)        { [] }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@argv').must_equal(argv) }
    end

    describe '.start' do
      before do
        Vedeu::Configuration.stubs(:root).returns([:controller, :action, :args])
        Vedeu.stubs(:trigger)
        Vedeu::Launcher.stubs(:execute!)
      end

      subject { described.start(argv) }

      it {
        Vedeu::Launcher.expects(:execute!)
        subject
      }
    end

    describe '#start' do
      it { instance.must_respond_to(:start) }
    end

  end # Bootstrap

end # Vedeu
