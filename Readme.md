# Setup
 
```
 # position in project root dir and run
 docker-compose build app
 
 # init start app
 docker-compose up app
 
 # stop app
 docker-compose down
 
 # NOTE: before you run docker add credential ENV vars into docker-compose.yml 
```

# Usage
```
# opens recipes page 
GET localhost:3000

# opens single recipe
GET localhost:3000/recipes/:id
```

# Test
```
docker-compose run app docker/test.sh
```

# Common problems
```
# If you have permision problem with docker run
chmod +x docker/start.sh
```
