# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
platforms = { windows: Platform.create(name: 'Microsoft Windows'),
              xbox_one: Platform.create(name: 'Microsoft Xbox One'),
              xbox_360: Platform.create(name: 'Microsoft Xbox 360'),
              xbox: Platform.create(name: 'Microsoft Xbox'),
              ps4: Platform.create(name: 'Sony Playstation 4'),
              ps3: Platform.create(name: 'Sony Playstation 3'),
              ps2: Platform.create(name: 'Sony Playstation 2'),
              ps: Platform.create(name: 'Sony Playstation'),
              switch: Platform.create(name: 'Nintendo Switch'),
              osx: Platform.create(name: 'MacOS') }

# This is so we can load our seed images as assets
#sprocket_env = Sprockets::Environment.new
#sprocket_env.append_path(Rails.root.join('seed', 'images'))

games = { Game.create(name: 'Forza Motorsport 7', release: Date.parse('October 3, 2017'), developer: 'Turn 10 Studios', publisher: 'Microsoft Studios') =>
            { platforms: [platforms[:windows], platforms[:xbox_one]], image: 'forza7.jpg' },
          Game.create(name: 'Gran Turismo Sport', release: Date.parse('October 17, 2017'), developer: 'Polyphony Digital', publisher: 'Sony Interactive Entertainment') =>
            { platforms: [platforms[:ps4]], image: 'gtsport.jpg' },
          Game.create(name: 'Assetto Corsa', release: Date.parse('December 19, 2014'), developer: 'Kunos Simulazioni', publisher: 'Kunos Simulazioni') =>
            { platforms: [platforms[:windows], platforms[:xbox_one], platforms[:ps4]], image: 'assettocorsa.png' },
          Game.create(name: 'Automobilista', release: Date.parse('February 29, 2016'), developer: 'Reiza Studios', publisher: 'Reiza') =>
            { platforms: [platforms[:windows]], image: 'automobilista.jpg' } }

cover_image_path = Rails.root.join('seed', 'images', 'games', 'covers')

games.each do |game, properties|
  properties[:platforms].each do |platform|
    GamePlatformAssociation.create(game: game, platform: platform)
  end

  if properties[:image]
    game.create_image(Image.properties_from_url(File.join(cover_image_path, properties[:image])))
  end
end
