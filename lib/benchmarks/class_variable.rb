require 'benchmark'

module Benchmarks
  module ClassVariable
    def self.run
      Benchmark.bm do |bench|
        bench.report "create #{Benchmarks::T_DATA} class variables" do
          Benchmarks::T_DATA.times do
            LabRat.class_eval("@@#{get_unique_name} = 1")
          end
        end
      end

      cvarr = LabRat.class_variables
      Benchmark.bm do |bench|
        bench.report "retrieve #{Benchmarks::T_DATA} class variables" do
          Benchmarks::T_DATA.times do
            LabRat.class_eval("#{cvarr.sample}")
          end
        end
      end
    end
  end
end
