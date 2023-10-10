class MeMyselfAndI
  self #=> MeMyselfAndI

  def self.me #=> MeMyselfAndI
    self #=> MeMyselfAndI
  end

  def myself
    self #=> i
  end
end

i = MeMyselfAndI.new