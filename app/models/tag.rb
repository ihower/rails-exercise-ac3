class Tag < ActiveRecord::Base

  has_many :taggings
  has_many :events, :through => :taggings

  def self.get(name)
    self.find_by_name(name) || self.create( :name => name )
  end

end
