
# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

  Method: Get


## 2. Design the Response
Surfer Rosa
Waterloo


## 3. Write Examples

_Replace these with your own design._

```
# Request:

GET /albums

# Expected response:

Response for 200 OK

Surfer Rosa
Waterloo
Super Trouper
Bossanova
Lover
Folklore
I Put a Spell on You
Baltimore
Here Comes the Sun
Fodder on My Wings
Ring Ring
```

```
# Request:

GET /posts?id=276278

# Expected response:

Response for 404 Not Found
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

context 'GET /albums'
  it 'should return the list of albums' do
    response = get('/albums')
    expected_response = ('Surfer Rosa
Waterloo
Super Trouper
Bossanova
Lover
Folklore
I Put a Spell on You
Baltimore
Here Comes the Sun
Fodder on My Wings
Ring Ring'
    )
    
    expect(response.status).to eq 200
    expect(response.body).to eq expected_response

  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---
