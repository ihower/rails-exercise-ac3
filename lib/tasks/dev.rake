require 'elasticsearch/rails/tasks/import'

namespace :dev do

  task :fix_event_uid =>  :environment do
    Event.find_each do |e|
      if e.uid.nil?
        e.setup_uid
        e.save
        puts "Fix event #{e.id}"
      end
    end
  end

  task :fake => :environment do
    user = User.first

    100.times do |i|
      Event.create( :name => "Event #{i}", :user => user)
    end

  end

end