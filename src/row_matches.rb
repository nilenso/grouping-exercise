require 'set'
require 'securerandom'

class RowMatches
  def initialize(all_rows)
    @all_rows = all_rows
    @matches = {}
    @rest = []
  end

  def add_match(*rows)
    rows.each do |row|
      generate_key_for(*rows)
    end
  end

  def to_hash
    @matches
  end

  def to_csv
    CSV.generate do |csv|
      csv << (@all_rows.first.headers + ["ID"])
      @all_rows.each_with_index do |row, index|
        csv << (row.to_a + [fetch_key_for(row)])
      end
      csv
    end
  end

  private

  def generate_key_for(first, second)
    key = @matches[first] || @matches[second] || Digest::MD5.hexdigest("#{first}#{second}")
    @matches[first] ||= key
    @matches[second] ||= key
    key
  end

  def fetch_key_for(row)
    @matches[row] || SecureRandom.hex
  end
end
