require 'active_model'
require 'active_support/all'
require 'concerns/csv_model'
require 'csv'
require 'environment'
require 'models/plan'

class SLCSP
  include ActiveModel::Model
  include CSVModel
  csv_path Environment.instance.slcsp_path

  attr_accessor :zipcode
  attr_writer :rate

  def rate
    @rate.presence || computed_rate
  end

  def computed_rate
    unless instance_variable_defined?(:@computed_rate)
      plan = Plan.with_zipcode(zipcode).silver.sorted_by_rate.second
      @computed_rate = plan.present? ? plan.rate : nil
    end
    @computed_rate
  end

  def to_csv_row
    "#{zipcode},#{rate}"
  end
end
