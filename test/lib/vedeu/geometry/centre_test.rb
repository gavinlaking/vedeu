require 'test_helper'

module Vedeu

  describe Centre do

    let(:described)  { Vedeu::Centre }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        v:     v,
        vn:    vn,
        value: value,
      }
    }
    let(:v)     { 2 }
    let(:vn)    { 47 }
    let(:value) { 30 }

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Centre) }
      it { instance.instance_variable_get('@v').must_equal(v) }
      it { instance.instance_variable_get('@vn').must_equal(vn) }
      it { instance.instance_variable_get('@value').must_equal(value) }
    end

    describe '#centre' do
      subject { instance.centre }

      it { subject.must_be_instance_of(Fixnum) }

      context 'when the value is given' do
        it { subject.must_equal(15) }
      end

      context 'when the value is not given' do
        let(:value) {}

        it { subject.must_equal(24) }

        context 'when either v or vn is missing' do
          let(:vn) {}

          it { proc { subject }.must_raise(InvalidSyntax) }
        end

        context 'when vn < v' do
          let(:vn) { 15 }
          let(:v)  { 32 }

          it { proc { subject }.must_raise(InvalidSyntax) }
        end
      end
    end

  end # Centre

end # Vedeu
