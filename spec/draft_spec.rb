describe Hopcat::Api::Draft do
	it { is_expected.to respond_to :list }
  it { is_expected.to respond_to :location }

  subject(:d) do
    d = Hopcat::Api::Draft.new
    d.location = File.join File.dirname(__FILE__), 'test.html'
    d
  end

  describe '#list' do
    it 'returns a hash' do
      expect(d.list).to be_a(Hash)
    end
  end

  describe '#item_lists' do
    it 'returns 12 item_lists' do
      expect(d.item_lists.length).to eq 12
    end
  end

  describe '#item_list_category' do
    it 'returns IPAs when category is IPAs' do
      item_list = d.item_lists[0]
      expect(d.item_list_category(item_list)).to eq('IPAs')
    end

    it 'returns Pales when category is Pales' do
      item_list = d.item_lists[1]
      expect(d.item_list_category(item_list)).to eq('Pales')
    end
  end

  describe '#items' do
    it 'returns 10 items' do
      item_list = d.item_lists[0]
      expect( d.items(item_list).length ).to eq 10
    end
  end

  describe '#item_title' do
    it 'returns "Campside – $5.5"' do
      item = d.items( d.item_lists[0] )[0]
      expect( d.item_title(item) ).to eq "Campside – $5.5"
    end
  end

  describe '#item_brewery' do
    it 'returns "Upland Brewing Co."' do
      item = d.items( d.item_lists[0] )[0]
      expect( d.item_brewery(item) ).to eq "Upland Brewing Co."
    end
  end

  describe '#item_location' do
    it 'returns "Bloomington, IN"' do
      item = d.items( d.item_lists[0] )[0]
      expect( d.item_location(item) ).to eq "Bloomington, IN"
    end
  end

  describe '#item_abv' do
    it 'returns "4.5%"' do
      item = d.items( d.item_lists[0] )[0]
      expect( d.item_abv(item) ).to eq "4.5%"
    end
  end

  describe '#item_style' do
    it 'returns "American Session IPA"' do
      item = d.items( d.item_lists[0] )[0]
      expect( d.item_style(item) ).to eq "American Session IPA"
    end
  end

  describe '#item_to_hash' do
    it 'returns the correct hash' do
      item = d.items( d.item_lists[0] )[0]
      expected = {
          title:    "Campside – $5.5",
          brewery:  "Upland Brewing Co.",
          location: "Bloomington, IN",
          abv:      "4.5%",
          style:    "American Session IPA"
      }
      expect( d.item_to_hash(item) ).to eq expected
    end
  end

  context 'when the style contains a page div' do
    describe '#item_style' do
      it 'returns a string w/o all those newlines' do
        item = d.items( d.item_lists[6] )[2]
        expect( d.item_style(item) ).to eq "Bourbon Barrel-Aged Vanilla Porter"
      end
    end
  end

end