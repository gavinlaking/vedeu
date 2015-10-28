require 'benchmark/ips'

module Vedeu

  module Logging

    module Debug

      class IPS

        attr_accessor :samples
        attr_accessor :benchmark

        def initialize
          @old_stdout = $stdout
          $stdout     = StringIO.new
          @samples    = {}
          @benchmark  = Benchmark::IPS::Job.new
          @count      = 0
        end

        def add_item(label = '', &blk)
          samples[label] = blk
          @count += 1

          benchmark.item(label, &blk)
        end

        def execute!
          benchmark.compare!
          benchmark.run_warmup
          benchmark.run

          $stdout.sync = true
          benchmark.run_comparison
          benchmark.full_report

          Vedeu.log(type: :debug, message: "IPS:\n#{$stdout.string}")
          $stdout = @old_stdout

          Vedeu.log(type: :debug, message: "Running: #{key}")
          samples[key].call
        end

        private

        def key
          @key ||= samples.keys.sample
        end

      end # IPS

    end # Debug

  end # Logging

end # Vedeu
