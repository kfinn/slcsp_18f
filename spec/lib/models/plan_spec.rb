require 'models/plan'
require 'models/zip'

RSpec.describe Plan do
  describe '.with_zipcode' do
    let(:zip) do
      Zip.new(zipcode: '11111', rate_area: '123')
    end

    let(:first_matching_plan) do
      Plan.new(rate_area: '123')
    end

    let(:second_matching_plan) do
      Plan.new(rate_area: '123')
    end

    let(:first_excluded_plan) do
      Plan.new(rate_area: '234')
    end

    let(:second_excluded_plan) do
      Plan.new(rate_area: '345')
    end

    before do
      allow(Plan).to receive(:all) { [first_matching_plan, first_excluded_plan, second_excluded_plan, second_matching_plan] }
      allow(Zip).to receive(:all) { [zip] }
    end

    it 'contains all plans for the given zipcode' do
      expect(Plan.with_zipcode('11111')).to contain_exactly(first_matching_plan, second_matching_plan)
    end
  end
end
