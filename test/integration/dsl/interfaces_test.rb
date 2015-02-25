require 'test_helper'

describe 'Interfaces' do

  describe '#background' do
    subject {
      Vedeu.interface 'interfaces' do
        background ''
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    context 'when no value is provided' do

    end
  end

  describe '#border' do
    subject {
      Vedeu.interface 'interfaces' do
        border do
        end
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    context 'when no value is provided' do

    end
  end

  describe '#colour' do
    subject {
      Vedeu.interface 'interfaces' do
        colour ''
      end
    }

    context 'when no value is provided' do

    end
  end

  describe '#foreground' do
    subject {
      Vedeu.interface 'interfaces' do
        foreground ''
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    context 'when no value is provided' do

    end
  end

  describe '#cursor' do
    subject {
      Vedeu.interface 'interfaces' do
        cursor ''
      end
    }

    context 'when no value is provided' do

    end
  end

  describe '#cursor!' do
    subject {
      Vedeu.interface 'interfaces' do
        cursor!
      end
    }

    context 'when no value is provided' do

    end
  end

  describe '#delay' do
    subject {
      Vedeu.interface 'interfaces' do
        delay ''
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    context 'when no value is provided' do

    end
  end

  describe '#focus!' do
    subject {
      Vedeu.interface 'interfaces' do
        focus!
      end
    }

    context 'when no value is provided' do

    end
  end

  describe '#geometry' do
    subject {
      Vedeu.interface 'interfaces' do
        geometry do
        end
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    context 'when no value is provided' do

    end
  end

  describe '#group' do
    subject {
      Vedeu.interface 'interfaces' do
        group 'compounds'
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    context 'when no value is provided' do

    end
  end

  describe '#keys' do
    subject {
      Vedeu.interface 'interfaces' do
        keys do
        end
      end
    }

    context 'when no value is provided' do

    end
  end

  describe '#lines' do
    subject {
      Vedeu.interface 'interfaces' do
        lines do
        end
      end
    }

    context 'when no value is provided' do

    end
  end

  describe '#name' do
    subject {
      Vedeu.interface do
        name 'interfaces'
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    context 'when no value is provided' do

    end
  end

  describe '#style' do
    subject {
      Vedeu.interface 'interfaces' do
        style ''
      end
    }

    it { subject.must_be_instance_of(Vedeu::Interface) }

    context 'when no value is provided' do

    end
  end

end
