# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Coercers

    describe Page do

      let(:described) { Vedeu::Coercers::Page }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}
      let(:klass)     { Vedeu::Models::Page }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.coerce' do
        it { described.must_respond_to(:coerce) }
      end

      describe '#coerce' do
        subject { instance.coerce }

        context 'when the value is already the target class' do
          let(:_value) { klass.new }

          it { subject.must_be_instance_of(klass) }
          it { subject.must_equal(_value) }
        end
      end

      describe '.coerce' do
        let(:_value) {}

        subject { described.coerce(_value) }

        it { proc { subject }.must_raise(Vedeu::Error::InvalidSyntax) }

        context 'when the value is a Vedeu::Models::Row' do
          let(:_value)   { Vedeu::Models::Row.new }
          let(:expected) { klass.new([_value]) }

          it { subject.must_equal(expected) }
        end

        context 'when the value is an Array' do
          context 'and the value is empty' do
            let(:_value)   { [] }
            let(:expected) {
              klass.coerce(Vedeu::Models::Row.coerce(_value))
            }

            it { subject.must_be_instance_of(klass) }
            it { subject.must_equal(expected) }
          end

          context 'and the value is not empty, the content is' do
            context 'is an empty Array' do
              let(:_value)   { [[]] }
              let(:expected) { klass.coerce(Vedeu::Models::Row.coerce([])) }

              it { subject.must_be_instance_of(klass) }
              it { subject.must_equal(expected) }
            end

            context 'an array of Vedeu::Models::Row objects' do
              let(:_value) {
                [
                  Vedeu::Models::Row.new([:hydrogen, :helium]),
                  Vedeu::Models::Row.new([:lithium, :beryllium]),
                ]
              }
              let(:expected) { klass.new(_value) }

              it { subject.must_equal(expected) }
            end

            context 'a mix of Vedeu::Models::Row objects and other objects' do
              let(:_value) {
                [
                  Vedeu::Models::Row.new([:hydrogen, :helium]),
                  [:lithium],
                  Vedeu::Models::Row.new([:beryllium, :boron]),
                ]
              }
              let(:expected) {
                klass.new([
                  Vedeu::Models::Row.new([:hydrogen, :helium]),
                  Vedeu::Models::Row.new([:lithium]),
                  Vedeu::Models::Row.new([:beryllium, :boron]),
                ])
              }

              it { subject.must_equal(expected) }
            end

            context 'a mix of Vedeu::Models::Row objects, other objects and ' \
                    'nils' do
              let(:_value) {
                [
                  Vedeu::Models::Row.new([:hydrogen, :helium]),
                  nil,
                  [:lithium],
                  Vedeu::Models::Row.new([:beryllium]),
                  [
                    Vedeu::Cells::Char.new(value: 'b'),
                    Vedeu::Cells::Char.new(value: 'o'),
                    Vedeu::Cells::Char.new(value: 'r'),
                    Vedeu::Cells::Char.new(value: 'o'),
                    Vedeu::Cells::Char.new(value: 'n'),
                  ],
                  [nil, :carbon],
                  :nitrogen,
                ]
              }
              let(:expected) {
                klass.new([
                  Vedeu::Models::Row.new([:hydrogen, :helium]),
                  Vedeu::Models::Row.new([]),
                  Vedeu::Models::Row.new([:lithium]),
                  Vedeu::Models::Row.new([:beryllium]),
                  Vedeu::Models::Row.new([
                    Vedeu::Cells::Char.new(value: 'b'),
                    Vedeu::Cells::Char.new(value: 'o'),
                    Vedeu::Cells::Char.new(value: 'r'),
                    Vedeu::Cells::Char.new(value: 'o'),
                    Vedeu::Cells::Char.new(value: 'n'),
                  ]),
                  Vedeu::Models::Row.new([:carbon]),
                  Vedeu::Models::Row.new([:nitrogen]),
                ])
              }

              it { subject.must_equal(expected) }
            end

          end

        end
      end

    end # Page

  end # Coercers

end # Vedeu
