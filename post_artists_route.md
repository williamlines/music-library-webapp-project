# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

  method: POST /artists


## 2. Design the Response

expected response: 200 OK

create a new artist, return nothing


## 3. Write Examples

_Replace these with your own design._

```
# Request:

POST /artists?name=Pink Floyd&genre=experimental

# Expected response:

Response for 200 OK
Body: nil

# Request:

Get /artists

# Expected response:

Response for 200 OK
Body:
ABBA
Kiasmos
Nina Simone
Pixies
Taylor Swift
Pink Floyd
```


## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }
  
  context "post artist" do
    it "can create a new artist" do
      response = post('/albums' name: 'Pink Floyd' genre: 'Experimental')
      expect(response.status).to eq 200
      expect(response.body).to eq ""
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---
