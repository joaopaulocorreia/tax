# Start project
docker-compose up -d

# Run seed
docker-compose exec -it app bin/rails db:seed

# Run tests
docker-compose exec -it app bundle exec rspec

# Run rubocop
docker-compose exec -it app bin/rubocop
