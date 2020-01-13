$LOAD_PATH.unshift File.expand_path(".", "lib")
Bundler.require
require 'models/slcsp'

puts 'zipcode,rate'
SLCSP.all.each do |slcsp|
  puts slcsp.to_csv_row
end
