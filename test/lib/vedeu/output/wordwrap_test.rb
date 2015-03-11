require 'test_helper'

module Vedeu

  describe Wordwrap do

    let(:described) { Vedeu::Wordwrap }
    let(:instance)  { described.new(text, options) }
    let(:text)      { '' }
    let(:options)   {
      {
        ellipsis: '...',
        mode:     mode,
        width:    width,
      }
    }
    let(:mode)      { :default }
    let(:width)     { 30 }

    let(:text_line) {
      "Krypton (from Greek: κρυπτός kryptos 'the hidden one')."
    }
    let(:text_block) {
      "Krypton (from Greek: κρυπτός kryptos 'the hidden one') is a chemical " \
      "element with symbol Kr and atomic number 36. It is a member of group " \
      "18 (noble gases) elements."
    }
    let(:text_newlines) {
      "Krypton is a colorless, odorless, tasteless noble gas.\n"            \
      "It occurs in trace amounts in the atmosphere.\n"                     \
      "It is isolated by fractionally distilling liquefied air.\n"          \
      "Krypton is often used with other rare gases in fluorescent lamps.\n"
    }
    let(:text_blanklines) {
      "Krypton (from Greek: κρυπτός kryptos 'the hidden one').\n\n"     \
      "It is a chemical element with symbol Kr and atomic number 36.\n" \
      "It is a member of group 18 (noble gases) elements.\n\n"          \
      "-- Wikipedia"
    }
    let(:text_line_objects) {
      [
        Vedeu::Line.new({ streams: [Vedeu::Stream.new({ value: "Krypton is a colorless, odorless, tasteless noble gas." })] }),
        Vedeu::Line.new({ streams: [Vedeu::Stream.new({ value: "It occurs in trace amounts in the atmosphere." })] }),
        Vedeu::Line.new({ streams: [Vedeu::Stream.new({ value: "It is isolated by fractionally distilling liquefied air." })] }),
        Vedeu::Line.new({ streams: [Vedeu::Stream.new({ value: "Krypton is often used with other rare gases in fluorescent lamps." })] })
      ]
    }

    describe '#initialize' do
      it { instance.must_be_instance_of(described) }
      it { instance.instance_variable_get('@text').must_equal(text) }
      it { instance.instance_variable_get('@options').must_equal(options) }
    end

    describe '#prune' do
      let(:text) { text_line }

      subject { instance.prune }

      context 'when the text is <= the pruning width' do
        let(:width) { 80 }

        it { subject.must_be_instance_of(String) }

        it { subject.must_equal(
          "Krypton (from Greek: κρυπτός kryptos 'the hidden one')."
        ) }
      end

      context 'when the text is > the pruning width' do
        context 'with a single line of text' do
          it { subject.must_equal("Krypton (from Greek: κρυπτός...") }
        end

        context 'with a text block' do
          let(:text) { text_block }

          it { subject.must_equal("Krypton (from Greek: κρυπτός...") }
        end

        context 'with a text block containing newlines' do
          let(:text) { text_newlines }

          it { subject.must_equal([
              "Krypton is a colorless, odor...",
              "It occurs in trace amounts i...",
              "It is isolated by fractional...",
              "Krypton is often used with o..."
            ])
          }
        end

        context 'with a text block containing newlines and blank lines' do
          let(:text) { text_blanklines }

          it { subject.must_equal([
            "Krypton (from Greek: κρυπτός...",
            "",
            "It is a chemical element wit...",
            "It is a member of group 18 (...",
            "",
            "-- Wikipedia..."
            ])
          }
        end
      end
    end

    describe '#wrap' do
      subject { instance.wrap }

      context 'with a single line of text' do
        let(:text) { text_line }

        it { subject.must_equal([
            "Krypton (from Greek: κρυπτός",
            "kryptos 'the hidden one')."
          ])
        }
      end

      context 'with a text block' do
        let(:text) { text_block }

        it { subject.must_equal([
          "Krypton (from Greek: κρυπτός",
          "kryptos 'the hidden one') is",
          "a chemical element with",
          "symbol Kr and atomic number",
          "36. It is a member of group",
          "18 (noble gases) elements."
          ])
        }
      end

      context 'with a text block containing newlines' do
        let(:text) { text_newlines }

        it { subject.must_equal([
          "Krypton is a colorless,",
          "odorless, tasteless noble",
          "gas.",
          "It occurs in trace amounts",
          "in the atmosphere.",
          "It is isolated by",
          "fractionally distilling",
          "liquefied air.",
          "Krypton is often used with",
          "other rare gases in",
          "fluorescent lamps."
          ])
        }
      end

      context 'with a text block containing newlines and blank lines' do
        let(:text) { text_blanklines }

        it { subject.must_equal([
          "Krypton (from Greek: κρυπτός",
          "kryptos 'the hidden one').",
          "",
          "It is a chemical element",
          "with symbol Kr and atomic",
          "number 36.",
          "It is a member of group 18",
          "(noble gases) elements.",
          "",
          "-- Wikipedia"
          ])
        }
      end
    end

    describe '#content' do
      subject { instance.content }

      it { subject.must_be_instance_of(Vedeu::Lines) }

      context 'with a single line of text' do
        let(:text) { text_line }

        it { subject.size.must_equal(1) }
      end

      context 'with a text block' do
        let(:text) { text_block }

        it { subject.size.must_equal(1) }
      end

      context 'with a text block containing newlines' do
        let(:text) { text_newlines }

        it { subject.size.must_equal(4) }
      end

      context 'with a text block containing newlines and blank lines' do
        let(:text) { text_blanklines }

        it { subject.size.must_equal(6) }
      end

      context 'when mode: :prune' do
        let(:mode) { :prune }

        context 'with a single line of text' do
          let(:text) { text_line }

          it { subject.size.must_equal(1) }
        end

        context 'with a text block' do
          let(:text) { text_block }

          it { subject.size.must_equal(1) }
        end

        context 'with a text block containing newlines' do
          let(:text) { text_newlines }

          it { subject.size.must_equal(4) }
        end

        context 'with a text block containing newlines and blank lines' do
          let(:text) { text_blanklines }

          it { subject.size.must_equal(6) }
        end
      end

      context 'when mode: :wrap' do
        let(:mode) { :wrap }

        context 'with a single line of text' do
          let(:text) { text_line }

          it { subject.size.must_equal(2) }
        end

        context 'with a text block' do
          let(:text) { text_block }

          it { subject.size.must_equal(6) }
        end

        context 'with a text block containing newlines' do
          let(:text) { text_newlines }

          it { subject.size.must_equal(11) }
        end

        context 'with a text block containing newlines and blank lines' do
          let(:text) { text_blanklines }

          it { subject.size.must_equal(10) }
        end
      end
    end

  end # Wordwrap

end # Vedeu
