class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    self.joins(:classifications).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    self.joins(:classifications).where("classifications.name = 'Sailboat'").distinct
  end

  def self.talented_seamen
    test1 = sailors
    test2 = self.joins(:classifications).where("classifications.name = 'Motorboat'")
    test3 = test1 & test2
    Captain.where(id: test3.map(&:id))
  end

  def self.non_sailors
    test = self.all - sailors
    Captain.where(id: test.map(&:id))
  end
end
