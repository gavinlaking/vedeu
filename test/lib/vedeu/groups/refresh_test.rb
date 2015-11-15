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
        let(:interface) {
          Vedeu::Interfaces::Interface.new(name: _name, group: group)
        }
        let(:group) { :vedeu_groups_refresh_group }

        subject { described.by_name(_name) }

        context 'when the name is not present' do
          let(:_name) { '' }

          context 'when the currently focussed interface/view has a group' do
            before { Vedeu.interfaces.stubs(:by_name).returns(interface) }

            # @todo Add more tests.
            # it { skip }
          end

          context 'when the currently focussed interface/view does not have ' \
                  'a group' do
            let(:group) { '' }

            before { Vedeu.interfaces.stubs(:by_name).returns(interface) }

            it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
          end

          context 'when no interfaces/views have been registered' do
            before { Vedeu::Models::Focus.reset }

            it { proc { subject }.must_raise(Vedeu::Error::MissingRequired) }
          end
        end

        context 'when the name is present' do
          # @todo Add more tests.
          # it { skip }

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
