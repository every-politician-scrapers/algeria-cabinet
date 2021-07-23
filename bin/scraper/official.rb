#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'open-uri/cached'
require 'pry'

class MemberList
  # details for an individual member
  class Member < Scraped::HTML
    field :name do
      noko.css('.ministere-nom').text.tidy
    end

    field :position do
      noko.css('.ministere-link').text.tidy
    end
  end

  # The page listing all the members
  class Members < Scraped::HTML
    field :members do
      member_container.map { |member| fragment(member => Member).to_h }
    end

    private

    def member_container
      noko.css('.pm-composition-pm-carte, .composition-ministre-carte')
    end
  end
end

url = 'http://www.premier-ministre.gov.dz/fr/gouvernement/compostion-actuel'
puts EveryPoliticianScraper::ScraperData.new(url).csv
