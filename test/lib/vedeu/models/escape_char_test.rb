require 'test_helper'

module Vedeu

  describe EscapeChar do

    let(:described) { Vedeu::EscapeChar }
    let(:instance)  { described.new(_value) }
    let(:_value)    { "\e[?25h" }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@value').must_equal(_value) }
    end

    describe '#colour' do
      it { instance.colour.must_equal('') }
    end

    describe '#eql?' do
      let(:other) { instance }

      subject { instance.eql?(other) }

      it { subject.must_equal(true) }

      context 'when different to other' do
        let(:other) { described.new(value: 'b') }

        it { subject.must_equal(false) }
      end
    end

    describe '#inspect' do
      it { instance.inspect.must_equal(
        "<Vedeu::EscapeChar '" \
        "\\e[?25h"       \
        "'>"
      ) }
    end

    describe '#position' do
      it { instance.position.must_equal('') }
    end

    describe '#style' do
      it { instance.style.must_equal('') }
    end

    describe '#to_s' do
      it { instance.to_s.must_be_instance_of(String) }
    end

  end # EscapeChar

end # Vedeu
