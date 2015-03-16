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
      it { instance.must_be_instance_of(Vedeu::Cell) }
      it { instance.instance_variable_get('@background').must_equal(background) }
      it { instance.instance_variable_get('@foreground').must_equal(foreground) }
      it { instance.instance_variable_get('@style').must_equal(style) }
      it { instance.instance_variable_get('@value').must_equal(value) }
      it { instance.instance_variable_get('@x').must_equal(x) }
      it { instance.instance_variable_get('@y').must_equal(y) }
    end

    describe '#==' do
      let(:other) { instance }

      subject { instance.==(other) }

      it { subject.must_equal(true) }

      context 'when different to other' do
        let(:other) { described.new({}) }

        it { subject.must_equal(false) }
      end
    end

    describe '#eql?' do
      let(:other) { instance }

      subject { instance.eql?(other) }

      it { subject.must_equal(true) }

      context 'when different to other' do
        let(:other) { described.new({}) }

        it { subject.must_equal(false) }
      end
    end

  end # Cell

end # Vedeu
