require 'test_helper'

module Vedeu

  describe ColourCoercer do

    let(:described) { Vedeu::ColourCoercer }
    let(:instance)  { described.new(_value) }
    let(:_value)    { }

    describe '#initialize' do
      subject { instance }
    end

    describe '.coerce' do
      it { described.must_respond_to(:coerce) }
    end

    describe '.from_hash' do
      it { described.must_respond_to(:from_hash) }
    end

    describe '#coerce' do
      subject { instance.coerce }

      context 'when no value is given' do
        it { subject.must_be_instance_of(Vedeu::Colour) }
      end

      context 'when a value is given' do
        context 'when the value is a Vedeu::Colour' do
          let(:_value) { Vedeu::Colour.new }

          it { subject.must_equal(_value) }
        end

        context 'when the value is a Hash' do
          let(:_value) { { } }

          it {
            Vedeu::ColourCoercer.expects(:from_hash).with(_value)
            subject
          }
        end
      end
    end

    describe '#from_hash' do
      subject { instance.from_hash }

      context 'when no value is given' do
        it { subject.must_be_instance_of(Vedeu::Colour) }
      end

      context 'when a value is given' do
        context 'when the value has a :colour key' do
          let(:_value) { { colour: colour_value } }
          let(:colour_value) { Vedeu::Colour.new }

          it {
            Vedeu::ColourCoercer.expects(:coerce).with(colour_value)
            subject
          }
        end

        context 'when the value has a :background or :foreground key' do
          let(:_value) { { background: '#000000', foreground: '#ffffff' } }

          it {
            Vedeu::Colour.expects(:new).with(_value)
            subject
          }
        end

        context 'when the value is empty or has unhandled keys' do
          let(:_value) { { unhandled: :some_value } }

          it { subject.must_be_instance_of(Vedeu::Colour) }
        end
      end
    end

  end # ColourCoercer

end # Vedeu
