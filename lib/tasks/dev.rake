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
    25.times do |i|
      s = JSON.parse(open('http://more.handlino.com/sentences.json').read)["sentences"][0]
      puts s
      Event.create( :name => "Event #{i}", :user => user, :description => s )
    end

  end

end