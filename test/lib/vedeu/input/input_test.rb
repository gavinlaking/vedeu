require 'test_helper'

module Vedeu

  describe Input do

    let(:reader)    { mock }
    let(:keypress)  { 'a' }
    let(:described) { Vedeu::Input }
    let(:instance)  { described.new(reader) }

    before { reader.stubs(:read).returns(keypress) }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(Input) }
      it { subject.instance_variable_get('@reader').must_equal(reader) }
    end

    describe '.capture' do
      context 'when the key is not special' do
        before { Vedeu.stubs(:trigger).returns([false]) }

        it 'triggers an event associated with the key pressed' do
          Input.capture(reader).must_equal([false])
        end
      end

      context 'when the key is special' do
        let(:keypress) { "\e" }

        before { Vedeu.stubs(:trigger).raises(ModeSwitch) }

        it 'switches the terminal mode when escape is pressed' do
          proc { Input.capture(reader) }.must_raise(ModeSwitch)
        end
      end
    end

  end # Input

end # Vedeu
