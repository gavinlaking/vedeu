require 'test_helper'

module Vedeu

  describe Wordwrap do

    let(:described) { Vedeu::Wordwrap }
    let(:instance)  { described.new(text, options) }
    let(:text)      { '' }
    let(:options)   {
      {
        ellipsis: '...',
        width:    width,
      }
    }
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
        Vedeu::Line.new("Krypton is a colorless, odorless, tasteless noble gas."),
        Vedeu::Line.new("It occurs in trace amounts in the atmosphere."),
        Vedeu::Line.new("It is isolated by fractionally distilling liquefied air."),
        Vedeu::Line.new("Krypton is often used with other rare gases in fluorescent lamps.")
      ]
    }

    describe '#initialize' do
      subject { instance }

      it { subject.must_be_instance_of(described) }
      it { subject.instance_variable_get('@text').must_equal(text) }
      it { subject.instance_variable_get('@options').must_equal(options) }
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

        context 'with a text block made up of Vedeu::Line objects' do
          let(:text) { text_line_objects }

          it { skip; subject.must_equal(
            ""
          ) }
        end

      end
    end

    describe '#wrap' do
      subject { instance.wrap }

      context 'with a single line of text' do
        let(:text) { text_line }

        it { subject.must_equal(
          "Krypton (from Greek: κρυπτός\nkryptos 'the hidden one')."
        ) }
      end

      context 'with a text block' do
        let(:text) { text_block }

        it { subject.must_equal(
          "Krypton (from Greek: κρυπτός\n" \
          "kryptos 'the hidden one') is\n" \
          "a chemical element with\n"      \
          "symbol Kr and atomic number\n"  \
          "36. It is a member of group\n"  \
          "18 (noble gases) elements."
        ) }
      end

      context 'with a text block containing newlines' do
        let(:text) { text_newlines }

        it { subject.must_equal(
          "Krypton is a colorless,\n"    \
          "odorless, tasteless noble\n"  \
          "gas.\n"                       \
          "It occurs in trace amounts\n" \
          "in the atmosphere.\n"         \
          "It is isolated by\n"          \
          "fractionally distilling\n"    \
          "liquefied air.\n"             \
          "Krypton is often used with\n" \
          "other rare gases in\n"        \
          "fluorescent lamps."
        ) }
      end

      context 'with a text block containing newlines and blank lines' do
        let(:text) { text_blanklines }

        it { subject.must_equal(
          "Krypton (from Greek: κρυπτός\n" \
          "kryptos 'the hidden one').\n"   \
          "\n"                             \
          "It is a chemical element\n"     \
          "with symbol Kr and atomic\n"    \
          "number 36.\n"                   \
          "It is a member of group 18\n"   \
          "(noble gases) elements.\n"      \
          "\n"                             \
          "-- Wikipedia"
        ) }
      end

      context 'with a text block made up of Vedeu::Line objects' do
        let(:text) { text_line_objects }

        it { skip; subject.must_equal("") }
      end
    end

    describe '#prune_as_lines' do
      subject { instance.prune_as_lines }

      context 'with a single line of text' do
        let(:text) { text_line }

        it { skip; subject.must_equal(
          ""
        ) }
      end

      context 'with a text block' do
        let(:text) { text_block }

        it { skip; subject.must_equal(
          ""
        ) }
      end

      context 'with a text block containing newlines' do
        let(:text) { text_newlines }

        it { skip; subject.must_equal(
          ""
        ) }
      end

      context 'with a text block containing newlines and blank lines' do
        let(:text) { text_blanklines }

        it { skip; subject.must_equal(
          ""
        ) }
      end

      context 'with a text block made up of Vedeu::Line objects' do
        let(:text) { text_line_objects }

        it { skip; subject.must_equal(
          ""
        ) }
      end
    end

    describe '#wrap_as_lines' do
      subject { instance.wrap_as_lines }

      context 'with a single line of text' do
        let(:text) { text_line }

        it { skip; subject.must_equal(
          ""
        ) }
      end

      context 'with a text block' do
        let(:text) { text_block }

        it { skip; subject.must_equal(
          ""
        ) }
      end

      context 'with a text block containing newlines' do
        let(:text) { text_newlines }

        it { skip; subject.must_equal(
          ""
        ) }
      end

      context 'with a text block containing newlines and blank lines' do
        let(:text) { text_blanklines }

        it { skip; subject.must_equal(
          ""
        ) }
      end

      context 'with a text block made up of Vedeu::Line objects' do
        let(:text) { text_line_objects }

        it { skip; subject.must_equal(
          ""
        ) }
      end
    end

  end # Wordwrap

end # Vedeu
