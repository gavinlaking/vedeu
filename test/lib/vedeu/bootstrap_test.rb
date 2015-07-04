require 'test_helper'

module Vedeu

  describe Bootstrap do

    let(:described)   { Vedeu::Bootstrap }
    let(:instance)    { described.new(argv, entry_point) }
    let(:argv)        { [] }
    let(:entry_point) {}

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@argv').must_equal(argv) }
      it do
        instance.instance_variable_get('@entry_point').must_equal(entry_point)
      end
    end

    describe '.start' do
      it { described.must_respond_to(:start) }
    end

    describe '#start' do
      subject { instance.start }

      it {
        Vedeu::Launcher.expects(:execute!)
        subject
      }
    end

  end # Bootstrap

end # Vedeu
