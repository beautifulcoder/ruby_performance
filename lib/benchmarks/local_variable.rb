require 'benchmark'

module Benchmarks
  module LocalVariable
    def self.run
      b = LabRat.get_binding
      Benchmark.bm do |bench|
        bench.report "create #{Benchmarks::T_DATA} local variables" do
          Benchmarks::T_DATA.times do
            eval("#{get_unique_name} = 1", b)
          end
        end
      end

      lvarr = eval("local_variables", b)
      Benchmark.bm do |bench|
        bench.report "retrieve #{Benchmarks::T_DATA} local variables" do
          Benchmarks::T_DATA.times do
            eval("#{lvarr.sample}", b)
          end
        end
      end
    end
  end
end
