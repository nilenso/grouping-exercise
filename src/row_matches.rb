require 'set'

class RowMatches
  def initialize(all_rows)
    @all_rows = all_rows
    @matches = Hash.new { Set.new }
    @rest = []
  end

  def add_match(key, rows)
    @matches[key] += rows
  end

  def to_hash
    @matches
  end

  def to_csv
    CSV.generate do |csv|
      csv << @all_rows.first.headers
      @all_rows.each do |row|
        csv << row.to_a
      end
      csv
    end
  end
end
