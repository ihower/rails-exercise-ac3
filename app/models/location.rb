class Location < ActiveRecord::Base

  belongs_to :event

  #after_commit on: [:create] do
  #  self.event.__elasticsearch__.index_document
  #end

  after_commit on: [:update] do
    self.event.__elasticsearch__.update_document
  end

  after_commit on: [:destroy] do
    self.event.__elasticsearch__.update_document
  end

end
