require 'models/plan'

RSpec.describe Plan do
  describe '.from_csv' do
    let(:all_plans) { Plan.from_csv('spec/support/plans.csv') }

    it 'includes Plan objects based on the specified path file' do
      expect(all_plans.size).to eq 3

      all_plans.first.tap do |first_plan|
        expect(first_plan.plan_id).to eq '74449NR9870320'
        expect(first_plan.state).to eq 'GA'
        expect(first_plan.metal_level).to eq 'Silver'
        expect(first_plan.rate).to eq 298.62
        expect(first_plan.rate_area).to eq '7'
      end

      all_plans.second.tap do |second_plan|
        expect(second_plan.plan_id).to eq '26325VH2723968'
        expect(second_plan.state).to eq 'FL'
        expect(second_plan.metal_level).to eq 'Silver'
        expect(second_plan.rate).to eq 421.43
        expect(second_plan.rate_area).to eq '60'
      end

      all_plans.third.tap do |third_plan|
        expect(third_plan.plan_id).to eq '09846WB8636633'
        expect(third_plan.state).to eq 'IL'
        expect(third_plan.metal_level).to eq 'Gold'
        expect(third_plan.rate).to eq 361.69
        expect(third_plan.rate_area).to eq '5'
      end
    end
  end
end
