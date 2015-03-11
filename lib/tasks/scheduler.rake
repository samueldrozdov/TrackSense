desc "This task should be called by the Heroku scheduler add-on"

task :update_priority => :environment do
  puts "Updating track priority..."
  Track.update_priority
  puts "done!"

end
