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
  
  def to_a
    @rows
  end
end