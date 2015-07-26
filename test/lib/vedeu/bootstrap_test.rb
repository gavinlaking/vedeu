require 'test_helper'

module YourApp

  class SomeController
  end # SomeController

end # YourApp

module Vedeu

  describe Bootstrap do

    let(:described)   { Vedeu::Bootstrap }
    let(:instance)    { described.new(argv, entry_point) }
    let(:argv)        { [] }
    let(:entry_point) { YourApp::SomeController.new }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@argv').must_equal(argv) }
      it do
        instance.instance_variable_get('@entry_point').must_equal(entry_point)
      end
    end

    describe '.start' do
      before { Vedeu::Launcher.stubs(:execute!) }

      subject { described.start(argv, entry_point) }

      it {
        Vedeu::Launcher.expects(:execute!)
        subject
      }

      context 'when the entry point is not set' do
        let(:entry_point) {}

        it 'tries to use the Configuration.root setting' do
          Vedeu::Configuration.expects(:root)
          subject
        end
      end
    end

    describe '#start' do
      it { instance.must_respond_to(:start) }
    end

  end # Bootstrap

end # Vedeu
