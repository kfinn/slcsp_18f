require 'models/zip'

RSpec.describe Zip do
  describe '.find_by_zipcode' do
    let(:first_zip) do
      Zip.new(zipcode: '00001')
    end

    let(:second_zip) do
      Zip.new(zipcode: '00002')
    end

    before do
      allow(Zip).to receive(:all) { [first_zip, second_zip] }
    end

    it 'returns a single matching zip when a zip with that zipcode exists' do
      expect(Zip.find_by_zipcode('00001')).to eq first_zip
    end

    it 'returns nil when the zipcode does not exist' do
      expect(Zip.find_by_zipcode('00003')).to be_nil
    end
  end
end
