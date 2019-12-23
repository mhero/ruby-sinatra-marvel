## Dependencies

* Ruby 2.6.5
* Node >= 12.14.0


## Local Development

1. Install dependencies
```
brew install node
\curl -sSL https://get.rvm.io | bash
rvm install "ruby-2.6.5"
rvm use 2.6.5
```

2. Clone repository
3. CD into repository folder

4. Run in command line next:

```
npm install -g yarn
gem install bundler && bundle config jobs 7

cp .env.example .env
cp ./react-marvel/.env.example ./react-marvel/.env

bundle install
cd react-marvel && yarn install
```

5. run backend(on aterminal window)

```
rerun 'rackup -p  4567'
```

6. run frontend(on a different terminal window)

```
cd react-marvel && yarn start
```

