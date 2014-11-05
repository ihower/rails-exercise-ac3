class Event < ActiveRecord::Base

   validates_presence_of :name

   belongs_to :category

   has_one :location

   has_many :attendees

   has_many :event_groupships
   has_many :groups, :through => :event_groupships

   has_many :taggings
   has_many :tags, :through => :taggings

   belongs_to :user

   delegate :name, :to => :category, :prefix => true, :allow_nil => true

   has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
   validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

   def tag_name
      self.tags.map{ |x| x.name }.join(",")
   end

   def tag_name=(tag_names)
      self.taggings.delete_all
      tag_names.split(",").each do |tag_name|
         self.tags << Tag.get(tag_name)
      end
   end

end
