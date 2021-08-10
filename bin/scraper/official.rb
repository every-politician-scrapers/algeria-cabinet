#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.css('.ministere-nom').text.tidy
    end

    POSITION_MAP = {
      'Premier Ministre Ministre des finances' => ['Premier Ministre', 'Ministre des finances']
    }

    def position
      POSITION_MAP.fetch(raw_position, raw_position)
    end

    private

    def raw_position
      noko.css('.ministere-link').text.tidy
    end
  end

  class Members
    def member_container
      noko.css('.pm-composition-pm-carte, .composition-ministre-carte')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
