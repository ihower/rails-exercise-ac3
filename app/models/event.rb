class Event < ActiveRecord::Base

   validates_presence_of :name

   belongs_to :category

   has_one :location

   has_many :attendees

   has_many :event_groupships
   has_many :groups, :through => :event_groupships

   belongs_to :user

   delegate :name, :to => :category, :prefix => true, :allow_nil => true

end
