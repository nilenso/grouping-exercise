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
    @rows.combination(2).inject(Hash.new { Set.new }) do |hash, combination|
      if strategy.match?(*combination)
        hash[strategy.key_for(*combination)] += combination
      end
      hash
    end
  end
  
  def to_a
    @rows
  end
end