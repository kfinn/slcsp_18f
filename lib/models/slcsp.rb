require 'environment'
require 'csv'
require 'concerns/csv_model'
require 'active_model'
require 'active_support/all'
require 'models/plan'

class SLCSP
  include ActiveModel::Model
  include CSVModel
  csv_path Environment.instance.slcsp_path

  attr_accessor :zipcode, :rate

  def rate
    second_lowest_cost_silver_plan = Plan.with_zipcode(zipcode).silver.sorted_by_rate.second
    second_lowest_cost_silver_plan.present? ? second_lowest_cost_silver_plan.rate : nil
  end

  def to_csv_row
    "#{zipcode},#{rate}"
  end
end
