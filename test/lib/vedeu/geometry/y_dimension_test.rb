require 'test_helper'

module Vedeu

  module Geometry

    describe YDimension do

      let(:described)  { Vedeu::Geometry::YDimension }
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
      let(:default)              { Vedeu.height }
      let(:maximised)            {}
      let(:centred)              {}
      let(:horizontal_alignment) {}
      let(:vertical_alignment)   {}

      before do
        Vedeu.stubs(:height).returns(12)
      end

      describe '#pair' do
        subject { instance.pair }

        it { subject.must_be_instance_of(Array) }

        context 'with default attributes' do
          it { subject.must_equal([1, 12]) }
        end

        context 'when maximised' do
          let(:maximised) { true }

          it { subject.must_equal([1, 12]) }
        end

        context 'when bottom aligned' do
          let(:vertical_alignment) { :bottom }

          it { subject.must_equal([1, 12]) }
        end

        context 'when middle aligned' do
          let(:vertical_alignment) { :middle }

          it { subject.must_equal([1, 12]) }
        end

        context 'when top aligned' do
          let(:vertical_alignment) { :top }

          it { subject.must_equal([1, 12]) }
        end
      end

    end # YDimension

  end # Geometry

end # Vedeu
