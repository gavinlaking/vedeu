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
        visible: visible,
      }
    }
    let(:_name)      { 'hydrogen' }
    let(:lines)      { [] }
    let(:parent)     {}
    let(:colour)     {}
    let(:style)      {}
    let(:visible)    {}

    describe '#initialize' do
      it { instance.instance_variable_get('@name').must_equal(_name) }
      it { instance.instance_variable_get('@lines').must_equal(lines) }
      it { instance.instance_variable_get('@parent').must_equal(parent) }
      it { instance.instance_variable_get('@colour').must_equal(colour) }
      it { instance.instance_variable_get('@style').must_equal(style) }
      it { instance.instance_variable_get('@visible').must_equal(visible) }
      it { instance.instance_variable_get('@border').must_equal(nil) }
      it { instance.instance_variable_get('@delay').must_equal(0.0) }
      it { instance.instance_variable_get('@geometry').must_equal(nil) }
      it { instance.instance_variable_get('@group').must_equal('') }
      it { instance.instance_variable_get('@repository').must_equal(Vedeu.interfaces) }
    end

    describe '#attributes' do
      subject { instance.attributes }

      it { subject.must_be_instance_of(Hash) }

      it { subject.must_equal({ colour: Vedeu::Colour.coerce(colour),
                                delay:  0.0,
                                group:  '',
                                name:   'hydrogen',
                                parent: nil,
                                style:  Vedeu::Style.coerce(style),
                                visible: true }) }
    end

    describe '#border?' do
      subject { instance.border? }

      context 'when the interface has a border' do
        before { Vedeu.border('hydrogen') { } }
        after  { Vedeu.borders.reset }

        it { subject.must_equal(true) }
      end

      context 'when the interface does not have a border' do
        before { Vedeu.borders.reset }

        it { subject.must_equal(false) }
      end
    end

    describe '#border' do
      subject { instance.border }

      context 'when the interface has a border' do
        before { Vedeu.border('hydrogen') { } }
        after  { Vedeu.borders.reset }

        it { subject.must_be_instance_of(Vedeu::Border) }
      end

      context 'when the interface does not have a border' do
        before { Vedeu.borders.reset }

        it { subject.must_be_instance_of(Vedeu::NullBorder) }
      end
    end

    describe '#clear' do
      subject { instance.clear }

      it {
        Vedeu::Clear.expects(:new).with(instance)
        subject
      }
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

    describe '#render' do
      subject { instance.render }
    end

    describe '#store' do
      subject { instance.store }

      context 'when the interface has no name' do
        let(:_name) {}

        it { proc { subject }.must_raise(MissingRequired) }
      end
    end

    describe '#viewport' do
      subject { instance.viewport }

      it {
        Vedeu::Viewport.expects(:new).with(instance)
        subject
      }
    end

  end # Interface

end # Vedeu
