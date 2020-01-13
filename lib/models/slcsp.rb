require 'environment'
require 'csv'
require 'concerns/csv_model'
require 'active_model'

class SLCSP
  include ActiveModel::Model
  include CSVModel
  csv_path Environment.instance.slcsp_path

  attr_accessor :zipcode, :rate

  def rate=(rate)
    @rate = rate.to_f
  end

  def to_csv_row
    "#{zipcode},#{rate}"
  end
end
