require 'set'

class RowMatches
  def initialize(all_rows)
    @all_rows = all_rows
    @matches = {}
    @rest = []
  end

  def add_match(key, rows)
    rows.each do |row|
      @matches[row] = key
    end
  end

  def to_hash
    @matches
  end

  def to_csv
    CSV.generate do |csv|
      csv << (@all_rows.first.headers + ["ID"])
      @all_rows.each_with_index do |row, index|
        csv << (row.to_a + [key_for(row)])
      end
      csv
    end
  end

  private

  def key_for(row)
    @matches[row] || ((0...8).map { (65 + rand(26)).chr }.join)
  end
end
