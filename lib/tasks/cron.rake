desc "Cron jobs"
task :cron => :environment do
  # [1] Cleaning legacy images
  if true
    puts ""
    puts ">>> [#{Time.now.httpdate}] Cleaning legacy images..."
    images = Image.where(:used => nil).where('created_at < ?', 1.day.ago)
    unless (count = images.size) == 0
      images.each do |image|
        image.destroy
      end
    end
    puts "<<< [#{Time.now.httpdate}] #{count} cleaned."
  end
end
