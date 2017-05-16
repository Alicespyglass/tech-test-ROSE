# tech-test-ROSE

Practice day 2 - refactoring existing code

Refactoring the update_quality method which is currently a long smelly list of *if* statements. Parameters / logic cases below.

## Steps

- Play with GildedRose
- Play with creating items

- Check if cases are satisfied by existing code - feature  / unit tests on by update_quality method

###note to do
[] fails if item quality > 50
[] fails if item quality < 0

## Parameters / Logic
[] Once the sell by date has passed, Quality degrades twice as fast (test)
[] “Aged Brie” actually increases in Quality the older it gets (test)
[] “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality (test)
[] “Backstage passes”, like aged brie, increases in Quality as it’s SellIn value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert (test)
[] “Conjured” items degrade in Quality twice as fast as normal items
[] The Quality of an item is never more than 50
[] The Quality of an item is never negative


## Other learnings
- how to clone subdirectories of a repo
- how to tackle this error `fatal: CRLF would be replaced by LF`





## Resources

[Shout out to Emily who rewrote this test from C#](https://github.com/emilybache/GildedRose-Refactoring-Kata)
