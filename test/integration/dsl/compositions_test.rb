require 'test_helper'

describe 'Compositions' do

  describe '#render' do
    subject {
      Vedeu.render do

      end
    }

    #it { return_type_for(subject, Vedeu::Composition) }

    it 'allows the use of Vedeu.render' do
      skip
    end

    context 'when no block is given' do
      subject { Vedeu.render }

      it { proc { subject }.must_raise(Vedeu::InvalidSyntax) }
    end
  end

  describe '#view' do
    subject {
      Vedeu.view 'compositions' do

      end
    }

    #it { return_type_for(subject, Vedeu::Composition) }

    it 'allows the use of Vedeu.view' do
      skip
    end

    context 'when no block is given' do
      subject { Vedeu.view }

      #it { proc { subject }.must_raise(Vedeu::InvalidSyntax) }
    end
  end

  describe '#views' do
    subject {
      Vedeu.views do

      end
    }

    #it { return_type_for(subject, Vedeu::Composition) }

    it 'allows the use of Vedeu.views' do
      skip
    end

    context 'when no block is given' do
      subject { Vedeu.views }

      #it { proc { subject }.must_raise(Vedeu::InvalidSyntax) }
    end
  end

end
