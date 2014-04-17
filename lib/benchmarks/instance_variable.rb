require 'benchmark'

module Benchmarks
  module InstanceVariable
    def self.run
      o = LabRat.new
      Benchmark.bm do |bench|
        bench.report "create #{Benchmarks::T_DATA} instance variables" do
          Benchmarks::T_DATA.times do
            o.instance_eval("@#{get_unique_name} = 1")
          end
        end
      end

      ivarr = o.instance_variables
      Benchmark.bm do |bench|
        bench.report "retrieve #{Benchmarks::T_DATA} instance variables" do
          Benchmarks::T_DATA.times do
            o.instance_eval("#{ivarr.sample}")
          end
        end
      end
    end
  end
end
