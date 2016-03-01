# frozen_string_literal: true

require 'test_helper'

class OtherKlass
end # OtherKlass

module MyFirstApp

  class SomeKlass

  end # SomeKlass

end # MyFirstApp

module Vedeu

  class VedeuCommonClass

    include Vedeu::Common

    def defined_value_test(variable)
      present?(variable)
    end

    def undefined_value_test(variable)
      absent?(variable)
    end

  end # VedeuCommonClass

  describe Common do

    let(:described) { Vedeu::VedeuCommonClass }
    let(:instance)  { described.new }

    describe '#absent?' do
      subject { instance.undefined_value_test(_value) }

      context 'when the variable is a Fixnum' do
        let(:_value) { 17 }

        it { subject.must_equal(false) }
      end

      context 'when the variable is false' do
        let(:_value) { false }

        it { subject.must_equal(true) }
      end

      context 'when the variable is not nil or empty' do
        let(:_value) { 'not empty' }

        it { subject.must_equal(false) }
      end

      context 'when the variable is nil or empty' do
        let(:_value) { [] }

        it { subject.must_equal(true) }
      end

      context 'when dealing with keys which may not exist or have a value' do
        let(:attributes) { {} }
        let(:_value)     { attributes[:not_found] }

        it { subject.must_equal(true) }
      end
    end

    describe '#array?' do
      let(:_value) {}

      subject { instance.array?(_value) }

      context 'when the value is an Array' do
        let(:_value) { [:hydrogen] }

        it { subject.must_equal(true) }
      end

      context 'when the value is not an Array' do
        it { subject.must_equal(false) }
      end
    end

    describe '#boolean' do
      subject { instance.boolean(_value) }

      context 'when the value is a TrueClass' do
        let(:_value) { true }

        it { subject.must_equal(true) }
      end

      context 'when the value is a FalseClass' do
        let(:_value) { false }

        it { subject.must_equal(false) }
      end

      context 'when the value is nil' do
        let(:_value) {}

        it { subject.must_equal(false) }
      end

      context 'when the value is anything else' do
        let(:_value) { 'anything' }

        it { subject.must_equal(true) }
      end
    end

    describe '#empty_value?' do
      let(:_value) {}

      subject { instance.empty_value?(_value) }

      context 'when the value does not respond to :empty?' do
        context 'when the value is nil' do
          it { subject.must_equal(true) }
        end

        context 'whent the value is not nil' do
          let(:_value) { :some_value }

          it { subject.must_equal(false) }
        end
      end

      context 'when the value responds to :empty?' do
        context 'when the value is not empty' do
          let(:_value) { [:some_value] }

          it { subject.must_equal(false) }
        end

        context 'when the value is empty' do
          let(:_value) { [] }

          it { subject.must_equal(true) }
        end
      end
    end

    describe '#boolean?' do
      subject { instance.boolean?(_value) }

      context 'when the value is a TrueClass' do
        let(:_value) { true }

        it { subject.must_equal(true) }
      end

      context 'when the value is a FalseClass' do
        let(:_value) { false }

        it { subject.must_equal(true) }
      end

      context 'when the value is anything else' do
        let(:_value) { 'anything' }

        it { subject.must_equal(false) }
      end
    end

    describe '#escape?' do
      subject { instance.escape?(_value) }

      context 'when the value is a Vedeu::Cells::Escape' do
        let(:_value) { Vedeu::Cells::Escape.new(value: "\e[0m") }

        it { subject.must_equal(true) }
      end

      context 'when the value is a Vedeu::Cells::Cursor' do
        let(:_value) { Vedeu::Cells::Cursor.new(value: "\e[?25h") }

        it { subject.must_equal(true) }
      end

      context 'when the value is anything else' do
        let(:_value) { 'anything' }

        it { subject.must_equal(false) }
      end
    end

    describe '#falsy?' do
      subject { instance.falsy?(_value) }

      context 'when the value is a TrueClass' do
        let(:_value) { true }

        it { subject.must_equal(false) }
      end

      context 'when the value is a FalseClass' do
        let(:_value) { false }

        it { subject.must_equal(true) }
      end

      context 'when the value is nil' do
        let(:_value) {}

        it { subject.must_equal(true) }
      end

      context 'when the value is anything else' do
        let(:_value) { 'anything' }

        it { subject.must_equal(false) }
      end
    end

    describe '#hash?' do
      let(:_value) {}

      subject { instance.hash?(_value) }

      context 'when the value is a Hash' do
        let(:_value) { { element: :hydrogen } }

        it { subject.must_equal(true) }
      end

      context 'when the value is not a Hash' do
        it { subject.must_equal(false) }
      end
    end

    describe '#line_model?' do
      subject { instance.line_model? }

      context 'when a model method is available in the including class' do
        let(:model) { Vedeu::Views::Line.new }

        before { instance.stubs(:model).returns(model) }

        context 'when the model is a line' do
          it { subject.must_equal(true) }
        end

        context 'when the model is not a line' do
          let(:model) { :invalid }

          it { subject.must_equal(false) }
        end
      end

      context 'when a model method is not available in the including class' do
        it { subject.must_equal(false) }
      end
    end

    describe '#numeric?' do
      let(:_value) {}

      subject { instance.numeric?(_value) }

      it { instance.must_respond_to(:fixnum?) }

      context 'when the value is numeric' do
        let(:_value) { 16 }

        it { subject.must_equal(true) }
      end

      context 'when the value is a Float::INFINITY' do
        let(:_value) { Float::INFINITY }

        it { subject.must_equal(true) }
      end

      context 'when the value is not numeric' do
        it { subject.must_equal(false) }
      end
    end

    describe '#positionable?' do
      subject { instance.positionable?(_value) }

      context 'when it does not respond to position' do
        let(:_value) { '' }

        it { subject.must_equal(false) }
      end

      context 'when it responds to position' do
        let(:_value)   { Vedeu::Cells::Empty.new(position: position) }
        let(:position) { false }

        context 'when the position is a Vedeu::Geometries::Position' do
          let(:position) { Vedeu::Geometries::Position.new }

          it { subject.must_equal(true) }
        end

        context 'when the position is not a Vedeu::Geometries::Position' do
          it { subject.must_equal(false) }
        end
      end
    end

    describe '#present?' do
      subject { instance.defined_value_test(_value) }

      context 'when the variable is a Fixnum' do
        let(:_value) { 17 }

        it { subject.must_equal(true) }
      end

      context 'when the variable is a Symbol' do
        let(:_value) { :some_value }

        it { subject.must_equal(true) }
      end

      context 'when the variable is false' do
        let(:_value) { false }

        it { subject.must_equal(false) }
      end

      context 'when the variable is not nil or empty' do
        let(:_value) { 'not empty' }

        it { subject.must_equal(true) }
      end

      context 'when the variable is nil or empty' do
        let(:_value) { [] }

        it { subject.must_equal(false) }
      end

      context 'when dealing with keys which may not exist or have a value' do
        let(:attributes) { {} }
        let(:_value)     { attributes[:not_found] }

        it { subject.must_equal(false) }
      end
    end

    describe '#snake_case' do
      subject { instance.snake_case(klass) }

      context 'when empty' do
        let(:klass) { '' }

        it { subject.must_equal('') }
      end

      context 'when a single module' do
        let(:klass) { MyFirstApp }

        it { subject.must_equal('my_first_app') }
      end

      context 'when namespaced class' do
        let(:klass) { MyFirstApp::SomeKlass }

        it { subject.must_equal('my_first_app/some_klass') }
      end

      context 'when single class' do
        let(:klass) { ::OtherKlass }

        it { subject.must_equal('other_klass') }
      end

      context 'when a string' do
        let(:klass) { 'MyFirstApp' }

        it { subject.must_equal('my_first_app') }
      end
    end

    describe '#stream_model?' do
      subject { instance.stream_model? }

      context 'when a model method is available in the including class' do
        let(:model) { Vedeu::Views::Stream.new }

        before { instance.stubs(:model).returns(model) }

        context 'when the model is a stream' do
          it { subject.must_equal(true) }
        end

        context 'when the model is not a stream' do
          let(:model) { :invalid }

          it { subject.must_equal(false) }
        end
      end

      context 'when a model method is not available in the including class' do
        it { subject.must_equal(false) }
      end
    end

    describe '#string?' do
      let(:_value) {}

      subject { instance.string?(_value) }

      context 'when the value is string' do
        let(:_value) { 'test' }

        it { subject.must_equal(true) }
      end

      context 'when the value is not string' do
        it { subject.must_equal(false) }
      end
    end

    describe '#symbol?' do
      let(:_value) {}

      subject { instance.symbol?(_value) }

      context 'when the value is a Symbol' do
        let(:_value) { :test }

        it { subject.must_equal(true) }
      end

      context 'when the value is not a Symbol' do
        it { subject.must_equal(false) }
      end
    end

    describe '#truthy?' do
      subject { instance.truthy?(_value) }

      context 'when the value is a TrueClass' do
        let(:_value) { true }

        it { subject.must_equal(true) }
      end

      context 'when the value is a FalseClass' do
        let(:_value) { false }

        it { subject.must_equal(false) }
      end

      context 'when the value is nil' do
        let(:_value) {}

        it { subject.must_equal(false) }
      end

      context 'when the value is anything else' do
        let(:_value) { 'anything' }

        it { subject.must_equal(true) }
      end
    end

    describe '#view_model?' do
      subject { instance.view_model? }

      context 'when a model method is available in the including class' do
        let(:model) { Vedeu::Views::View.new }

        before { instance.stubs(:model).returns(model) }

        context 'when the model is a view' do
          it { subject.must_equal(true) }
        end

        context 'when the model is not a view' do
          let(:model) { :invalid }

          it { subject.must_equal(false) }
        end
      end

      context 'when a model method is not available in the including class' do
        it { subject.must_equal(false) }
      end
    end

  end # Common

end # Vedeu
