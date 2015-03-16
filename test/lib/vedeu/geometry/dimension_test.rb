require 'test_helper'

module Vedeu

  describe Dimension do

    let(:described)  { Vedeu::Dimension }
    let(:instance)   { described.new(attributes) }
    let(:attributes) {
      {
        d:       d,
        dn:      dn,
        d_dn:    d_dn,
        default: default
      }
    }
    let(:d)       {}
    let(:dn)      {}
    let(:d_dn)    {}
    let(:default) {}

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Dimension) }
      it { instance.instance_variable_get('@d').must_equal(d) }
      it { instance.instance_variable_get('@dn').must_equal(dn) }
      it { instance.instance_variable_get('@d_dn').must_equal(d_dn) }
      it { instance.instance_variable_get('@default').must_equal(default) }
    end

    describe '.pair' do
      let(:d)  { 5 }
      let(:dn) { 8 }

      subject { described.pair(attributes) }

      it { subject.must_be_instance_of(Array) }
      it { subject.must_equal([5, 8]) }
    end

    describe '#d1' do
      subject { instance.d1 }

      it { subject.must_be_instance_of(Fixnum) }

      context 'when d is given' do
        let(:d) { 5 }

        it { subject.must_equal(5) }
      end

      context 'when d is not given' do
        it { subject.must_equal(1) }
      end
    end

    describe '#d2' do
      subject { instance.d2 }

      context 'when d and dn is given' do
        let(:d)  { 5 }
        let(:dn) { 8 }

        it { subject.must_equal(8) }
      end

      context 'when d and d_dn is given' do
        let(:d)    { 5 }
        let(:d_dn) { 2 }

        it { subject.must_equal(7) }
      end

      context 'when only d_dn is given' do
        let(:d_dn) { 6 }

        it { subject.must_equal(6) }
      end

      context 'when d and a default is given' do
        let(:d)       { 1 }
        let(:default) { 40 }

        it { subject.must_equal(40) }
      end

      context 'when only a default is given' do
        let(:default) { 25 }

        it { subject.must_equal(25) }
      end

      context 'when no default is given' do
        it { subject.must_equal(nil) }
      end
    end

  end # Dimension

end # Vedeu
