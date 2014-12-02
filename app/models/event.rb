class Event < ActiveRecord::Base

   attr_accessor :_destroy_logo
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

   validates_uniqueness_of :uid

   before_validation :remove_logo
   before_create :setup_uid

   include Elasticsearch::Model
   include Elasticsearch::Model::Callbacks

   def as_indexed_json(options={})
      self.as_json( :include => :location )
   end

   def to_param
      self.uid
   end

   def setup_uid
      self.uid = SecureRandom.uuid.split("-").first
   end

   protected

   def remove_logo
      self.logo = nil if self._destroy_logo
   end

end
