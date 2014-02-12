namespace :covalent do
  
  desc "Check to see what jobs have been converted to orders"
  task orders: :environment do
    todays_orders = CovOrder.today
    virtual_requests = VirtualRequest.where(completed: true, ordered: false)

    virtual_requests.each do |vr|
      puts "looking for #{vr.quote}..."
      todays_orders.each do |ord|
        if vr.quote == ord.quote_number
          puts "!!! found a match for #{vr.quote} - #{vr.end_client} !!!"
          vr.update_attributes(ordered: true)
        end
      end 
    end
  end

  desc "Import quote file and update attributs of virtual requests"
  task quotes: :environment do
    file = "quote_0#{Time.now.strftime("%u")}"
    todays_requests = VirtualRequest.where(processed: false)

    puts "processing #{file}"
    File.open(Rails.root + "covalent/#{file}") do |f|
      f.each do |line|
        vals = line.split("|")

        todays_requests.each do |req|
          if req.quote == vals[0].to_i
            comments = []
            vals[9..17].each do |c|
              comments << c unless c == ""
            end

            req.update_attributes(
              company: vals[4].titlecase,
              contact_name: "#{vals[5]} #{vals[6]}".titlecase,
              contact_email: vals[7].downcase,
              contact_phone: vals[18],
              comments: comments.to_sentence,
              asi_number: vals[3],
              processed: true
              )

            req.check_priority
            puts "processed #{req.quote}"
          end
        end
      end
    end
  end
end