# repeated commands to play in pry

require './lib/gilded_rose.rb'
require './lib/item.rb'


widget = Item.new("widget", 3, 10)
rose = GildedRose.new(widget)
