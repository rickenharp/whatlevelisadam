require 'roda'
require 'tilt/erb'
require './models'
require 'nokogiri'
require 'rest-client'
require 'moneta'

class Whatlevelisadam < Roda
  plugin :render
  plugin :assets, css: 'style.scss'
  compile_assets

  CACHE = Moneta.build do
    use :Expires
    use :Logger unless ENV['NO_LOGGING']
    adapter :Memory
  end

  route do |r|
    r.assets
    r.root do
      html = CACHE.fetch('html') do
        url = 'http://us.battle.net/wow/en/character/wyrmrest-accord/Skinnyghost/simple'
        html = RestClient.get(url)
        CACHE.store('html', html, expires: 60 * 10)
      end
      @character = Character.new(html)
      render(:index)
    end
  end
end
