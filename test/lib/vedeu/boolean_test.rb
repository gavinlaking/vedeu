# frozen_string_literal: true

require 'test_helper'

module Vedeu

  describe Boolean do

    let(:described) { Vedeu::Boolean }
    let(:instance)  { described.new(_value) }
    let(:_value)    {}

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::Boolean) }
    end

    describe '.coerce' do
      subject { described.coerce(_value) }

      context 'when the value is falsy' do
        it { subject.must_equal(false) }
      end

      context 'when the value is truthy' do
        let(:_value) { 0 }

        it { subject.must_equal(true) }
      end
    end

    describe '#coerce' do
      it { instance.must_respond_to(:coerce) }
    end

    describe '#false?' do
      subject { instance.false? }

      context 'when the value is nil' do
        it { subject.must_equal(true) }
      end

      context 'when the value is false' do
        let(:_value) { false }

        it { subject.must_equal(true) }
      end

      context 'when the value is anything else' do
        let(:_value) { :anything }

        it { subject.must_equal(false) }
      end
    end

    describe '#true?' do
      subject { instance.true? }

      context 'when the value is nil' do
        it { subject.must_equal(false) }
      end

      context 'when the value is true' do
        let(:_value) { true }

        it { subject.must_equal(true) }
      end

      context 'when the value is anything else' do
        let(:_value) { :anything }

        it { subject.must_equal(true) }
      end
    end

  end # Boolean

end # Vedeu
