namespace :players do
  task fix_account_name: :environment do
    Player.with_api_key.each do |player|
      player.fix_account_name
    end
  end

  task reset_counters: :environment do
    Player.find_each do |player|
      Player.reset_counters(player.id, :player_achievements)
    end
  end

  namespace :titles do
    task update: :environment do
      Player.with_api_key.each do |player|
        player.update_titles
     end
    end
  end

  namespace :achievements do
    task update: :environment do
      Player.with_api_key.each do |player|
        player.update_achievements
     end
    end
  end
end
