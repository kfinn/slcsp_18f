require 'csv'
require 'active_support/concern'

module CSVModel
  extend ActiveSupport::Concern

  class_methods do
    def csv_path(csv_path = nil)
      @csv_path ||= csv_path
    end

    def all
      @all ||= from_csv(csv_path)
    end

    def from_csv(path)
      plans = []
      CSV.foreach(path, headers: true) do |row|
        plans << new(row.to_h)
      end
      plans
    end
  end
end
