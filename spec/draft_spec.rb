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
    it 'returns 9 item_lists' do
      expect(d.item_lists.length).to eq 9
    end
  end

  describe '#item_list_category' do
    it 'returns "Belgian" for first category' do
      item_list = d.item_lists[0]
      expect(d.item_list_category(item_list)).to eq('Belgian')
    end

    it 'returns "Pales, IPAs, Imperial IPAs" for second category' do
      item_list = d.item_lists[1]
      expect(d.item_list_category(item_list)).to eq('Pales, IPAs, Imperial IPAs')
    end
  end

  describe '#items' do
    it 'returns 9 items for first category' do
      item_list = d.item_lists[0]
      expect( d.items(item_list).length ).to eq 9
    end
  end

  describe '#item_title' do
    it 'returns "Tripel de Ripple – $5"' do
      item = d.items( d.item_lists[0] )[0]
      expect( d.item_title(item) ).to eq "Tripel de Ripple – $5"
    end
  end

  describe '#item_brewery' do
    it 'returns "Brugge Brasserie"' do
      item = d.items( d.item_lists[0] )[0]
      expect( d.item_brewery(item) ).to eq "Brugge Brasserie"
    end
  end

  describe '#item_location' do
    it 'returns "Indianapolis, IN"' do
      item = d.items( d.item_lists[0] )[0]
      expect( d.item_location(item) ).to eq "Indianapolis, IN"
    end
  end

  describe '#item_abv' do
    it 'returns "10%"' do
      item = d.items( d.item_lists[0] )[0]
      expect( d.item_abv(item) ).to eq "10%"
    end
  end

  describe '#item_style' do
    it 'returns "Belgian-Style Tripel"' do
      item = d.items( d.item_lists[0] )[0]
      expect( d.item_style(item) ).to eq "Belgian-Style Tripel"
    end
  end

  describe '#item_to_hash' do
    it 'returns the correct hash' do
      item = d.items( d.item_lists[0] )[0]
      expected = {
          title:    "Tripel de Ripple – $5",
          brewery:  "Brugge Brasserie",
          location: "Indianapolis, IN",
          abv:      "10%",
          style:    "Belgian-Style Tripel"
      }
      expect( d.item_to_hash(item) ).to eq expected
    end
  end

end