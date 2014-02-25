require 'csv'

namespace :project_tracker do
  
  desc "Imports project tracker info into creative_queue"
  task import: :environment do

    def find_user(obj)
      case obj
      when "EF"
        2
      when "JW"
        12
      when "MM"
        13
      when "ES"
        11
      when "CE"
        3
      when "SK"
        7
      when "CK"
        6
      when "DM"
        5
      when "SD"
        9
      when "TS"
        10
      when "LH"
        14
      end
    end

    CSV.foreach(Rails.root + "covalent/project_tracker_import_rev.csv") do |row|
      date_created = Date.strptime(row[0], "%m/%d/%y").to_time(:local)
      dist = row[2]
      contact_name = row[3]
      contact_email = row[4]
      file = row[5].split('_')
      end_client = file[0]
      quote_no = file[1]
      team = row[7].split('/')
      artist = team[0]
      quote = team[1].nil? || team[1] == "BA" || team[1] == "JR" || team[1] == "CW" ? team[0] : team[1]
      ordered = row[9].present?
      creative_user_id = find_user(quote)
      artist_id = find_user(artist)

      request = VirtualRequest.create!(
        quote: quote_no,
        contact_name: contact_name,
        contact_email: contact_email,
        created_at: date_created,
        updated_at: date_created,
        due_date: date_created,
        end_client: end_client,
        company: dist,
        creative_user_id: creative_user_id,
        artist_id: artist_id,
        completed: true,
        processed: true,
        ordered: ordered,
        quantity: "n/a",
        budget: "n/a",
        art_website: "n/a",
        comments: "This request was from an automated import"
        )

      puts "created virtual request for #{end_client}"
    end
  end
end