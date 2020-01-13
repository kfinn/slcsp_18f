require 'models/slcsp'
require 'models/plan'
require 'models/zip'

RSpec.describe SLCSP do
  describe '#rate' do
    let(:slcsp) do
      SLCSP.new(zipcode: slcsp_zipcode, rate: '')
    end

    let(:zip_11111) do
      Zip.new(zipcode: '11111', rate_area: '123')
    end

    let(:zip_22222) do
      Zip.new(zipcode: '22222', rate_area: '234')
    end

    let(:first_11111_silver_plan) do
      Plan.new(rate_area: '123', rate: '200', metal_level: 'Silver')
    end

    let(:second_11111_silver_plan) do
      Plan.new(rate_area: '123', rate: '400', metal_level: 'Silver')
    end

    let(:third_11111_silver_plan) do
      Plan.new(rate_area: '123', rate: '300', metal_level: 'Silver')
    end

    let(:first_silver_22222_plan) do
      Plan.new(rate_area: '234', rate: '400', metal_level: 'Silver')
    end

    let(:non_silver_11111_plan) do
      Plan.new(rate_area: '123', rate: '250', metal_level: 'Bronze')
    end

    before do
      allow(Plan).to receive(:all) do
        [
          first_11111_silver_plan,
          non_silver_11111_plan,
          second_11111_silver_plan,
          third_11111_silver_plan,
          first_silver_22222_plan
        ]
      end
      allow(Zip).to receive(:all) { [zip_11111, zip_22222] }
    end

    context 'with a zipcode that has many plans' do
      let(:slcsp_zipcode) { '11111' }

      it 'equals the second lowest cost silver plan rate' do
        expect(slcsp.rate).to eq '300'.to_d
      end
    end

    context 'with a zipcode that has fewer than two silver plans' do
      let(:slcsp_zipcode) { '22222' }

      it 'is nil' do
        expect(slcsp.rate).to be_nil
      end
    end
  end

  describe '#to_csv_row' do
    context 'when rate is nil' do
      let(:slcsp) { SLCSP.new(zipcode: '33333', rate: nil) }

      it 'includes the zip and a completely empty cell for the rate' do
        expect(slcsp.to_csv_row).to eq '33333,'
      end
    end
  end
end
