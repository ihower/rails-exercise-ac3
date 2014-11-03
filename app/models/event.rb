class Event < ActiveRecord::Base

   validates_presence_of :name

   belongs_to :category

   has_one :location

   has_many :attendees

   has_many :event_groupships
   has_many :groups, :through => :event_groupships

   belongs_to :user

   delegate :name, :to => :category, :prefix => true, :allow_nil => true

   has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
   validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

end
