class GildedRose

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case
      when is_aged_brie(item)
        update_aged_brie(item)
      when is_Sulfuras(item)
        update_Sulfuras(item)
      when is_backstage_pass(item)
        update_backstage_pass(item)
      end
      # if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
      #   if item.quality > 0
      #     if item.name != "Sulfuras, Hand of Ragnaros"
      #       item.quality = item.quality - 1
      #     end
      #   end
      # else
      #   if item.quality < 50
      #     item.quality = item.quality + 1
      #     if item.name == "Backstage passes to a TAFKAL80ETC concert"
      #       if item.sell_in < 11
      #         if item.quality < 50
      #           item.quality = item.quality + 1
      #         end
      #       end
      #       if item.sell_in < 6
      #         if item.quality < 50
      #           item.quality = item.quality + 1
      #         end
      #       end
      #     end
      #   end
      # end
      # if item.name != "Sulfuras, Hand of Ragnaros"
      #   item.sell_in = item.sell_in - 1
      # end
      # if item.sell_in < 0
      #   if item.name != "Aged Brie"
      #     if item.name != "Backstage passes to a TAFKAL80ETC concert"
      #       if item.quality > 0
      #         if item.name != "Sulfuras, Hand of Ragnaros"
      #           item.quality = item.quality - 1
      #         end
      #       end
      #     else
      #       item.quality = item.quality - item.quality
      #     end
      #   else
      #     if item.quality < 50
      #       item.quality = item.quality + 1
      #     end
      #   end
      # end
    end
  end

  def check_quality_limits(item)
    if item.quality > 50
      item.quality = 50
    elsif item.quality < 0
      item.quality = 0
    end
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end

  def is_aged_brie(item)
    item.name == "Aged Brie"
  end

  def update_aged_brie(item)
    update_sell_in(item)
    check_quality_limits(item)
    item.quality += 1
  end

  def is_Sulfuras(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def update_Sulfuras(item)
    check_quality_limits(item)
  end

  def is_backstage_pass(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def update_backstage_pass(item)
    if item.sell_in > 10
      item.quality += 1
    elsif item.sell_in > 5
      item.quality += 2
    elsif item.sell_in >= 0
      item.quality += 3
    else item.quality = 0
    end
  end

end
