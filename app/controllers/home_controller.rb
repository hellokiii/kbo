require 'nokogiri'
require 'open-uri'
require 'uri'
require 'cgi'
require 'json'
require 'net/http'

class HomeController < ApplicationController
  def index
    
  end
  
  
  
  
  
  
  
  
  
  
  
  
  def relay
  
    full = params[:full]
    month = params[:month]

  
  
    comment_url = "http://sportsdata.naver.com/ndata//kbo/2016/#{month}/#{full}02016.nsd"
    parsed_uri = URI(comment_url)
    req = Net::HTTP::Get.new(parsed_uri)
    res = Net::HTTP.start(parsed_uri.hostname, parsed_uri.port, :use_ssl => parsed_uri.scheme == 'https') {|http|
      http.request(req)
    }
    
    
    # inn = ["1", "2", "3", "4", "5", "6", "7", "8", "9"].reverse
  
    reformed = res.body.gsub(/\r/,"").gsub(/\n/,"")[/{.+}/]

    j = JSON.parse(reformed)

    # j["relayTexts"]["currentBatter"].each do |c| 
    #   puts "#{c['liveText']}"
    # end
    @record = Array.new
    @record << j["relayTexts"]["currentBatter"]["liveText"]
    j["relayTexts"]["currentBatterTexts"].each do |c| 
      @record << "#{c['liveText']}"
    end
    
    for i in 1..9
      j["relayTexts"]["#{10-i}"].each do |c|
        @record << "#{c['liveText']}"
      end
    end
  end
  
  def schedule
    
    @address = Array.new
    doc = Nokogiri::HTML(open("http://sports.news.naver.com/kbaseball/schedule/index.nhn?date=20160703&month=#{params[:month]}&year=2016&teamCode="))
    doc.css(".td_btn//a").each do |x|
      @address << x.attr("href")
    end

    # address.each do |a|
    #   Game.create(full: a[-17,12], 
    #               month: a[-13, 2], 
    #               day: a[-11, 2], 
    #               away_team: a[-9, 2],
    #               home_team: a[-7,2])
    # end
    
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  def show
    @record = Array.new
    
    Game.where(home_team: "LG").each do |g|
      comment_url = "http://sportsdata.naver.com/ndata//kbo/2016/06/#{g.full}02016.nsd"
      parsed_uri = URI(comment_url)
      req = Net::HTTP::Get.new(parsed_uri)
      res = Net::HTTP.start(parsed_uri.hostname, parsed_uri.port, :use_ssl => parsed_uri.scheme == 'https') {|http|
        http.request(req)
      }
      
      
      # inn = ["1", "2", "3", "4", "5", "6", "7", "8", "9"].reverse
    
      reformed = res.body.gsub(/\r/,"").gsub(/\n/,"")[/{.+}/]

        j = JSON.parse(reformed)
      
      
      # j["relayTexts"]["currentBatter"].each do |c| 
      #   puts "#{c['liveText']}"
      # end
      
      @record << g.full
      @record << j["relayTexts"]["currentBatter"]["liveText"]
      j["relayTexts"]["currentBatterTexts"].each do |c| 
        @record << "#{c['liveText']}"
      end
      
      for i in 1..9
        j["relayTexts"]["#{10-i}"].each do |c|
          @record << "#{c['liveText']}"
        end
      end
      @record << " "
      @record << "_______________________게임구분선_____________________"
      @record << " "
    end
    
    
    

  end
  
end
