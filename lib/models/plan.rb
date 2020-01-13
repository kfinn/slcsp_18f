require 'environment'
require 'concerns/csv_model'
require 'active_model'

class Plan
  include ActiveModel::Model
  include CSVModel
  csv_path Environment.instance.plans_path

  attr_accessor :plan_id, :state, :metal_level, :rate, :rate_area

  def rate=(rate)
    @rate = rate.to_f
  end
end
