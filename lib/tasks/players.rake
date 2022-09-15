namespace :players do
  namespace :titles do
    task update: :environment do
      Player.where.not(api_key: nil).each do |player|
        player.update_titles
     end
    end
  end

  namespace :achievements do
    task update: :environment do
      Player.where.not(api_key: nil).each do |player|
        player.update_achievements
     end
    end
  end
end
