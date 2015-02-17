require 'test_helper'

module Vedeu

  describe Interface do

    let(:described)  { Vedeu::Interface }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        name:   _name,
        lines:  lines,
        parent: parent,
        colour: colour,
        style:  style,
      }
    }
    let(:_name)      { 'hydrogen' }
    let(:lines)      { [] }
    let(:parent)     {}
    let(:colour)     {}
    let(:style)      {}

    describe '#initialize' do
      subject { instance }

      it { subject.instance_variable_get('@name').must_equal(_name) }
      it { subject.instance_variable_get('@lines').must_equal(lines) }
      it { subject.instance_variable_get('@parent').must_equal(parent) }
      it { subject.instance_variable_get('@colour').must_be_instance_of(Vedeu::Colour) }
      it { subject.instance_variable_get('@style').must_be_instance_of(Vedeu::Style) }
      it { subject.instance_variable_get('@border').must_equal(nil) }
      it { subject.instance_variable_get('@delay').must_equal(0.0) }
      it { subject.instance_variable_get('@geometry').must_equal(nil) }
      it { subject.instance_variable_get('@group').must_equal('') }
      it { subject.instance_variable_get('@repository').must_equal(Vedeu.interfaces) }
    end

    describe '#border?' do
      subject { instance.border? }

      context 'when the interface has a border' do
        before { Vedeu.borders.stubs(:registered?).with(_name).returns(true) }

        it { subject.must_equal(true) }
      end

      context 'when the interface does not have a border' do
        it { subject.must_equal(false) }
      end
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

    describe '#cursor' do
      subject { instance.cursor }

      it { subject.must_be_instance_of(Vedeu::Cursor) }
    end

    describe '#inspect' do
      subject { instance.inspect }

      it { subject.must_equal('<Vedeu::Interface (lines:0)>') }
    end

    describe '#store' do
      subject { instance.store }

      context 'when the interface has no name' do
        let(:_name) {}

        it { proc { subject }.must_raise(MissingRequired) }
      end

      # context 'when the interface has a name' do
      #   context 'when a buffer exists' do
      #     it { skip }
      #   end

      #   context 'when a buffer does not exist' do
      #     it { skip }
      #   end

      #   context 'when a refresh event exists' do
      #     it { skip }
      #   end

      #   context 'when a refresh event does not exist' do
      #     it { skip }
      #   end

      #   context 'when the interface has a group' do
      #     it { skip }
      #   end
      # end
    end

  end # Interface

end # Vedeu
