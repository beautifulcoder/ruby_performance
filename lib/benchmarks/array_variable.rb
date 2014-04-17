require 'benchmark'

module Benchmarks
  module ArrayVariable
    def self.run
      b = LabRat.get_binding
      Benchmark.bm do |bench|
        bench.report "create #{Benchmarks::T_DATA} local arrays" do
          Benchmarks::T_DATA.times do
            name = get_unique_name
            eval("#{name} = []; #{name} << 1", b)
          end
        end
      end
      laarr = eval("local_variables", b)
      Benchmark.bm do |bench|
        bench.report "retrieve #{Benchmarks::T_DATA} local arrays" do
          Benchmarks::T_DATA.times do
            name = eval("#{laarr.sample}", b)
            eval("#{name}[0]", b)
          end
        end
      end

      o = LabRat.new
      Benchmark.bm do |bench|
        bench.report "create #{Benchmarks::T_DATA} instance arrays" do
          Benchmarks::T_DATA.times do
            name = get_unique_name
            o.instance_eval("@#{name} = []; @#{name} << 1")
          end
        end
      end
      iaarr = o.instance_variables
      Benchmark.bm do |bench|
        bench.report "retrieve #{Benchmarks::T_DATA} instance arrays" do
          Benchmarks::T_DATA.times do
            o.instance_eval("#{iaarr.sample}[0]")
          end
        end
      end

      Benchmark.bm do |bench|
        bench.report "create #{Benchmarks::T_DATA} class arrays" do
          Benchmarks::T_DATA.times do
            name = get_unique_name
            LabRat.class_eval("@@#{name} = []; @@#{name} << 1")
          end
        end
      end
      caarr = LabRat.class_variables
      Benchmark.bm do |bench|
        bench.report "retrieve #{Benchmarks::T_DATA} class arrays" do
          Benchmarks::T_DATA.times do
            LabRat.class_eval("#{caarr.sample}[0]")
          end
        end
      end
    end
  end
end
