require 'active_model'
require 'active_support/all'
require 'concerns/csv_model'
require 'environment'
require 'models/zip'

class Plan
  include ActiveModel::Model
  include CSVModel
  csv_path Environment.instance.plans_path

  class CollectionProxy < SimpleDelegator
    def with_zipcode(zipcode)
      zip = Zip.find_by_zipcode(zipcode)
      if zip.present?
        with_rate_area(zip.rate_area)
      else
        self.class.new([])
      end
    end

    def with_rate_area(rate_area)
      self.class.new(select { |plan| plan.rate_area == rate_area })
    end

    def silver
      self.class.new(select { |plan| plan.metal_level == 'Silver' })
    end

    def sorted_by_rate
      self.class.new(sort_by(&:rate))
    end
  end

  def self.with_zipcode(zipcode)
    CollectionProxy.new(all).with_zipcode(zipcode)
  end

  def self.with_rate_area(rate_area)
    CollectionProxy.new(all).with_rate_area(rate_area)
  end

  def self.silver
    CollectionProxy.new(all).silver
  end

  def sorted_by_rate
    CollectionProxy.new(all).sorted_by_rate
  end

  attr_accessor :plan_id, :state, :metal_level, :rate_area
  attr_reader :rate

  def rate=(rate)
    @rate = rate.to_d
  end
end
