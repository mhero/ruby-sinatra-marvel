## Dependencies

* Ruby 2.6.6
* Node >= 12.14.0

## Apps info
 * Sinatra app runs in port 4567 (using this default config)
 * React app runs in port 3000 (using this default config)

## Cloud Deploy
```
gcloud app deploy --project dbtesting-21ddf app.yaml react-marvel/appfront.yaml
gcloud app versions list | grep -v SERVING | awk '{print $2}' | tail -n +1 | xargs -I {} gcloud app versions delete {}
https://console.cloud.google.com/appengine/services?project=dbtesting-21ddf
gcloud app browse
gcloud app browse -s appfront
```

## Local Development
## Docker install

1. Install dependencies
```
https://www.docker.com/products/docker-desktop
```

2. Clone repository
3. cd into repository folder

4. Create env files for sinatra and react (replace variables with credentials and server variables)
```
cp .env.example .env
cp ./react-marvel/.env.example ./react-marvel/.env
```

5. Run
```
docker-compose up
```

## Full install

1. Install dependencies
```
brew install node
\curl -sSL https://get.rvm.io | bash
rvm install "ruby-2.6.6"
rvm use 2.6.6
```

2. Clone repository
3. cd into repository folder

4. Run in command line next:
```
npm install -g yarn
gem install bundler && bundle config jobs 7
```

5. Create env files for sinatra and react (replace variables with credentials and server variables)
```
cp .env.example .env
cp ./react-marvel/.env.example ./react-marvel/.env
```

6. Run in command line next:
```
bundle install
cd react-marvel && yarn install
```

7. run backend (on aterminal window)
```
rerun 'rackup -p  4567'
```

8. run frontend (on a different terminal window)
```
cd react-marvel && yarn start
```