# GET /artists Route Design Recipe

## 1. Design the Route Signature

Include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

Method: GET
Path: /artists
Query Parameters:
  none
Body Parameters:
  none

## 2. Design the Response

```
Pixies, ABBA, Taylor Swift, Nina Simone
```

## 3. Write Examples

```
# Request:

GET /artists

# Expected response:
Pixies, ABBA, Taylor Swift, Nina Simone
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = get('/posts?id=1')

      expect(response.status).to eq(200)
      # expect(response.body).to eq(expected_response)
    end

    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.