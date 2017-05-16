require 'gilded_rose'
require_relative '../lib/item.rb'

describe GildedRose do
  let(:items) {
    # name, sell in, quality
    [
      # items[0]
      Item.new("widget", 10, 5),
      # items[1]
      Item.new("out-of-date", -1, 10),
      # items[2]
      Item.new("Aged Brie", 10, 5),
      # items[3]
      Item.new("Sulfuras, Hand of Ragnaros", 10, 5),
      # items[4]
      Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 5),
      # items[5]
      Item.new("Conjured", 10, 5),
      # items[6]
      Item.new("over-quality", 10, 60),
      # items[7]
      Item.new("zero-quality", 0, 0)
    ]}

  subject(:rose) { described_class.new(items) }


  describe '#update_quality' do
    xit 'quality is never above 50' do
      rose.update_quality
      expect(rose.items[6].quality).to eq(50)
    end

    it 'quality is never negative' do
      rose.update_quality
      expect(rose.items[7].quality).to eq(0)
    end

    context 'non-special items' do
        it 'automatically updates quality by -1' do
          expect{ rose.update_quality }.to change{ rose.items[0].quality }.by(-1)
        end

        it 'automatically updates sell_in by -1' do
          expect{ rose.update_quality }.to change{ rose.items[0].quality }.by(-1)
        end

      describe 'sell by date' do
        it 'once passed, quality degrades twice as fast' do
          expect{ rose.update_quality }.to change{ rose.items[1].quality }.by(-2)
        end
      end
    end

    context 'special items' do
      describe 'Aged Brie' do
        it 'increases in quality the older it gets' do
          expect{ rose.update_quality }.to change{ rose.items[2].quality }.by(1)
        end
      end

      describe 'Backstage passes to a TAFKAL80ETC concert' do
        context '>10 days before sell_in date' do
          it 'increases in quality by 1' do
            expect{ rose.update_quality }.to change{ rose.items[4].quality }.by(1)
          end
        end

        context '10 > days > 5' do
          it 'increases in quality by 2' do
            rose.items[4].sell_in = 7
            expect{ rose.update_quality }.to change{ rose.items[4].quality}.by(2)
          end
        end

        context '5 > days > 0' do
          it 'increases in quality by 3' do
            rose.items[4].sell_in = 3
            expect{ rose.update_quality }.to change{ rose.items[4].quality }.by(3)
          end
        end

        context 'after sell_in date' do
          it 'quality drops to 0' do
            rose.items[4].sell_in = -1
            rose.update_quality
            expect(rose.items[4].quality).to eq(0)
          end
        end
      end

      describe 'Legendary item - Sulfuras' do
        it 'never has to be sold' do
          expect{ rose.update_quality }.to change{ rose.items[3].sell_in }.by(0)
        end

        it 'never decreases in Quality' do
          expect{ rose.update_quality }.to change{ rose.items[3].quality }.by(0)
        end
      end

      xdescribe 'Conjured items' do
        it 'degrade in Quality twice as a fast as normal items' do
          expect{ rose.update_quality }.to change{ rose.items[5].quality }.by(-2)
        end
      end
    end
  end

  describe '#check_quality_limits' do
    it 'cannot be above 50' do
      item = items[0]
      item.quality = 51
      rose.check_quality_limits(item)
      expect(item.quality).to eq(50)
    end

    it 'cannot be negative' do
      item = items[0]
      item.quality = -1
      rose.check_quality_limits(item)
      expect(item.quality).to eq(0)
    end
  end

  describe '#update_sell_in' do
    it 'updates sell_in by -1' do
      item = items[0]
      expect{ rose.update_sell_in(item) }.to change{ item.sell_in }.by(-1)
    end
  end

  describe 'item check' do
    describe '#is_aged_brie' do
      it 'returns true if item is aged brie' do
        item = items[2]
        expect(rose.is_aged_brie(item)).to eq(true)
      end
    end

    describe '#is_Sulfuras' do
      it 'returns true if item is Sulfuras' do
        item = items[3]
        expect(rose.is_Sulfuras(item)).to eq(true)
      end
    end

    describe '#is_backstage_pass' do
      it 'returns true if item is Backstage pass' do
        item = items[4]
        expect(rose.is_backstage_pass(item)).to eq(true)
      end
    end
  end

  describe '#update_aged brie' do
    it 'increases in quality the older it gets' do
      item = items[2]
      expect{ rose.update_aged_brie(item) }.to change{ item.quality }.by(1)
    end
  end

  describe '#update_Sulfuras' do
    it 'never has to be sold' do
      item = items[3]
      expect{ rose.update_Sulfuras(item) }.to change{ item.sell_in }.by(0)
    end

    it 'never decreases in quality' do
      item = items[3]
      expect{ rose.update_Sulfuras(item) }.to change{ item.quality }.by(0)
    end
  end

  describe '#update_backstage_pass' do
    context '>10 days before sell_in date' do
      it 'increases in quality by 1' do
        item = items[4]
        expect{ rose.update_backstage_pass(item) }.to change{ item.quality }.by(1)
      end
    end

    context '10 > days > 5' do
      it 'increases in quality by 2' do
        item = items[4]
        item.sell_in = 7
        expect{ rose.update_backstage_pass(item) }.to change{ item.quality }.by(2)
      end
    end

    context '5 > days > 0' do
      it 'increases in quality by 3' do
        item = items[4]
        item.sell_in = 3
        expect{ rose.update_backstage_pass(item) }.to change{ item.quality }.by(3)
      end
    end

    context 'after sell_in date' do
      it 'quality drops to 0' do
        item = items[4]
        item.sell_in = -2
        rose.update_backstage_pass(item)
        expect(item.quality).to eq(0)
      end
    end

  end

end
