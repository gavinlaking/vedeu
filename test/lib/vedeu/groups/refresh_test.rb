require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_refresh_group_).must_equal(true) }
  end

  module Groups

    describe Refresh do

      let(:described) { Vedeu::Groups::Refresh }
      let(:instance)  { described.new(_name) }
      let(:_name)     { 'Vedeu::Groups::Refresh' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.by_name' do
        subject { described.by_name(_name) }

        context 'when the name is not present' do
          let(:_name) { '' }

          it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
        end

        context 'when the name is present' do
          # it {
          #   Vedeu.expects(:trigger).with(:_refresh_view_)
          #   subject
          # }
        end
      end

      describe '#by_name' do
        it { instance.must_respond_to(:by_name) }
      end

    end # Refresh

  end # Groups

end # Vedeu
