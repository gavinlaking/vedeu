require 'test_helper'

module Vedeu

  describe Interface do

    let(:described)  { Vedeu::Interface }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        client:  client,
        colour:  colour,
        delay:   delay,
        group:   group,
        name:    _name,
        parent:  parent,
        style:   style,
        visible: visible,
        zindex:  zindex,
      }
    }
    let(:client)     {}
    let(:colour)     {}
    let(:delay)      { 0.0 }
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
      it { subject.instance_variable_get('@group').must_equal(group) }
      it { subject.instance_variable_get('@name').must_equal(_name) }
      it { subject.instance_variable_get('@parent').must_equal(parent) }
      it { subject.instance_variable_get('@repository').must_equal(repository) }
      it { subject.instance_variable_get('@visible').must_equal(visible) }
      it { subject.instance_variable_get('@zindex').must_equal(zindex) }
    end

    describe 'accessors' do
      it { instance.must_respond_to(:client) }
      it { instance.must_respond_to(:client=) }
      it { instance.must_respond_to(:delay) }
      it { instance.must_respond_to(:delay=) }
      it { instance.must_respond_to(:group) }
      it { instance.must_respond_to(:group=) }
      it { instance.must_respond_to(:name) }
      it { instance.must_respond_to(:name=) }
      it { instance.must_respond_to(:parent) }
      it { instance.must_respond_to(:parent=) }
      it { instance.must_respond_to(:zindex) }
      it { instance.must_respond_to(:zindex=) }
      it { instance.must_respond_to(:visible) }
      it { instance.must_respond_to(:visible=) }
      it { instance.must_respond_to(:visible?) }
      it { instance.must_respond_to(:attributes) }
    end

    describe '#hide' do
      let(:buffer) { Vedeu::Buffer.new }

      before { Vedeu.buffers.stubs(:by_name).returns(buffer) }

      subject { instance.hide }

      it {
        Vedeu.buffers.by_name('hydrogen').expects(:hide)
        subject
      }
    end

    describe '#show' do
      let(:buffer) { Vedeu::Buffer.new }

      before { Vedeu.buffers.stubs(:by_name).returns(buffer) }

      subject { instance.show }

      it {
        Vedeu.buffers.by_name('hydrogen').expects(:show)
        subject
      }
    end

  end # Interface

end # Vedeu
