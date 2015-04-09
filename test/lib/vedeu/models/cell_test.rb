require 'test_helper'

module Vedeu

  describe Cell do

    let(:described)  { Vedeu::Cell }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        background: background,
        foreground: foreground,
        style:      style,
        value:      value,
        x:          x,
        y:          y,
      }
    }
    let(:background) { '#000000' }
    let(:foreground) {}
    let(:style)      {}
    let(:value)      {}
    let(:x)          {}
    let(:y)          {}

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@background').must_equal(background) }
      it { subject.instance_variable_get('@foreground').must_equal(foreground) }
      it { subject.instance_variable_get('@style').must_equal(style) }
      it { subject.instance_variable_get('@value').must_equal(value) }
      it { subject.instance_variable_get('@x').must_equal(x) }
      it { subject.instance_variable_get('@y').must_equal(y) }
    end

    describe '#eql?' do
      let(:other) { described.new(background: '#000000') }

      subject { instance.eql?(other) }

      it { subject.must_equal(true) }

      context 'when different to other' do
        let(:other) { described.new({}) }

        it { subject.must_equal(false) }
      end
    end

  end # Cell

end # Vedeu
