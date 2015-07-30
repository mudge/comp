require 'comp/proc'

RSpec.describe Proc do
  describe '#*' do
    it 'composes two Procs together' do
      increment = proc { |x| x + 1 }
      double = proc { |x| x * 2 }
      increment_and_double = double * increment

      expect(increment_and_double.call(1)).to eq(4)
    end

    it 'passes multiple arguments to g' do
      add = proc { |x, y| x + y }
      double = proc { |x| x * 2 }
      add_and_double = double * add

      expect(add_and_double.call(1, 2)).to eq(6)
    end

    it 'passes blocks to g' do
      add = proc { |x, &blk| x + blk.call }
      double = proc { |x| x * 2 }
      add_and_double = double * add

      expect(add_and_double.call(1) { 3 }).to eq(8)
    end

    it 'returns a lambda if f is a lambda' do
      increment = proc { |x| x + 1 }
      double = lambda { |x| x * 2 }

      expect(double * increment).to be_lambda
    end

    it 'composes anything that responds to call' do
      incrementer = Class.new do
        def call(x)
          x + 1
        end
      end

      triple = lambda { |x| x * 3 }
      increment_and_triple = triple * incrementer.new

      expect(increment_and_triple.call(1)).to eq(6)
    end
  end
end
