# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Coercers

    describe HorizontalAlignment do

      let(:described) { Vedeu::Coercers::HorizontalAlignment }
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

        context 'when the value is :center' do
          let(:_value) { :center }

          it { subject.must_equal(:centre) }
        end

        context 'when the value is :centre' do
          let(:_value) { :centre }

          it { subject.must_equal(:centre) }
        end

        context 'when the value is :left' do
          let(:_value) { :left }

          it { subject.must_equal(:left) }
        end

        context 'when the value is :right' do
          let(:_value) { :right }

          it { subject.must_equal(:right) }
        end

        context 'when the value is :align_invalid' do
          let(:_value) { :align_invalid }

          it { subject.must_equal(:none) }
        end
      end

    end # HorizontalAlignment

  end # Coercers

end # Vedeu
