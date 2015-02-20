require 'test_helper'

module Vedeu

  describe Read do

    let(:described) { Vedeu::Read }
    let(:instance)  { described.new(console, data) }
    let(:console)   { Vedeu::Console.new(height, width) }
    let(:data)      {}
    let(:height)    { 4 }
    let(:width)     { 30 }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@console').must_equal(console) }
      it { instance.instance_variable_get('@data').must_equal(data) }
    end

    describe '.from' do
      subject { described.from(console, data) }

      it { subject.must_be_instance_of(String) }

      context 'when no data is given' do
        it { subject.must_equal('') }
      end

      context 'when data is given' do
        let(:data) { 'a' }

        it { subject.must_equal('a') }
      end
    end

    describe '#getch' do
      let(:string) {}

      subject { instance.getch(string) }

      it { subject.must_be_instance_of(String) }

      context 'when no string is given' do
        it { subject.must_equal('') }
      end

      context 'when a multi-character string is given' do
        let(:string) { 'Some text...' }

        it { subject.must_equal('S') }
      end

      context 'when a single character string is given' do
        let(:string) { 'a' }

        it { subject.must_equal('a') }
      end
    end

    describe '#gets' do
      let(:string) {}

      subject { instance.gets(string) }

      it { subject.must_be_instance_of(String) }

      context 'when no string is given' do
        it { subject.must_equal('') }
      end

      context 'when a string with line feed is given' do
        let(:string) { "Some text...\n" }

        it { subject.must_equal('Some text...') }
      end

      context 'when a string without line feed is given' do
        let(:string) { 'Some text...' }

        it { subject.must_equal('Some text...') }
      end
    end

  end # Read

end # Vedeu
