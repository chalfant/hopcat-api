require 'nokogiri'
require 'open-uri'

module Hopcat
  module Api
    class Draft

      attr_accessor :location

      def initialize
        @location = 'http://www.hopcat.com/tap/broad-ripple'
      end

      def list
        results = {
          drafts: []
        }
        item_lists.each do |a_list|
          category = item_list_category(a_list)
          items(a_list).each do |item|
            beer_hash = item_to_hash(item)
            beer_hash[:category] = category
            results[:drafts] << beer_hash
          end
        end
        results
      end

      def item_lists
        page = Nokogiri::HTML( open(location) )
        page.css('div.view-beer-menu div.item-list')
      end

      def item_list_category(item_list)
        item_list.css('h3')[0].text
      end

      def items(item_list)
        item_list.css('li.views-row')
      end

      def item_to_hash(item)
        {
          title:    item_title(item),
          brewery:  item_brewery(item),
          location: item_location(item),
          abv:      item_abv(item),
          style:    item_style(item)
        }
      end

      def item_title(item)
        item.css('div.views-field-title span').text.strip
      end

      def item_brewery(item)
        item.css('div.views-field-field-brewery div').text.strip
      end

      def item_location(item)
        item.css('div.views-field-field-city-state-country div').text.strip
      end

      def item_abv(item)
        item.css('div.views-field-field-beer-abv div').text.gsub(/[()]/,'').strip
      end

      def strip_nbsp(str)
        nbsp = Nokogiri::HTML("&nbsp;").text
        str.gsub(nbsp, '')
      end

      def item_style(item)
        style = item.css('div.views-field-body div').text.strip
        style = strip_nbsp(style)
        if style.lines.size > 1
          style = style.lines.first
        end
        style.strip
      end
    end
  end
end
