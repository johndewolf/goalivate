require 'csv'

datafile = Rails.root + 'db/data/exercises.csv'

CSV.foreach(datafile, headers: true) do |row|
  Exercise.find_or_create_by(name: row['name'])
end
