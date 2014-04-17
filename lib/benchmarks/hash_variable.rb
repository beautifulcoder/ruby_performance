require 'benchmark'

module Benchmarks
  module HashVariable
    def self.run
      b = LabRat.get_binding
      Benchmark.bm do |bench|
        bench.report "create #{Benchmarks::T_DATA} local hashes" do
          Benchmarks::T_DATA.times do
            name = get_unique_name
            eval("#{name} = {}; #{name}[:h_key] = 1", b)
          end
        end
      end
      lharr = eval("local_variables", b)
      Benchmark.bm do |bench|
        bench.report "retrieve #{Benchmarks::T_DATA} local hashes" do
          Benchmarks::T_DATA.times do
            name = eval("#{lharr.sample}", b)
            eval("#{name}[:h_key]", b)
          end
        end
      end

      o = LabRat.new
      Benchmark.bm do |bench|
        bench.report "create #{Benchmarks::T_DATA} instance hashes" do
          Benchmarks::T_DATA.times do
            name = get_unique_name
            o.instance_eval("@#{name} = {}; @#{name}[:h_key] = 1")
          end
        end
      end
      iharr = o.instance_variables
      Benchmark.bm do |bench|
        bench.report "retrieve #{Benchmarks::T_DATA} instance hashes" do
          Benchmarks::T_DATA.times do
            o.instance_eval("#{iharr.sample}[:h_key]")
          end
        end
      end

      Benchmark.bm do |bench|
        bench.report "create #{Benchmarks::T_DATA} class hashes" do
          Benchmarks::T_DATA.times do
            name = get_unique_name
            LabRat.class_eval("@@#{name} = {}; @@#{name}[:h_key] = 1")
          end
        end
      end
      charr = LabRat.class_variables
      Benchmark.bm do |bench|
        bench.report "retrieve #{Benchmarks::T_DATA} class hashes" do
          Benchmarks::T_DATA.times do
            LabRat.class_eval("#{charr.sample}[:h_key]")
          end
        end
      end
    end
  end
end
