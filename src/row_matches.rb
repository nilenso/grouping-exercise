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

    # If we're matching two rows which belong to separate buckets,
    # of size > 1. After the match, all rows in both these buckets
    # should have the same match key. We do this by changing all match
    # keys in the second bucket to the match key of the first bucket
    change_match_keys(@matches[second], key) if @matches[second]

    @matches[first] ||= key
    @matches[second] ||= key
    key
  end

  def change_match_keys(old_key, new_key)
    @matches.each { |row,_| @matches[row] = new_key if @matches[row] == old_key }
  end

  def fetch_key_for(row)
    @matches[row] || SecureRandom.hex
  end
end
