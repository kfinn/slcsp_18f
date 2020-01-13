require 'active_model'
require 'concerns/csv_model'

RSpec.describe CSVModel do
  describe '.from_csv' do
    let(:csv_model_class) do
      Class.new do
        include ActiveModel::Model
        include CSVModel

        attr_accessor :id, :state, :rate

        def rate=(rate)
          @rate = rate.to_f
        end
      end
    end

    let(:models) { csv_model_class.from_csv('spec/support/csv_models.csv') }

    it 'includes Plan objects based on the specified path file' do
      expect(models.size).to eq 3

      models.first.tap do |first_model|
        expect(first_model.id).to eq '74449NR9870320'
        expect(first_model.state).to eq 'GA'
        expect(first_model.rate).to eq 298.62
      end

      models.second.tap do |second_model|
        expect(second_model.id).to eq '26325VH2723968'
        expect(second_model.state).to eq 'FL'
        expect(second_model.rate).to eq 421.43
      end

      models.third.tap do |third_model|
        expect(third_model.id).to eq '09846WB8636633'
        expect(third_model.state).to eq 'IL'
        expect(third_model.rate).to eq 361.69
      end
    end
  end
end
