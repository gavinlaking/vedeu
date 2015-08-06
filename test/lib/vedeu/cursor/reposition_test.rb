require 'test_helper'

module Vedeu

  describe Reposition do

    let(:described) { Vedeu::Reposition }
    let(:instance)  { described.new(entity, _name, y, x) }
    let(:entity)    { Vedeu::Cursor }
    let(:_name)     { 'reposition' }
    let(:x)         { 4 }
    let(:y)         { 7 }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@entity').must_equal(entity) }
      it { instance.instance_variable_get('@name').must_equal(_name) }
      it { instance.instance_variable_get('@x').must_equal(x) }
      it { instance.instance_variable_get('@y').must_equal(y) }
    end

    describe '.to' do
      # let(:new_entity) { Vedeu::Cursor.new(name: _name, y: 8, x: 5, oy: 7, ox: 4) }

      before do
        #   entity.stubs(:new).returns(new_entity)
        Vedeu::Cursor.new(name: _name, x: 1, y: 1, ox: 1, oy: 1)
        Vedeu.stubs(:trigger)
      end
      after { Vedeu.cursors.reset }

      subject { described.to(entity, _name, y, x) }

      it { subject.must_be_instance_of(entity) }

      # it 'creates and stores a new entity' do
      #   entity.expects(:new).
      #     with(name: _name, y: 8, x: 5, oy: 7, ox: 4)

      #   subject
      # end

      # it 'refreshes the named interface to reflect the new position' do
      #   Vedeu.expects(:trigger).with(:_clear_, _name)
      #   Vedeu.expects(:trigger).with(:_refresh_, _name)
      #   Vedeu.expects(:trigger).with(:_refresh_cursor_, _name)

      #   subject
      # end

      it { subject.x.must_equal(5) }
      it { subject.y.must_equal(8) }
      it { subject.ox.must_equal(4) }
      it { subject.oy.must_equal(7) }
    end

    describe '#to' do
      it { instance.must_respond_to(:to) }
    end

  end # Reposition

end # Vedeu
