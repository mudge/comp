require 'comp/method'

RSpec.describe Method do
  describe '#*' do
    it 'composes two Methods together' do
      number = Class.new do
        def increment(x)
          x + 1
        end

        def double(x)
          x * 2
        end
      end
      increment = number.new.method(:increment)
      double = number.new.method(:double)
      increment_and_double = double * increment

      expect(increment_and_double.call(1)).to eq(4)
    end

    it 'passes multiple arguments to g' do
      number = Class.new do
        def add(x, y)
          x + y
        end

        def double(x)
          x * 2
        end
      end
      add = number.new.method(:add)
      double = number.new.method(:double)
      add_and_double = double * add

      expect(add_and_double.call(1, 2)).to eq(6)
    end

    it 'passes blocks to g' do
      number = Class.new do
        def add(x, &blk)
          x + blk.call
        end

        def double(x)
          x * 2
        end
      end
      add = number.new.method(:add)
      double = number.new.method(:double)
      add_and_double = double * add

      expect(add_and_double.call(1) { 3 }).to eq(8)
    end

    it 'composes anything that responds to call' do
      number = Class.new do
        def triple(x)
          x * 3
        end
      end
      incrementer = Class.new do
        def call(x)
          x + 1
        end
      end

      triple = number.new.method(:triple)
      increment_and_triple = triple * incrementer.new

      expect(increment_and_triple.call(1)).to eq(6)
    end
  end
end
