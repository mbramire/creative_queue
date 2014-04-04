class Search < ActiveRecord::Base
  attr_accessor :asi_number, :end_client, :company, :creative_user_id, :artist_id, :contact_name, :quote, :ordered, :completed, :unformatted_date_start, :unformatted_date_end

  def self.begin_search(search)
    query = []
    text = []
    equals = ["ordered", "completed", "creative_user_id", "artist_id"]
    date_start = ""
    date_end = ""
    results = {}
    date_text_start = ""
    date_text_end = ""

    # build query string minus between dates
    search.each do |s|
      if s[0] == "unformatted_date_start" && !s[1].blank?
        date_text_start = s[1]
        clean = s[1].split('/')
        date_start = "#{clean[2]}/#{clean[0]}/#{clean[1]} 00:00:000"
      elsif s[0] == "unformatted_date_end" && !s[1].blank?
        date_text_end = s[1]
        clean = s[1].split('/')
        date_end = "#{clean[2]}/#{clean[0]}/#{clean[1]} 23:59:59"
      elsif equals.include? s[0]
        unless (s[1] == "0") || (s[1].blank?)
          query << "#{s[0]}=#{s[1]}"
          if s[0] == "creative_user_id" 
            per = CreativeUser.find(s[1]).name
            text << "Quote by #{per}"
          elsif s[0] == "artist_id" 
            per = CreativeUser.find(s[1]).name
            text << "Virtual by #{per}"
          elsif s[0] == "completed" 
            text << s[0]
          elsif s[0] == "ordered" 
            text << s[0]
          end
        end
      else
        unless s[1].blank?
          query << "#{s[0]} LIKE '%#{s[1]}%'"
          text << "#{s[0]} = #{s[1]}"
        end
      end
    end

    if date_start.present? && date_end.present?
      query << "created_at BETWEEN '#{date_start}' AND '#{date_end}'"
      text << "Created between #{date_text_start} - #{date_text_end}"
    end

    results[:query] = VirtualRequest.find_by_sql("SELECT * FROM virtual_requests WHERE #{query.join(' AND ')};") unless query.blank?
    results[:text] = text.join(" & ").gsub("_", " ")
    results
  end
end