# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
platforms = { windows: Platform.find_or_create_by!(name: 'Microsoft Windows'),
              xbox_one: Platform.find_or_create_by!(name: 'Microsoft Xbox One'),
              xbox_360: Platform.find_or_create_by!(name: 'Microsoft Xbox 360'),
              xbox: Platform.find_or_create_by!(name: 'Microsoft Xbox'),
              ps4: Platform.find_or_create_by!(name: 'Sony Playstation 4'),
              ps3: Platform.find_or_create_by!(name: 'Sony Playstation 3'),
              ps2: Platform.find_or_create_by!(name: 'Sony Playstation 2'),
              ps: Platform.find_or_create_by!(name: 'Sony Playstation'),
              switch: Platform.find_or_create_by!(name: 'Nintendo Switch'),
              osx: Platform.find_or_create_by!(name: 'MacOS') }

# This is so we can load our seed images as assets
#sprocket_env = Sprockets::Environment.new
#sprocket_env.append_path(Rails.root.join('seed', 'images'))

games1 = [{ name: 'Forza Motorsport 7', release: Date.parse('October 3, 2017'), developer: 'Turn 10 Studios', publisher: 'Microsoft Studios',
            platforms: [platforms[:windows], platforms[:xbox_one]], image: 'forza7.jpg' },
          { name: 'Gran Turismo Sport', release: Date.parse('October 17, 2017'), developer: 'Polyphony Digital', publisher: 'Sony Interactive Entertainment',
            platforms: [platforms[:ps4]], image: 'gtsport.jpg' },
          { name: 'Assetto Corsa', release: Date.parse('December 19, 2014'), developer: 'Kunos Simulazioni', publisher: 'Kunos Simulazioni',
            platforms: [platforms[:windows], platforms[:xbox_one], platforms[:ps4]], image: 'assettocorsa.png' },
          { name: 'Automobilista', release: Date.parse('February 29, 2016'), developer: 'Reiza Studios', publisher: 'Reiza',
            platforms: [platforms[:windows]], image: 'automobilista.jpg' }]

cover_image_path = Rails.root.join('seed', 'images', 'games', 'covers')

games1.each do |game_properties|
  game = Game.find_or_initialize_by(name: game_properties.fetch(:name))
  game.release = game_properties.fetch(:release)
  game.developer = game_properties.fetch(:developer)
  game.publisher = game_properties.fetch(:publisher)
  game.save!

  game_properties.fetch(:platforms).each do |platform|
    GamePlatformAssociation.find_or_create_by!(game: game, platform: platform)
  end

  image_property = game_properties[:image]

  # Destroy old image if new image is blank
  if image_property.blank?
    next unless game.image
    game.image.destroy
  end

  next if image_property.blank?

  generated_image_properties = Image.properties_from_url(File.join(cover_image_path, image_property))
  image = Image.find_or_initialize_by(id: game.image)
  image.filename = generated_image_properties[:filename]
  image.base64 = generated_image_properties[:base64]
  image.mimetype = generated_image_properties[:mimetype]
  image.imageable = game
  image.save!
end
