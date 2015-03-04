require 'test_helper'

module Vedeu

  describe Borders do

    let(:described) { Vedeu::Borders }

    describe '.borders' do
      subject { described.borders }

      it { subject.must_be_instance_of(described) }
    end

  end # Borders

  describe Buffers do

    let(:described) { Vedeu::Buffers }

    describe '.buffers' do
      subject { described.buffers }

      it { subject.must_be_instance_of(described) }
    end

  end # Buffers

  describe Cursors do

    let(:described) { Vedeu::Cursors }

    describe '.cursors' do
      subject { described.cursors }

      it { subject.must_be_instance_of(described) }
    end

    describe '.cursor' do
      subject { Vedeu.cursor }

      context 'when there are cursors are defined' do
        before do
          Vedeu::Focus.add('Vedeu.cursor')
          Vedeu::Cursor.new({ name: 'Vedeu.cursor' }).store
        end

        it { subject.must_be_instance_of(Vedeu::Cursor) }
      end

      context 'when there are no cursors defined' do
        before do
          Vedeu::Focus.reset
          Vedeu.cursors.reset
        end

        it { subject.must_be_instance_of(NilClass) }
      end
    end

  end # Cursors

  describe EventsRepository do

    let(:described) { Vedeu::EventsRepository }

    describe '.events' do
      subject { described.events }

      it { subject.must_be_instance_of(described) }
    end

  end # EventsRepository

  describe Geometries do

    let(:described) { Vedeu::Geometries }

    describe '.geometries' do
      subject { described.geometries }

      it { subject.must_be_instance_of(described) }
    end

  end # Geometries

  describe Groups do

    let(:described) { Vedeu::Groups }

    describe '.groups' do
      subject { described.groups }

      it { subject.must_be_instance_of(described) }
    end

  end # Groups

  describe InterfacesRepository do

    let(:described) { Vedeu::InterfacesRepository }

    describe '.interfaces' do
      subject { described.interfaces }

      it { subject.must_be_instance_of(described) }
    end

  end # InterfacesRepository

  describe Keymaps do

    let(:described) { Vedeu::Keymaps }

    describe '.keymaps' do
      subject { described.keymaps }

      it { subject.must_be_instance_of(described) }
    end

  end # Keymaps

  describe Menus do

    let(:described) { Vedeu::Menus }

    describe '.menus' do
      subject { described.menus }

      it { subject.must_be_instance_of(described) }
    end

  end # Menus

end # Vedeu
