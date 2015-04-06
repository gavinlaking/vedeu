require 'test_helper'

module Vedeu

  describe JSONRenderer do

    let(:described) { Vedeu::JSONRenderer }
    let(:instance)  { described.new(output) }
    let(:output)    {}

    describe '#initialize' do
      it { instance.must_be_instance_of(Vedeu::JSONRenderer) }
      it { instance.instance_variable_get('@output').must_equal(output) }
    end

    describe '.render' do
      subject { described.render(output) }

      it { subject.must_be_instance_of(String) }

      context 'when the output is empty' do
        it { subject.must_equal('') }
      end

      context 'when the output is not empty' do
        let(:colour) {
          Vedeu::Colour.new(foreground: '#ff0000', background: '#ffffff')
        }
        let(:output) {
          [
            [
              Vedeu::Char.new(                value: 'a',
                                              colour: colour,
                                              position: Vedeu::Position[5, 3])
            ]
          ]
        }
        it { subject.must_equal("{\"border\":\"\",\"colour\":{\"background\":\"\\u001b[48;2;255;255;255m\",\"foreground\":\"\\u001b[38;2;255;0;0m\"},\"parent\":{\"background\":\"\",\"foreground\":\"\",\"style\":\"\"},\"position\":{\"y\":5,\"x\":3},\"style\":\"\",\"value\":\"a\"}\n\n") }
      end
    end

  end # JSONRenderer

end # Vedeu
