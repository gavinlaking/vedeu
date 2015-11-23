require 'test_helper'

module Vedeu

  module Input

    describe Raw do

      let(:described) { Vedeu::Input::Raw }
      let(:instance)  { described.new }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
      end

      describe '.read' do
        let(:keypress) { 'a' }

        before do
          Vedeu::Terminal.console.stubs(:getch).returns(keypress)
        end

        subject { described.read }

        it { subject.must_equal(keypress) }
      end

      describe '#read' do
        it { instance.must_respond_to(:read) }
      end

    end # Raw

  end # Input

end # Vedeu
