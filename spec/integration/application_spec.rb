require "spec_helper"
require "rack/test"
require_relative '../../app'

def reset_music_table
  seed_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
  seed_sql = File.read('spec/seeds/artists_seeds.sql')
  connection.exec(seed_sql)
end



describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  before(:each) do 
    reset_music_table
  end
  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }
   context 'GET /albums' do
#     it 'should return the list of albums' do
#       response = get('/albums')
#       expected_response = ('Surfer Rosa
# Waterloo
# Super Trouper
# Bossanova
# Lover
# Folklore
# I Put a Spell on You
# Baltimore
# Here Comes the Sun
# Fodder on My Wings
# Ring Ring'
#       )
#       
#       expect(response.status).to eq 200
#       expect(response.body).to eq expected_response
# 
#     end
    
    it "can create new albums" do
      response = post('/albums', title: 'The Dark Side of the Moon', release_year: '1973', artist_id: '1')
      expect(response.status).to eq 200
      expect(response.body).to include "Album Created!"

      response = get('/albums')
      expect(response.body).to include('The Dark Side of the Moon')
    end
  end
  context "post artist" do
    it "can create a new artist" do
      response = post('/artists', name: 'Pink Floyd', genre: 'Experimental')
      expect(response.status).to eq 200
       expect(response.body).to include "Artist Created!"

      response = get('/artists')
      expect(response.body).to include('Pink Floyd')

    end
  end
  context 'return specific album' do
    it 'returns the first album' do
      response = get('/albums/1')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Artist: Pixies')
      expect(response.body).to include('Release year: 1989')
    end
  end
  context 'GET to /albums' do
    it 'returns 200 OK and all albums' do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include('Title: Doolittle')
      expect(response.body).to include('Release: 1989')
      expect(response.body).to include('<a href="/albums/1">See Doolittle</a>')
      expect(response.body).to include('<a href="/albums/3">See Waterloo</a>')
    end
  end
  context 'GET /artists' do
    it 'returns 200 OK and a specific artist' do
      response = get("/artists/2")
      expect(response.status).to eq (200)
      expect(response.body).to include('ABBA')
      expect(response.body).to include('Genre: Pop')

      response = get("/artists/3")
      expect(response.status).to eq (200)
      expect(response.body).to include('Taylor Swift')
      expect(response.body).to include('Genre: Pop')
    end

    it 'returns 200 OK and all artists' do
      response = get('/artists')
      expect(response.status).to eq 200
      expect(response.body).to include('Name: ABBA')
      expect(response.body).to include('Name: Taylor Swift')
      expect(response.body).to include('Name: Pixies')
      expect(response.body).to include('Name: Nina Simone')

      expect(response.body).to include('Genre: Rock')
      expect(response.body).to include('Genre: Pop')
      expect(response.body).to include('<a href="/artists/2">See ABBA</a>')
      expect(response.body).to include('<a href="/artists/3">See Taylor Swift</a>')
    end

    context "making post request to add new album" do
      it "can take input from the form" do
        response = get('/albums/new')
        expect(response.status).to eq 200
        expect(response.body).to include('<form action="/albums" method="POST">')
      end
    end
    context "making post request to add new artist" do
      it "can take input from the form" do
        response = get('/artists/new')
        expect(response.status).to eq 200
        expect(response.body).to include('<form action="/artists" method="POST">')
      end
    end
  end
end
