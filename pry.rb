# repeated commands to play in pry

require './lib/gilded_rose.rb'
require './lib/item.rb'


widget = Item.new("widget", 3, 10)
bauble = Item.new("bauble", 4, 20)
items = [widget, bauble]
rose = GildedRose.new(items)
