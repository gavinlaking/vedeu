require 'test_helper'

module Vedeu

  describe Interface do

    let(:described) { Vedeu::Interface }
    let(:instance)  { described.new(_name, lines, parent, colour, style) }
    let(:_name)     { 'hydrogen' }
    let(:lines)     { [] }
    let(:parent)    {}
    let(:colour)    {}
    let(:style)     {}

    describe '#initialize' do
      subject { instance }

      it { subject.instance_variable_get('@name').must_equal(_name) }
      it { subject.instance_variable_get('@lines').must_be_instance_of(Vedeu::Model::Lines) }
      it { subject.instance_variable_get('@parent').must_equal(parent) }
      it { subject.instance_variable_get('@colour').must_equal(colour) }
      it { subject.instance_variable_get('@style').must_equal(style) }
      it { subject.instance_variable_get('@border').must_equal(nil) }
      it { subject.instance_variable_get('@delay').must_equal(0.0) }
      it { subject.instance_variable_get('@geometry').must_equal(nil) }
      it { subject.instance_variable_get('@group').must_equal('') }
      it { subject.instance_variable_get('@repository').must_equal(Vedeu.interfaces) }
    end

    describe '#border?' do
      subject { instance.border? }

      context 'when the interface has a border' do
        before { instance.stubs(:border).returns(mock('Border')) }

        it { subject.must_equal(true) }
      end

      context 'when the interface does not have a border' do
        it { subject.must_equal(false) }
      end
    end

    describe '#content?' do
      subject { instance.content? }

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

    # TODO: when the interface does not have any geometry defined?
    # describe '#render' do
    #   subject { instance.render }

    #   context 'when the interface has a border' do
    #     let(:border) { Vedeu::Border.new(instance, { enabled: true }) }

    #     before { instance.stubs(:border).returns(border) }

    #     it { skip }
    #   end

    #   context 'when the interface does not have a border' do
    #     it { skip }
    #   end
    # end

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

    # TODO: when the interface does not have any geometry defined?
    describe '#viewport' do
      subject { instance.viewport }

      # it { skip }
    end

  end # Interface

end # Vedeu
