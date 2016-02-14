# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_refresh_).must_equal(true) }
  end

  module Output

    describe Refresh do

      let(:described) { Vedeu::Output::Refresh }
      let(:instance)  { described.new }
      let(:_name)     { :vedeu_output_refresh }

      describe '.all' do
        before { Vedeu.stubs(:trigger) }

        subject { described.all }

        it { subject.must_be_instance_of(Array) }

        context 'when there are no registered interfaces' do
          before { Vedeu.interfaces.reset }

          it { subject.must_equal([]) }
        end

        context 'when there are registered interfaces' do
          let(:interface)  {
            Vedeu::Interfaces::Interface.new(name: _name)
          }
          let(:names) { [_name] }

          before { Vedeu.interfaces.stubs(:zindexed).returns(names) }

          it do
            Vedeu.expects(:trigger).with(:_refresh_view_, _name)
            subject
          end

          it { subject.must_equal(names) }
        end
      end

      describe '#all' do
        it { instance.must_respond_to(:all) }
      end

    end # Refresh

  end # Output

end # Vedeu
