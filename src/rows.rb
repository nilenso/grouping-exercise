require 'forwardable'
require 'set'

class Rows
  extend Forwardable
  def_delegator :@rows, :size

  def initialize
    @rows = []
  end

  def import_from_csv(csv)
    csv_header, *csv_lines = csv.read
    @rows += csv_lines.map do |row|
      row_data = Hash[csv_header.zip(row)]
      Row.new(row_data)
    end
    self
  end

  def match_by(strategy)
    @rows.combination(2).inject(RowMatches.new(@rows)) do |matches, combination|
      if strategy.match?(*combination)
        matches.add_match(*combination)
      end
      matches
    end
  end

  def to_a
    @rows
  end
end
