require 'nokogiri'
require 'rest-client'
require 'roda'

class Whatlevelisadam < Roda
  plugin :render

  route do |r|
    r.root do
      url = 'http://us.battle.net/wow/en/character/wyrmrest-accord/Skinnyghost/simple'
      html = RestClient.get(url, headers={})
      doc = Nokogiri::HTML(html)

      @level =  doc.css('span.level').text
      view(:index)
    end
  end
end
