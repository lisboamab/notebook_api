namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task contacts_setup: :environment do
    100.times do |f|
      Contact.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(from: 65.years.ago, to: 18.years.ago),
        kind: Kind.all.sample
      )
    end
  end
  desc "Configura o ambiente de desenvolvimento"
  task kinds_setup: :environment do
    kinds = ["Amigo", "Comercial", "Conhecido"]
    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
  end

  desc "Configura o ambiente de desenvolvimento"
  task phones_setup: :environment do
    Contact.all.each do |contact|
      Random.rand(5).times do |i|
        phone = Phone.create!(number: Faker::PhoneNumber.cell_phone, contact: contact).save!
      end
    end
  end
end
