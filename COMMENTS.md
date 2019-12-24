- I decided to create an app based on server-client API 
- Using Sinatra to avoid boiler plate code of other frameworks
- Using react to render data easily
- I had in mind that would be better to have 2 separated projects but in the same repo, some reasons:
  - Unified versioning, one source of truth
  - Extensive code sharing and reuse
  - Simplified dependency management
  - Atomic changes
  - Collaboration across teams

Backend:
- I'm using pretty much standard Sinatra config, API with all endpoints in one controller(because it's a small app)
- I'm serializing my response, to have it consumed by the client easily
- I'm returning, in the mentioned response, models created by me to:
  - Add some extra functionality(e.g. thumbnails)
  - Possibly have it cached on my server(if allowed, or temporary cache)
  - Throw my own statuses(e.g. Marvel doesn't throw 204 or 404 when a search was empty)
- For the services
  - I'm authorizing (in Marvel::Auth) using Marvel API using the keys from my account, according to what the service expects
  - Using a Marvel::Http to create requests to Marvel API
  - Using Faraday because:
    - It's reliable
    - I can change the adapter(I'm using the default: Net::HTTP)
    - Great middleware, to allow catch and log server errors on Marvel API(including timeouts)
  - I'm logging all errors because I think it's important to have a trace without giving the client too much info
  - Using Marvel::Client to handle all requests to Marvel::Http
  - Finally ResponseHandler is used to:
    - Check Marvel's response status
    - Validate Marvel's response content(e. g. if it's empty or not)
    - Return the parsed results from Marvel response

Testing:
  - I added some tests using rspec, vcr and simplecov
  - Using vcr to avoid hitting Marvel's API for every test
  - Checking the body on the vcr cassette, because the whole response is not deterministic
  - Using simplecov as a measure

Frontend:
  - Using react and axios
  - Using react hooks to handle states
  - Using axios to fetch the data from endpoints

Improvements:
  Some things I have in mind that may need a little more of time:
  - Caching response from Marvel's API(using redis in case it's protected content)
  - Caching request to my API using sinatra cache(POC on branch cache)
  - Using JWT on my endpoints to validate request
  - Create login/user limit to avoid abuse of my endpoints
  - Handling pagination on frontend(e.g. stories currently showing only the first 10)
  - Testing in frontend(with react-testing-library)
  - If the app would need it, create separate components for react