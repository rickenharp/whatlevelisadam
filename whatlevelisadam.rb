require 'nokogiri'
require 'rest-client'
require 'moneta'
require 'roda'

class Whatlevelisadam < Roda
  plugin :render
  plugin :assets, css: 'style.scss'
  compile_assets

  STORE = Moneta.build do
    use :Expires
    use :Logger
    adapter :Memory
  end

  route do |r|
    r.assets
    r.root do
      @level = get_level
      render(:index)
    end
  end

  private

  def get_level
    STORE.fetch('level') do
      url = 'http://us.battle.net/wow/en/character/wyrmrest-accord/Skinnyghost/simple'
      html = RestClient.get(url)
      doc = Nokogiri::HTML(html)
      STORE.store('level', doc.css('span.level').text, expires: 60 * 10)
    end
  end
end
