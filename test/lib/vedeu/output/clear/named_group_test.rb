require 'test_helper'

module Vedeu

  module Clear

    describe NamedGroup do

      let(:described) { Vedeu::Clear::NamedGroup }
      let(:instance)  { described.new(_name) }
      let(:_name)     { 'Vedeu::Clear::NamedGroup' }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
      end

      describe '.render' do
        let(:group) { Vedeu::Models::Group.new(members: [_name]) }

        before { Vedeu.groups.stubs(:by_name).returns(group) }

        subject { described.render(_name) }

        it {
          Vedeu::Clear::NamedInterface.expects(:render).with(_name)
          subject
        }

        it { described.must_respond_to(:by_group) }
        it { described.must_respond_to(:clear_by_group) }
      end

      describe '#render' do
        it { instance.must_respond_to(:render) }
      end

    end # NamedGroup

  end # Clear

end # Vedeu
