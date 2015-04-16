require 'test_helper'

module Vedeu

  describe Interface do

    let(:described)  { Vedeu::Interface }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        client: client,
        name:   _name,
        lines:  lines,
        parent: parent,
        colour: colour,
        style:  style,
        visible: visible,
      }
    }
    let(:client)     {}
    let(:_name)      { 'hydrogen' }
    let(:lines)      { [] }
    let(:parent)     {}
    let(:colour)     {}
    let(:style)      {}
    let(:visible)    { true }
    let(:repository) { Vedeu.interfaces }

    describe '#initialize' do
      subject { instance }

      it { subject.instance_variable_get('@client').must_equal(client) }
      it { subject.instance_variable_get('@delay').must_equal(0.0) }
      it { subject.instance_variable_get('@group').must_equal('') }
      it { subject.instance_variable_get('@lines').must_equal(lines) }
      it { subject.instance_variable_get('@name').must_equal(_name) }
      it { subject.instance_variable_get('@parent').must_equal(parent) }
      it { subject.instance_variable_get('@repository').must_equal(repository) }
      it { subject.instance_variable_get('@visible').must_equal(visible) }
    end

    describe '#lines?' do
      subject { instance.lines? }

      context 'when the interface has content' do
        let(:lines) { [:line] }

        it { subject.must_equal(true) }
      end

      context 'when the interface does not have content' do
        it { subject.must_equal(false) }
      end
    end

    describe '#render' do
      subject { instance.render }

      it { subject.must_be_instance_of(Array) }

      context 'when the interface is visible' do
      end

      context 'when the interface is not visible' do
        let(:visible) { false }

        it { subject.must_equal([]) }
      end
    end

    describe '#store' do
      subject { instance.store }

      context 'when the interface has no name' do
        let(:_name) {}

        it { proc { subject }.must_raise(MissingRequired) }
      end
    end

  end # Interface

end # Vedeu
