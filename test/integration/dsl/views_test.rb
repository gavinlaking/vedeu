require 'test_helper'

describe 'Views' do

  describe '.interface' do
    subject {
      Vedeu.interface 'keymaps' do
        # ...
      end
    }

    #it { subject.must_be_instance_of(Vedeu::Composition) }

    it 'allows the use of ... within Vedeu.interface' do
      skip
    end

    context 'when no value is provided' do

    end
  end

  describe '.renders' do
    subject {
      Vedeu.renders do
        # ...
      end
    }

    #it { subject.must_be_instance_of(Vedeu::Composition) }

    it 'allows the use of ... within Vedeu.renders' do
      skip
    end

    context 'when no block is given' do
      subject { Vedeu.renders }

      it { proc { subject }.must_raise(Vedeu::InvalidSyntax) }
    end
  end

  describe '.views' do
    subject {
      Vedeu.views do
        # ...
      end
    }

    #it { subject.must_be_instance_of(Vedeu::Composition) }

    it 'allows the use of ... within Vedeu.views' do
      skip
    end

    context 'when no block is given' do
      subject { Vedeu.views }

      it { proc { subject }.must_raise(Vedeu::InvalidSyntax) }
    end
  end

end
