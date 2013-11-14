namespace :db do
  desc "Reset CreativeQueue database classes only"
  task reset_cq: :environment do
    ActiveRecord::Base.establish_connection
    ActiveRecord::Base.connection.execute("TRUNCATE creative_users")
    ActiveRecord::Base.connection.execute("TRUNCATE virtuals")
    ActiveRecord::Base.connection.execute("TRUNCATE virtual_requests")
  end

  desc "Fill database with sample data"
  task populate: :environment do
    CreativeUser.create!(name: "Matt Ramirez", 
      email: "mattr@journalbooks.com", 
      password: "password", 
      phone_number: "7046022032", 
      password_confirmation: "password", 
      admin: true
      )

    10.times do |n|
      name  = Faker::Name.name
      email_name = name.split(' ').join.downcase
      email = "#{email_name}@journalbooks.com"
      password  = "password"
      phone_number = 7046022000 + n

      CreativeUser.create!(name: name, email: email, phone_number: phone_number.to_s, password: password, password_confirmation: password)
    end

    100.times do |n|
      contact_name  = Faker::Name.name
      contact_email = contact_name.split(" ").join.downcase
      email = "#{contact_email}@distributor.com"
      contact_phone = Faker::PhoneNumber.phone_number
      qty = ["100, 250, 500", "1,000, 2,500", "250,000"].sample
      budget = "$" + (1...9).to_a.sample.to_s + ".00"
      comments = Faker::Lorem.paragraph
      company = Faker::Company.name
      date_2 = Time.new(2013,11,1,9,00,0)
      date_1 = Time.new(2013,12,30,5,00,0)
      due_date = Time.at((date_2.to_f - date_1.to_f)*rand + date_1.to_f).strftime("%m/%d/%Y")
      art_url = Faker::Internet.url
      creative_user_id = (5...10).to_a.sample
      artist_id = (2...7).to_a.sample
      completed = [0,1].sample

      VirtualRequest.create!(
        contact_name: contact_name, 
        contact_email: email, 
        contact_phone: contact_phone, 
        quantity: qty,
        budget: budget,
        comments: comments,
        company: company,
        unformatted_date: due_date,
        art_website: art_url,
        creative_user_id: creative_user_id, 
        artist_id: artist_id,
        completed: completed 
        )
    end

    50.times do |n|
      recipients = Faker::Internet.email + ", " + Faker::Internet.email
      virtual_request_id = (1...100).to_a.sample
      artist_comments = Faker::Lorem.paragraph
      user_comments = Faker::Lorem.paragraph
      file_number = (1...6).to_a.sample
      file = File.open(File.join(Rails.root, "spec/fake_data/sample_file_#{file_number}.pdf"))
      artist_id = (2...7).to_a.sample
      quote_number = 530029 + n
      sent = [0,1].sample

      Virtual.create!(
        artist_comments: artist_comments,
        user_comments: user_comments,
        recipients: recipients,
        virtual_request_id: virtual_request_id,
        document: file,
        creative_user_id: artist_id,
        quote_number: quote_number,
        sent: sent
        )
    end
  end
end

