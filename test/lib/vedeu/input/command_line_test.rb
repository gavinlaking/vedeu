require 'test_helper'

module Vedeu

	describe CommandLine do

    let(:described)  { Vedeu::CommandLine }
    let(:instance)   { described.new(attributes) }
    let(:text)       { '' }
    let(:x)          { 0 }
    let(:y)          { 0 }
    let(:attributes) {
      {
        text: text,
        x:    x,
        y:    y,
      }
    }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }

      it { instance.instance_variable_get('@text').must_equal(text) }
      it { instance.instance_variable_get('@x').must_equal(x) }
      it { instance.instance_variable_get('@y').must_equal(y) }
    end

    describe '#insert' do
      let(:character) { 'z' }

      subject { instance.insert(character) }

      context 'when there is no text' do
        it { subject.must_equal('z') }
      end

      context 'when there is a single line of text' do
        let(:x)    { 10 }
        let(:y)    { 0 }
        let(:text) { 'This is some text.' }

        it { subject.must_equal('This is sozme text.') }
      end

      context 'when there are multiple lines of text' do
        let(:text) { "This is some text.\nAnd here is a bit more." }
        let(:x)    { 14 }
        let(:y)    { 1 }

        it { subject.must_equal('And here is a zbit more.') }
      end
    end

    describe '#delete' do
      subject { instance.delete }

      context 'when there is no text' do
        it { subject.must_equal('') }
      end

      context 'when there is a single line of text' do
        let(:x)        { 9 }
        let(:y)        { 0 }
        let(:text)     { 'This is some text.' }

        it {
          subject.must_equal('This is sme text.')
        }
      end

      context 'when there are multiple lines of text' do
        let(:x)        { 14 }
        let(:y)        { 1 }
        let(:text)     { "This is some text.\nAnd here is a bit more." }

        it {
          subject.must_equal('And here is a it more.')
        }
      end
    end

    describe '#progress' do
      subject { instance.progress }

      context 'when there is no text' do
        it { subject.must_equal(0) }
      end

      context 'when the cursor is midway through the first line' do
        let(:text) { "This is some text.\n" }
        let(:x)    { 9 }

        it { subject.must_equal(10) }
      end

      context 'when the cursor is at the start of the first line' do
        let(:text) { "This is some text.\n" }

        it {
          subject.must_equal(1)
        }

        it 'multiple calls are honoured' do
          instance.progress
          subject.must_equal(2)
        end
      end

      context 'when the cursor is at the end of the first line' do
        let(:text) { "This is some text.\nAnd here is a bit more." }
        let(:x)    { 17 }
        let(:y)    { 0 }

        it {
          subject.must_equal(1)
          instance.y.must_equal(1)
          instance.render.must_equal(
            "This is some text.\n\e[7mA\e[27mnd here is a bit more.\n"
          )
        }
      end

      context 'when the cursor is at the end of the last line' do
        let(:text) { "This is some text.\nAnd here is a bit more." }
        let(:x)    { 22 }
        let(:y)    { 1 }

        it {
          subject.must_equal(22)
          instance.render.must_equal(
            "This is some text.\nAnd here is a bit more\e[7m.\e[27m\n"
          )
        }
      end
    end

    describe '#raw_mode?' do
      subject { instance.raw_mode? }

      it { subject.must_equal(false) }
    end

    describe '#regress' do
      subject { instance.regress }

      context 'when there is no text' do
        it { subject.must_equal(0) }
      end

      context 'when the cursor is midway through the first line' do
        let(:text) { "This is some text.\n" }
        let(:x)    { 9 }

        it { subject.must_equal(8) }
        it { instance.render.must_equal(
            "This is s\e[7mo\e[27mme text.\n"
          )
        }
      end

      context 'when the cursor is at the start of the first line' do
        let(:text) { "This is some text.\n" }
        let(:x)    { 0 }
        let(:y)    { 0 }

        it {
          subject.must_equal(0)
        }

        it { instance.render.must_equal("\e[7mT\e[27mhis is some text.\n") }

        it 'multiple calls are discarded' do
          instance.regress
          subject.must_equal(0)
        end
      end

      context 'when the cursor is at the start of the second line' do
        let(:text) { "This is some text.\nAnd here is a bit more." }
        let(:x)    { 0 }
        let(:y)    { 1 }

        it {
          subject.must_equal(17)
          instance.y.must_equal(0)
          instance.render.must_equal(
            "This is some text\e[7m.\e[27m\nAnd here is a bit more.\n"
          )
        }
      end
    end

    describe '#render' do
      subject { instance.render }

      context 'when there is no text' do
        it { subject.must_equal("") }
      end

      context 'when there is text' do
        let(:text) { 'This is some text.' }

        it { subject.must_equal("\e[7mT\e[27mhis is some text.\n") }
      end

      context 'when there is text and a position is set' do
        let(:text) { 'This is some text.' }
        let(:x)    { 10 }
        let(:y)    { 0 }

        it { subject.must_equal("This is so\e[7mm\e[27me text.\n") }
      end
    end

    describe 'private #column' do
      subject { instance.send(:column) }

      context 'when there is no text' do
        it { subject.must_equal('') }
      end

      context 'when there is a single line of text' do
        let(:text) { 'This is some text.' }
        let(:x)    { 10 }
        let(:y)    { 0 }

        it { subject.must_equal('m') }
      end

      context 'when there are multiple lines of text' do
        let(:text) { "This is some text.\nAnd here is a bit more." }
        let(:x)    { 14 }
        let(:y)    { 1 }

        it { subject.must_equal('b') }
      end
    end

    describe 'private #line' do
      subject { instance.send(:line) }

      context 'when there is no text' do
        it { subject.must_equal([]) }
      end

      context 'when there is a single line of text' do
        let(:text) { 'This is some text.' }
        let(:x)    { 10 }
        let(:y)    { 0 }

        it { subject.must_equal(text.chars) }
      end

      context 'when there are multiple lines of text' do
        let(:text) { "This is some text.\nAnd here is a bit more." }
        let(:x)    { 11 }
        let(:y)    { 1 }

        it { subject.must_equal('And here is a bit more.'.chars) }
      end
    end

    describe 'private #lines' do
      subject { instance.send(:lines) }

      context 'when there is no text' do
        it { subject.must_equal(['']) }
      end

      context 'when there is a single line of text' do
        let(:text) { 'This is some text.' }
        let(:x)    { 10 }
        let(:y)    { 0 }

        it { subject.must_equal([text]) }
      end

      context 'when there are multiple lines of text' do
        let(:text) { "This is some text.\nAnd here is a bit more." }
        let(:x)    { 11 }
        let(:y)    { 1 }

        it { subject.must_equal(
          ['This is some text.', 'And here is a bit more.']
        ) }
      end
    end

	end # CommandLine

end # Vedeu
