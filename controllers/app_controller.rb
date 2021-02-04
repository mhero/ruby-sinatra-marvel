class AppController < Sinatra::Base
  before do
    headers['Access-Control-Allow-Methods'] = 'GET'
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Headers'] = 'accept, authorization, origin'
  end
  
  options '*' do
    response.headers['Allow'] = 'GET'
    response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
  end

  use Rack::Auth::Basic do |username, password|
    [username, password] == ['admin', 'admin']
  end

  use Rack::Cache,
    :verbose     => true,
    :metastore   => "heap:/",
    :entitystore => "heap:/"

  after do
    expires 300, :public, :'no-cache', :must_revalidate # Expire in 5 minute, require Auth
  end
end