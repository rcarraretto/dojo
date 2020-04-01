class BatchItemProcessor
  attr_reader :processed_items

  def initialize
    @processed_items = []
    @id = nil
    @item_predicate = proc { |item| true }
  end

  def process_items(items)
    queued_items = assemble_queue(items)
    queued_items.each { |item| yield item }
    @processed_items.concat(queued_items)
  end

  def assemble_queue(items)
    items
      .select { |item| should_process?(item) && not_processed?(item) }
      .uniq { |item| identity(item) }
  end

  def not_processed?(item)
    @processed_items.find { |i| identity(i) == identity(item) }.nil?
  end

  def should_process(&block)
    @item_predicate = block
  end

  def should_process?(item)
    @item_predicate.call(item)
  end

  def identify(id)
    @id = id
  end

  def identity(item)
    return item if not @id
    return item[@id] if item.is_a?(Hash)
    item.send(@id)
  end

  def reset
    @processed_items = []
  end
end
