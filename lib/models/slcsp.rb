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
    @rate ||= Plan.with_zipcode(zipcode).second.rate
  end

  def to_csv_row
    "#{zipcode},#{rate}"
  end
end
