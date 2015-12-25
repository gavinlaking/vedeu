# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe 'Bindings' do
    it { Vedeu.bound?(:_hide_group_).must_equal(true) }
    it { Vedeu.bound?(:_show_group_).must_equal(true) }
    it { Vedeu.bound?(:_toggle_group_).must_equal(true) }
  end

  module Groups

    describe Group do

      let(:described)  { Vedeu::Groups::Group }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          name:       _name,
          members:    members,
          repository: repository,
          visible:    visible,
        }
      }
      let(:_name)      { 'organics' }
      let(:members)    { Set.new(['carbon', 'nitrogen', 'oxygen']) }
      let(:repository) { Vedeu.groups }
      let(:visible)    { true }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@members').must_equal(members) }
        it { instance.instance_variable_get('@name').must_equal(_name) }
        it do
          instance.instance_variable_get('@repository').must_equal(repository)
        end
        it { instance.instance_variable_get('@visible').must_equal(visible) }
      end

      describe '#name' do
        it { instance.must_respond_to(:name) }
      end

      describe '#name=' do
        it { instance.must_respond_to(:name=) }
      end

      describe '#visible' do
        it { instance.must_respond_to(:visible) }
      end

      describe '#visible=' do
        it { instance.must_respond_to(:visible=) }
      end

      describe '#visible?' do
        it { instance.must_respond_to(:visible?) }
      end

      describe '#add' do
        subject { instance.add('hydrogen') }

        it { subject.must_be_instance_of(described) }

        context 'when the member already exists' do
          let(:members) { ['hydrogen', 'carbon', 'nitrogen', 'oxygen'] }

          it 'does not add the member again but returns a new Group' do
            subject.members.must_equal(Set.new(members))
          end
        end

        context 'when the member does not exist' do
          let(:members) { ['carbon', 'nitrogen', 'oxygen'] }

          it 'adds the member and returns a new Group' do
            subject.members.must_include('hydrogen')
          end
        end
      end

      describe '#by_zindex' do
        let(:interfaces) {
          [
            Vedeu::Interfaces::Interface.new(zindex: 3, name: 'c'),
            Vedeu::Interfaces::Interface.new(zindex: 1, name: 'a'),
            Vedeu::Interfaces::Interface.new(zindex: 2, name: 'b'),
          ]
        }

        before { instance.stubs(:interfaces).returns(interfaces) }

        subject { instance.by_zindex }

        it { subject.must_be_instance_of(Array) }
        it { subject.must_equal(['a', 'b', 'c']) }
      end

      describe '#deputy' do
        subject { instance.deputy }

        it 'returns the DSL instance' do
          subject.must_be_instance_of(Vedeu::Groups::DSL)
        end
      end

      describe '#hide' do
        subject { instance.hide }

        it { subject.must_equal(instance) }
      end

      describe '#members' do
        subject { instance.members }

        it { subject.must_be_instance_of(Set) }

        context 'when the group has no members' do
          let(:members) { [] }

          it 'returns an empty Set' do
            subject.must_be_empty
          end
        end

        context 'when the group has members' do
          it 'returns a set of members' do
            subject.wont_be_empty
          end
        end
      end

      describe '#remove' do
        let(:member) { 'hydrogen' }

        subject { instance.remove(member) }

        it { subject.must_be_instance_of(described) }

        context 'when the group is already empty' do
          let(:members) { [] }

          it { subject.members.must_equal(Set.new) }
        end

        context 'when the member exists' do
          let(:member) { 'oxygen' }

          it { subject.members.wont_include(member) }
        end

        context 'when the member does not exist' do
          it { subject.members.wont_include(member) }
        end
      end

      describe '#reset' do
        subject { instance.reset }

        it { subject.must_be_instance_of(described) }
        it { subject.members.must_be_empty }
      end

      describe '#show' do
        subject { instance.show }

        it { subject.must_equal(instance) }
      end

    end # Group

  end # Groups

end # Vedeu
