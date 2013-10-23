class Rows
  extend Forwardable
  def_delegator :@rows, :size
  
  def initialize
    @rows = []
  end
  
  def import_from_csv(csv)
    @rows += csv.read.drop(1)
    self
  end
end