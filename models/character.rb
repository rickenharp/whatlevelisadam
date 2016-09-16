class Character
  attr_reader :doc

  def initialize(html)
    @doc = Nokogiri::HTML(html)
  end

  def level
    doc.css('span.level').text.to_i
  end

  def item_level
    doc.css('#summary-averageilvl-best').text.to_i
  end
end
