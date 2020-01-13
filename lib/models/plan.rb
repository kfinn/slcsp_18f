require 'environment'
require 'concerns/csv_model'
require 'active_model'
require 'active_support/all'
require 'models/zip'

class Plan
  include ActiveModel::Model
  include CSVModel
  csv_path Environment.instance.plans_path

  attr_accessor :plan_id, :state, :metal_level, :rate, :rate_area

  def self.with_zipcode(zipcode)
    with_rate_area(Zip.find_by_zipcode(zipcode).rate_area)
  end

  def self.with_rate_area(rate_area)
    all.select { |plan| plan.rate_area == rate_area }
  end

  def rate=(rate)
    @rate = rate.to_d
  end
end
