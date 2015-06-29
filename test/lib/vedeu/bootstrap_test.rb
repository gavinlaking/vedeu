require 'test_helper'

module Vedeu

  describe Bootstrap do

    let(:described)   { Vedeu::Bootstrap }
    let(:instance)    { described.new(argv, entry_point) }
    let(:argv)        { [] }
    let(:entry_point) {}

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@argv').must_equal(argv) }
      it do
        subject.instance_variable_get('@entry_point').must_equal(entry_point)
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
