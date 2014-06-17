require_relative '../../../test_helper'

module Vedeu
  describe Directive do
    let(:described_class)    { Directive }
    let(:described_instance) { described_class.new(interface, directives) }
    let(:subject)            { described_instance }
    let(:interface)          { Interface.new }
    let(:directives)         {
      {
        position: position,
        colour:   colour,
        style:    style
      }
    }
    let(:position)           { [] }
    let(:colour)             { [] }
    let(:style)              { [] }

    it 'returns a Directive instance' do
      described_instance.must_be_instance_of(Directive)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get('@interface').must_be_instance_of(Interface)
    end

    it 'sets an instance variable' do
      subject.instance_variable_get('@directives').must_be_instance_of(Hash)
    end

    describe '.enact' do
      let(:subject) { described_class.enact(interface, directives) }

      it 'returns a String' do
        subject.must_be_instance_of(String)
      end

      context 'when the position is not set' do
        it 'returns an empty string' do
          subject.must_equal('')
        end
      end

      context 'when the position is set' do
        let(:position) { [4, 5] }

        it 'returns an escape sequence' do
          subject.must_equal("\e[4;5H")
        end
      end

      context 'when the colour is not set' do
        it 'returns an empty string' do
          subject.must_equal('')
        end
      end

      context 'when the colour is set' do
        let(:colour) { [:red, :black] }

        it 'returns an escape sequence' do
          subject.must_equal("\e[38;2;31m\e[48;2;40m")
        end
      end

      context 'when the style is not set' do
        it 'returns an empty string' do
          subject.must_equal('')
        end
      end

      context 'when the style is set' do
        let(:style) { [:normal, :underline, :normal] }

        it 'returns an escape sequence' do
          subject.must_equal("\e[0m\e[4m\e[0m")
        end
      end
    end
  end
end
