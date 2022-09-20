class DiscordBotJob < ApplicationJob
  queue_as :default

  def perform(*args)
    bot = Discordrb::Commands::CommandBot.new token: Rails.application.credentials.discord.token,
      client_id: Rails.application.credentials.discord.app_id,
      prefix: '!'

    bot.bucket :memes, limit: 3, time_span: 60, delay: 10

    bot.command :hello, bucket: :memes, description: 'to say hello' do |event|
      event.respond("Hello!
Create your Guild Wars 2 legend! To share what titles and achievements you've unlock, enter your API key with:
[x] account
[x] unlocks
[x] progression
Then, send me:
`!register API_KEY`")
    end

    bot.command :rank, bucket: :memes, description: 'to show your rank' do |event|
      user = User.find_by(provider: 'discord', uid: event.user.id)
      embed = Discordrb::Webhooks::Embed.new
      player = user.players
      embed.title = "#{player.igname} on GW2Rank.com"
      embed.description = "#{player.titles_count} titles, #{player.done_achievements_count} done achievements and #{player.achievements_points} achievements points on Guild Wars 2!"
      embed.url = "https://gw2rank.com/players/#{player.slug}"
      event.send_embed("", embed)
    end

    bot.command :register, bucket: :memes, description: 'to register your legendary account' do |event, api_key|
      user = User.where(provider: 'discord', uid: event.user.id).first_or_create do |player|
        player.email = "#{event.user.id}@gwrank.com"
        player.password = Devise.friendly_token[0, 20]
        player.username = event.user.name
      end

      connection = Faraday.new(
        url: "https://api.guildwars2.com",
      )
      api_key = api_key.strip
      if !api_key.length.eql?(72)
        event.respond "It doesn't seems to be a valid API key. Try again"
      else
        response = connection.get("/v2/account", {}, { Authorization: "Bearer #{api_key}" })
        if response.body["text"].present?
          event.respond "It doesn't seems to be a valid API key. Try again"
        else
          account = JSON.parse(response.body)

          player = Player.where(igname: account["name"]).first_or_initialize
          player.api_key = api_key
          player.user = user

          if player.save
            player.update_titles
            player.update_achievements
            event.respond "Your legend was successfully created! You can see it at https://gw2rank.com/players/#{player.slug}"
          else
            event.respond "An error has occured. Try again later"
          end
        end
      end
    end

    if Rails.env.production?
      backgrounded = true
    else
      backgrounded = false
    end

    bot.run(backgrounded)
  end
end
