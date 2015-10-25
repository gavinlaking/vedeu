require 'test_helper'

module Vedeu

  module Interfaces

    describe Interface do

      let(:described)  { Vedeu::Interfaces::Interface }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          client:   client,
          colour:   colour,
          delay:    delay,
          editable: editable,
          group:    group,
          name:     _name,
          parent:   parent,
          style:    style,
          visible:  visible,
          zindex:   zindex,
        }
      }
      let(:client)     {}
      let(:colour)     {}
      let(:delay)      { 0.0 }
      let(:editable)   { false }
      let(:group)      { '' }
      let(:_name)      { 'hydrogen' }
      let(:parent)     {}
      let(:repository) { Vedeu.interfaces }
      let(:style)      {}
      let(:visible)    { true }
      let(:zindex)     { 1 }

      describe '#initialize' do
        subject { instance }

        it { subject.must_be_instance_of(described) }
        it { subject.instance_variable_get('@client').must_equal(client) }
        it { subject.instance_variable_get('@delay').must_equal(delay) }
        it { subject.instance_variable_get('@editable').must_equal(editable) }
        it { subject.instance_variable_get('@group').must_equal(group) }
        it { subject.instance_variable_get('@name').must_equal(_name) }
        it { subject.instance_variable_get('@parent').must_equal(parent) }
        it {
          subject.instance_variable_get('@repository').must_equal(repository)
        }
        it { subject.instance_variable_get('@visible').must_equal(visible) }
        it { subject.instance_variable_get('@zindex').must_equal(zindex) }
      end

      describe 'accessors' do
        it {
          instance.must_respond_to(:client)
          instance.must_respond_to(:client=)
          instance.must_respond_to(:delay)
          instance.must_respond_to(:delay=)
          instance.must_respond_to(:editable)
          instance.must_respond_to(:editable=)
          instance.must_respond_to(:editable?)
          instance.must_respond_to(:group)
          instance.must_respond_to(:group=)
          instance.must_respond_to(:name)
          instance.must_respond_to(:name=)
          instance.must_respond_to(:parent)
          instance.must_respond_to(:parent=)
          instance.must_respond_to(:zindex)
          instance.must_respond_to(:zindex=)
          instance.must_respond_to(:visible)
          instance.must_respond_to(:visible=)
          instance.must_respond_to(:visible?)
          instance.must_respond_to(:attributes)
        }
      end

      describe '#hide' do
        before { Vedeu.stubs(:trigger) }

        subject { instance.hide }

        it {
          Vedeu.expects(:trigger).with(:_clear_view_, _name)
          subject
        }
      end

      describe '#show' do
        before { Vedeu.stubs(:trigger) }

        subject { instance.show }

        it {
          Vedeu.expects(:trigger).with(:_refresh_view_, _name)
          subject
        }
      end

    end # Interface

  end # Interfaces

  describe 'Bindings' do
    it { Vedeu.bound?(:_hide_interface_).must_equal(true) }
    it { Vedeu.bound?(:_show_interface_).must_equal(true) }
    it { Vedeu.bound?(:_toggle_interface_).must_equal(true) }
    # it { Vedeu.bound?(:_hide_view_).must_equal(true) }
    # it { Vedeu.bound?(:_show_view_).must_equal(true) }
    # it { Vedeu.bound?(:_toggle_view_).must_equal(true) }
  end

end # Vedeu
