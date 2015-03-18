require 'test_helper'

module Vedeu

  module Distributed

    describe Server do

      let(:described)     { Vedeu::Distributed::Server }
      let(:instance)      { described.instance }
      let(:configuration) {}

      describe 'alias_methods' do
        it { instance.must_respond_to(:read) }
        it { instance.must_respond_to(:write) }
      end

      describe '.input' do
        let(:data) {}

        subject { described.input(data) }

        it { Vedeu.expects(:trigger); subject }
      end

      describe '.output' do
        subject { described.output }

        it { Vedeu.expects(:trigger); subject }
      end

      describe '#pid' do
        before { Process.stubs(:pid).returns(9876) }

        subject { instance.pid }

        it { subject.must_be_instance_of(Fixnum) }
        it { subject.must_equal(9876) }
      end

      describe '.restart' do
        subject { described.restart }
      end

      describe '.shutdown' do
        subject { described.shutdown }
      end

      describe '.start' do
        subject { described.start }
      end

      describe '.status' do
        subject { described.status }
      end

      describe '.stop' do
        subject { described.stop }
      end

    end # Server

  end # Distributed

end # Vedeu
