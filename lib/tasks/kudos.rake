namespace :kudos do
  desc 'Reset kudos for everyuser at midnight 00:00am of every Monday'
  task reset_kudos: :environment do
    puts "Starting to reset users' kudos "
    User.all.each do |user|
      user.kudos_quantity.quantity = 3
      user.kudos_quantity.save!
    end
    puts "Reseting users' kudos has completed successfully."
  end
end
