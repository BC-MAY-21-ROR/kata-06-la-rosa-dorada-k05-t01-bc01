require_relative 'array_texts'
include InstancePrices
#frozen_string_literal: true
class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      quality_aging(item)
      item.sell_in = item.sell_in - 1 if item.name != TEXTS['Sulfuras']
      sell_negative(item)
    end
  end

  def sell_negative(item)
    if item.sell_in.negative?
      if item.name != TEXTS['Aged']
        return (item.quality = item.quality - 1 if item.quality.positive? && (item.name != TEXTS['Sulfuras'])) if item.name != TEXTS['Backstage']
        return item.quality = item.quality - item.quality
      elsif item.quality < 50
        item.quality = item.quality + 1
      end
    end
  end

  def quality_aging(item)
    return quality(item) if (item.name != TEXTS['Aged']) && (item.name != TEXTS['Backstage'])
    if item.quality < 50
      item.quality = item.quality + 1
      return met_2(item) if item.name == TEXTS['Backstage']
    end
  end

  def quality(item)
    item.quality = item.quality - 1 if item.quality.positive? && (item.name != TEXTS['Sulfuras'])
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
