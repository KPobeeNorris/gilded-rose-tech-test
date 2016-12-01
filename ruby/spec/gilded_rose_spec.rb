require './gilded_rose.rb'

describe GildedRose do

  describe "#update_quality" do

    it "does not change the name" do
      items = [Item.new("magic stuff", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "magic stuff"
    end

    it 'does not allow an item to have a quality score greater than 50' do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 49)]
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it 'does not allow an item to have a negative quality score' do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "allows 'Aged Brie' to increase in quality the older it gets" do
      items = [Item.new("Aged Brie", 3, 30)]
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 32
    end

    it "allows 'Backstage Passes' to have it's quality increase by 2 when less than 10 days, but more than 5, as the sellin value approaches" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 12
    end

    it "allows 'Backstage Passes' to have it's quality increase by in quality by 3 when there are 5 days or less left" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 13
    end

    it " has a quality of zero after the concert for 'Backstage Passes' has taken place" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 30)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it "does not expect 'Sulfuras' to ever be sold, or it's quality decrease" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 30)]
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 30
    end

    it "'Aged Brie' continues to increase in quality the older it gets" do
      items = [Item.new("Aged Brie", 0, 10)]
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 16
    end

  end
end
