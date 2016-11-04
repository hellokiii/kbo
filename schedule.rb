require 'nokogiri'
require 'open-uri'

address = Array.new
doc = Nokogiri::HTML(open("http://sports.news.naver.com/kbaseball/schedule/index.nhn?date=20160703&month=06&year=2016&teamCode="))
doc.css(".td_btn//a").each do |x|
    address << x.attr("href")
end

address.each do |a|
    game = Game.new
    game.full = a[-17,12]
    gmae.month = a[-13, 2]
    game.day = a[-11, 2]
    game.away_team = a[-9, 2]
    game.home_team = a[-7, 2]
    game.save
    
        # Game.create(full: a[-17,12], 
        #         month: a[-13, 2], 
        #         day: a[-11, 2], 
        #         away_team: a[-9, 2],
        #         home_team: a[-7, 2])
        
        
#   puts "full : " + a[-17,12]
#   puts "season : " + a[-17,4]
#   puts "month : " + a[-13, 2]
#   puts "day : " + a[-11, 2]
#   puts "away_team : " + a[-9, 2]
#   puts "home_team : " + a[-7, 2]
end