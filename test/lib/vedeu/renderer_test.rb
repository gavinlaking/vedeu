require_relative '../../test_helper'

module Vedeu
  describe Renderer do
    let(:klass)    { Renderer }
    let(:instance) { klass.new(composition) }
    let(:composition)   {
      [
        ["\e[30;47ma\e[0m", "\e[31;49mb\e[0m", "\e[32;49mc\e[0m"],
        ["\e[33;49md\e[0m", "\e[34;49me\e[0m", "\e[35;49mf\e[0m"],
        ["\e[36;49mg\e[0m", "\e[37;49mh\e[0m", "\e[39;47mi\e[0m"],
      ]
    }

    it { instance.must_be_instance_of(Vedeu::Renderer) }

    describe '#each' do
      subject { instance.each }

      it { subject.must_be_instance_of(Enumerator) }
    end

    describe '#render' do
      subject { instance.render }

      it { subject.must_be_instance_of(String) }

      it 'renders the composition' do
        subject
          .must_equal("\e[30;47ma\e[0m\e[31;49mb\e[0m\e[32;49mc\e[0m\e[33;49md\e[0m\e[34;49me\e[0m\e[35;49mf\e[0m\e[36;49mg\e[0m\e[37;49mh\e[0m\e[39;47mi\e[0m")
      end
    end
  end
end
