require 'test_helper'

module Vedeu

  module Geometry

    describe XDimension do

      let(:described)  { Vedeu::Geometry::XDimension }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          d:                    d,
          dn:                   dn,
          d_dn:                 d_dn,
          default:              default,
          maximised:            maximised,
          centred:              centred,
          horizontal_alignment: horizontal_alignment,
          vertical_alignment:   vertical_alignment,
        }
      }
      let(:d)                    {}
      let(:dn)                   {}
      let(:d_dn)                 {}
      let(:default)              { Vedeu.width }
      let(:maximised)            {}
      let(:centred)              {}
      let(:horizontal_alignment) {}
      let(:vertical_alignment)   {}

      before do
        Vedeu.stubs(:width).returns(24)
      end

      describe '#pair' do
        subject { instance.pair }

        it { subject.must_be_instance_of(Array) }

        context 'with default attributes' do
          it { subject.must_equal([1, 24]) }
        end

        context 'when maximised' do
          let(:maximised) { true }

          it { subject.must_equal([1, 24]) }
        end

        context 'when centre aligned' do
          let(:horizontal_alignment) { :centre }

          it { subject.must_equal([1, 24]) }
        end

        context 'when left aligned' do
          let(:horizontal_alignment) { :left }

          it { subject.must_equal([1, 24]) }
        end

        context 'when right aligned' do
          let(:horizontal_alignment) { :right }

          it { subject.must_equal([1, 24]) }
        end
      end

    end # XDimension

  end # Geometry

end # Vedeu
