require 'test_helper'

module Vedeu

  module Templating

    class HelpersTestClass

      include Vedeu::Templating::Helpers

    end

    describe Helpers do

      let(:described) { Vedeu::Templating::Helpers }
      let(:instance)  { Vedeu::Templating::HelpersTestClass.new }

      describe '#background' do
        let(:expected) {
          "{{eJx1UE1rAjEQ7UGiNbEI7aX0oKx/wPPsZVAs7E1QvMfdaVlcNyWZtEr/fLPRdUHoXDLDm/eR6Q0MvO6oIA+wK+nHAWzYkj4qGKNmtuXeM7lfCTKvSqp5HhpTGW8NvF15yzi7tukH5l7nh09rfF0YmNyvLW6gAIUXtSxRs3ksAWK1DRIfxtK/Eu83UKQqSx5EOtqC/NI2Jhw6PlfU0daWXAA0l6Zu/hdAARK/deUpbMc3S1660FOmE0fNx1ofqTUIYS83SBX2w9T6SYyGqNJnHMEQGw4+/QF64W6r}}"
        }

        subject { instance.background('#000000') { 'background text' } }

        it { instance.must_respond_to(:bg) }

        it { subject.must_equal(expected) }
      end

      describe '#colour' do
        let(:attributes) { {} }

        subject { instance.colour(attributes) { 'colour text' } }

        context 'with no attributes' do
          it { subject.must_be_instance_of(String) }
        end

        context 'with a background attribute' do
          let(:attributes) {
            {
              background: '#002200'
            }
          }
          let(:expected) {
            "{{eJx1j09rAjEQxXso0ZooQk/Sg2X9AsHj7GVoqbC3guI96lQW140kk/7BL2/MdhUETzPDm/ebN49dC6MlbSgALEv68QBzdmT2CoZomF25Ckz+KEGuq5Jq1rGxlQ3Owsu/7z3Nvm060bky693W2VBvLIxv194uogCFDa3I1ETr6VRrAeJjERFf1tFdxOwiilwV2YPI+wuQB+NSwp7nv4qutk9HPgqGS1uf/4uiAInfpgoUt1MtsmGT5JXplxPvqTZ7auExaPN/rrATp/aWxHQMVf6Mfejh2YODE6SObR8=}}"
          }

          it { subject.must_equal(expected) }
        end

        context 'with a foreground attribute' do
          let(:attributes) {
            {
              foreground: '#ff0000'
            }
          }
          let(:expected) {
            "{{eJx1j09rAjEQxXuQaE0UoSfpoWX7BTzPXgaLhb0VFO9RZ8vSdVOSSVX65Tub9Q8Umkvm8eY386Y3cDBd044iwLqiQwBYsie7NzBBy+yrTWQKPxr0tq6o4ZkUrnbRO3g8c69Jh0vRF3Jjt58f3sVm5+Dpb9v8aiow2E0rsjsFarEStnSe/mXfrqbKTZGZl7KcyVP5aAX6y/qUcBj4VNONfvcUxLBcuaa9T0wFGr9tHUm6019kky7JM9OR07z7xu6pDdYKCdrdnxvsi7rs0piWockfcARDbBkc/wISY22H}}"
          }

          it { subject.must_equal(expected) }
        end

        context 'with both attributes' do
          let(:attributes) {
            {
              background: '#000022',
              foreground: '#ff7700',
            }
          }
          let(:expected) {
            "{{eJx1UMFqAjEQ7aFEa6IIPUkPFf2BxYswexlaWvBWqHiPOiuL66Ykk2rpz3c2WxUKzSXz5s1785LbroPRirYUAVYlHQPAO3uyBwNDtMy+XEem8K1Bb6qSas6kcJWL3sHDr+454XAuOqJc281+512stw4e/449XUgFBlu3xcRMMzmzmQL1shSLwnn61+L1QqrcNNqimM+zTOX9JegP61PQXuCviq7qN09BCMulq5tnCqlA46etIsl0uheTYRtozHTi5HdX24P0bxKQvO035AY7gs67NKZlaPJ77EMPGw0OfgB4C27o}}"
          }

          it { subject.must_equal(expected) }
        end
      end

      describe '#foreground' do
        let(:expected) {
          "{{eJx1kMuKAjEQRV1IfCSK4GxkFkr7A66rN4XiQO8ExX3UmqGx7UhS8cH8/KTjC4TJJnW5depWUm8aGKxpRx5gndPZASzZkj4o6KFmtvnGM7lfCXJb5FTyJBSmMN4a+Lxzs6jdo2gEcqO3+x9rfLkzMHxvmz5NAQpv07KkJkDMV4H9Npb+Zb+epkhVlqjxJB6RdlYgj9rGDduOrwW96IUlFwzNuSmr9wVTgMSTLjyF7nhnyccreMR04TizVeoDVctVIix7+4NUYSOoR57EGIgq7WMH2lgx2P0DtPJuxg==}}"
        }

        subject { instance.foreground('#000000') { 'foreground text' } }

        it { instance.must_respond_to(:fg) }

        it { subject.must_equal(expected) }
      end

      describe '#style' do
        let(:expected) {
          "{{eJx1j0FLAzEQhT1IajepFTyJB0t/Qc+zl0Gp0Jtg6T3bnZal6U5JJrbinzebuhUEb/N48715c33D8LCimiLAqqFjAHgXT3Zv4A6tiG+qKBS+NOi1a6iVWRrYcfQMjz/cS9ahHwaJrOx6t/Uc25rh6e/a88VUYPCctpheKVDzZWI37Olf9vViqtJ0UDlagj5Yn6sVQT4d/WJvnkIyrDTcdo8lU4HGD+siwbBiV0ORxWI6zuhE6CQ5c9jaPfUHUsvz86XBQVL9PY2ZQlPe4wgK7Bi8/QYTK20c}}"
        }

        subject { instance.style(:bold) { 'style text' } }

        it { subject.must_equal(expected) }
      end

    end # ViewHelpers

  end # Templating

end # Vedeu
