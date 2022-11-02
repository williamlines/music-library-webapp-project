# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

  method: GET /artists


## 2. Design the Response

expected response: 200 OK

list of artist


## 3. Write Examples

_Replace these with your own design._

```
# Request:

GET /artists

# Expected response:

Response for 200 OK
Body:
ABBA
Kiasmos
Nina Simone
Pixies
Taylor Swift
```


## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /artists" do
    it 'Gets a list of artists' do
      response = get('/artists')
      expect(response.status).to eq 200
      expect(response.body).to eq('
      ABBA
Kiasmos
Nina Simone
Pixies
Taylor Swift'
)
    end

    
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---
