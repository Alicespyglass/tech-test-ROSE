# repeated commands to play in pry

require './lib/gilded_rose.rb'
require './lib/item.rb'


widget = Item.new("widget", 3, 55)
bauble = Item.new("Sulfuras, Hand of Ragnaros", 10, 20)
items = [widget, bauble]
rose = GildedRose.new(items)
