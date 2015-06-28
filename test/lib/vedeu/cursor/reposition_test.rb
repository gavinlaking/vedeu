require 'test_helper'

module Vedeu

  describe Reposition do

    let(:described) { Vedeu::Reposition }
    let(:instance)  { described.new(entity, _name, y, x) }
    let(:entity)    { Vedeu::Cursor }
    let(:_name)     { 'reposition' }
    let(:x)         { 4 }
    let(:y)         { 7 }

    before do
      Vedeu::Cursor.new(name: _name, x: 1, y: 1, ox: 1, oy: 1)
      Vedeu.stubs(:trigger)
    end

    after { Vedeu.cursors.reset }

    describe '#initialize' do
      subject { instance }

      it { instance.must_be_instance_of(Vedeu::Reposition) }
      it { instance.instance_variable_get('@entity').must_equal(entity) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
      it { instance.instance_variable_get('@x').must_equal(x) }
      it { instance.instance_variable_get('@y').must_equal(y) }
    end

    describe '.to' do
      it { described.must_respond_to(:to) }
    end

    describe '#to' do
      subject { instance.to }

      it { subject.must_be_instance_of(entity) }
      it { subject.x.must_equal(5) }
      it { subject.y.must_equal(8) }
      it { subject.ox.must_equal(4) }
      it { subject.oy.must_equal(7) }
    end

  end # Reposition

end # Vedeu
