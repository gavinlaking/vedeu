# frozen_string_literal: true

require 'test_helper'

module Vedeu

  module Coercers

    describe EditorLine do

      let(:described) { Vedeu::Coercers::EditorLine }
      let(:instance)  { described.new(_value) }
      let(:_value)    {}
      let(:klass)     { Vedeu::Editor::Line }

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@value').must_equal(_value) }
      end

      describe '.coerce' do
        it { described.must_respond_to(:coerce) }
      end

      describe '#coerce' do
        subject { instance.coerce }

        it { subject.must_be_instance_of(klass) }

        context 'when the value is already the target class' do
          let(:_value) { klass.new }

          it { subject.must_be_instance_of(klass) }
          it { subject.must_equal(_value) }
        end

        context 'when the value is a String' do
          let(:_value) { '' }

          it { subject.must_be_instance_of(klass) }

          context 'when the value is empty' do
            it { subject.collection.must_equal('') }
          end

          context 'when the value is not empty' do
            let(:_value) { 'some value...' }

            it { subject.collection.must_equal(_value) }
          end

          context 'when the value contains a line feed' do
            let(:_value)   { "some value...\n" }
            let(:expected) { 'some value...' }

            it { subject.collection.must_equal(expected) }
          end
        end

        context 'when the value is not already the target class or ' \
                'a string' do
          it { subject.must_be_instance_of(klass) }
        end
      end

    end # EditorLine

  end # Coercers

end # Vedeu
