require 'environment'
require 'csv'
require 'active_model'

class Plan
  include ActiveModel::Model

  def self.all(path: nil)
    @all ||= from_csv(Environment.instance.plans_path)
  end

  def self.from_csv(path)
    plans = []
    CSV.foreach(path , headers: true) do |row|
      plans << Plan.new(row.to_h)
    end
    plans
  end

  attr_accessor :plan_id, :state, :metal_level, :rate, :rate_area

  def rate=(rate)
    @rate = rate.to_f
  end
end
