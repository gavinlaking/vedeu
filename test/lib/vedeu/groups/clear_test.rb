require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_clear_group_).must_equal(true) }
  end

  module Groups

    describe Clear do

      let(:described) { Vedeu::Groups::Clear }
      let(:instance)  { described.new(_name) }
      let(:_name)     { 'Vedeu::Groups::Clear' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.render' do
        let(:group) { Vedeu::Groups::Group.new(members: [_name]) }

        before { Vedeu.groups.stubs(:by_name).returns(group) }

        subject { described.render(_name) }

        it {
          Vedeu.expects(:trigger).with(:_clear_view_, _name)
          subject
        }

        it { described.must_respond_to(:by_group) }
        it { described.must_respond_to(:clear_by_group) }
      end

      describe '#render' do
        it { instance.must_respond_to(:render) }
      end

    end # Clear

  end # Groups

end # Vedeu
