# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Coercers

    describe VerticalAlignment do

      let(:described) { Vedeu::Coercers::VerticalAlignment }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}

      describe '#value' do
        subject { described.coerce(_value).value }

        context 'when the value is :none' do
          let(:_value) { :none }

          it { subject.must_equal(:none) }
        end

        context 'when the value is nil' do
          it { subject.must_equal(:none) }
        end

        context 'when the value is not a Symbol' do
          let(:_value) { 'invalid' }

          it { subject.must_equal(:none) }
        end

        context 'when the value is :bottom' do
          let(:_value) { :bottom }

          it { subject.must_equal(:bottom) }
        end

        context 'when the value is :middle' do
          let(:_value) { :middle }

          it { subject.must_equal(:middle) }
        end

        context 'when the value is :top' do
          let(:_value) { :top }

          it { subject.must_equal(:top) }
        end

        context 'when the value is :align_invalid' do
          let(:_value) { :align_invalid }

          it { subject.must_equal(:none) }
        end
      end

    end # VerticalAlignment

  end # Coercers

end # Vedeu
