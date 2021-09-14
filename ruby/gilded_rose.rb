# frozen_string_literal: true
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      quality_aging(item)
      item.sell_in = item.sell_in - 1 if item.name != 'Sulfuras, Hand of Ragnaros'
      sell_negative(item)
    end
  end

  def sell_negative(item)
    if item.sell_in.negative?
      if item.name != 'Aged Brie'
        if item.name != 'Backstage passes to a TAFKAL80ETC concert'
          item.quality = item.quality - 1 if item.quality.positive? && (item.name != 'Sulfuras, Hand of Ragnaros')
        else
          item.quality = item.quality - item.quality
        end
      elsif item.quality < 50
        item.quality = item.quality + 1
      end
    end
  end

  def quality_aging(item)
    return quality(item) if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')

    if item.quality < 50
      item.quality = item.quality + 1
      return met_2(item) if item.name == 'Backstage passes to a TAFKAL80ETC concert'
    end
  end

  def quality(item)
    item.quality = item.quality - 1 if item.quality.positive? && (item.name != 'Sulfuras, Hand of Ragnaros')
  end
  
  def met_2(item)
    item.quality = item.quality + 1 if item.sell_in < 11 && (item.quality < 50)
    item.quality = item.quality + 1 if item.sell_in < 6 && (item.quality < 50)
  end

end



class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
