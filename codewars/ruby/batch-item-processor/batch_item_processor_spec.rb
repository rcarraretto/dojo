describe 'Basic' do

  it 'should process nothing' do
    p = BatchItemProcessor.new
    Test.assert_equals(p.processed_items, [])
  end

  it 'should process one group of items' do
    p = BatchItemProcessor.new
    p.process_items([1, 2]) {}
    Test.assert_equals(p.processed_items, [1, 2])
  end

  it 'should process two groups of items' do
    p = BatchItemProcessor.new
    p.process_items([1, 2]) {}
    p.process_items([3, 4]) {}
    Test.assert_equals(p.processed_items, [1, 2, 3, 4])
  end

  it 'should execute block' do
    p = BatchItemProcessor.new
    yields = []
    p.process_items([1, 2]) do |number|
      yields << number
    end
    Test.assert_equals(yields, [1, 2])
  end

  it 'should not process the same item twice (same call)' do
    p = BatchItemProcessor.new
    p.process_items([1, 1, 2]) {}
    Test.assert_equals(p.processed_items, [1, 2])
  end

  it 'should not process the same item twice (separate calls)' do
    p = BatchItemProcessor.new
    p.process_items([1, 2]) {}
    p.process_items([1, 4]) {}
    Test.assert_equals(p.processed_items, [1, 2, 4])
  end

  it 'should only execute block for processed items' do
    p = BatchItemProcessor.new
    yields = []
    p.process_items([1, 2]) do |number|
      yields << number
    end
    p.process_items([1, 4]) do |number|
      yields << number
    end
    Test.assert_equals(yields, [1, 2, 4])
  end
end

describe 'Identify' do

  it 'should identify a hash via key value' do
    p = BatchItemProcessor.new
    a = { 'id' => 1, 'name' => 'apples' }
    b = { 'id' => 1, 'name' => 'bananas' }
    c = { 'id' => 2, 'name' => 'apples' }
    p.identify('id')
    p.process_items([a, b, c]) {}
    Test.assert_equals(p.processed_items, [a, c])
  end

  it 'should identify a hash via symbol' do
    p = BatchItemProcessor.new
    a = { :id => 1, 'name' => 'apples' }
    b = { :id => 1, 'name' => 'bananas' }
    c = { :id => 2, 'name' => 'apples' }
    p.identify(:id)
    p.process_items([a, b, c]) {}
    Test.assert_equals(p.processed_items, [a, c])
  end

  it 'should identify an object via symbol' do
    class Something
      attr_reader :name
      def initialize(name)
        @name = name
      end
    end
    p = BatchItemProcessor.new
    a = Something.new('apples')
    b = Something.new('apples')
    c = Something.new('bananas')
    p.identify(:name)
    p.process_items([a, b, c]) {}
    Test.assert_equals(p.processed_items, [a, c])
  end

  it 'should identify across groups' do
    p = BatchItemProcessor.new
    a = { 'id' => 1, 'name' => 'apples' }
    b = { 'id' => 1, 'name' => 'bananas' }
    p.identify('id')
    p.process_items([a]) {}
    p.process_items([b]) {}
    Test.assert_equals(p.processed_items, [a])
  end
end

describe 'Should Process' do
  it 'should filter what is being processed' do
    p = BatchItemProcessor.new
    p.should_process do |item|
      item % 2 == 0
    end
    p.process_items([1, 2, 3, 4]) {}
    Test.assert_equals(p.processed_items, [2, 4])
  end
end

describe 'Reset' do

  it 'should do nothing when nothing was processed' do
    p = BatchItemProcessor.new
    p.reset
    Test.assert_equals(p.processed_items, [])
  end

  it 'should reset processed items' do
    p = BatchItemProcessor.new
    yields = []
    p.process_items([1, 2]) {}
    p.reset
    Test.assert_equals(p.processed_items, [])
  end

  it 'should allow item reprocess' do
    p = BatchItemProcessor.new
    yields = []
    p.process_items([1, 2]) do |number|
      yields << number
    end
    p.reset
    p.process_items([1, 4]) do |number|
      yields << number
    end
    Test.assert_equals(yields, [1, 2, 1, 4])
  end
end
