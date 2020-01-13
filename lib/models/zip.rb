require 'environment'
require 'csv'
require 'concerns/csv_model'
require 'active_model'

class Zip
  include ActiveModel::Model
  include CSVModel
  csv_path Environment.instance.zips_path

  attr_accessor :zipcode, :state, :county_code, :name, :rate_area

  def self.find_by_zipcode(zipcode)
    all.select { |zip| zip.zipcode == zipcode }.first
  end
end
