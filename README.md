# Whether, Sweater? 🧣 🌤 🚙
#####  Module 3 Turing School of Software and Design Final Project

Reference: [Turing documentation](https://backend.turing.edu/module3/projects/sweater_weather/)

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
     <li>
      <a href="#project-description">About This Project</a>
      <ul>
        <li><a href="#learning-goals-for-project">Learning Goals for Project</a></li>
        <li><a href="#versions">Versions</a></li>
        <li><a href="#important-gems">Important Gems</a></li>
        <li><a href="#database-schema">Database Schema</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#repository-set-up">Set Up</a></li>
        <li><a href="#use-of-this-repository">Use of this Repository</a>
          <ul>
            <li>Backend Server</li>
          </ul>
        </li>
    </li>
    </ul>
    <li>
      <a href="#api">Whether, Sweater? API</a>
      <details>
        <summary>Available Endpoints</summary>
        <ul>
          <li><a href="#forecast-endpoint">Forecast Endpoint</a></li>
          <li><a href="#backgrounds-endpoint">Background Image Endpoint</a></li>
          <li><a href="#user-endpoint">User Endpoint</a></li>
          <li><a href="#session-endpoint">Session Endpoint</a></li>
          <li><a href="#road-trip-endpoint">Road Trip Endpoint</a></li>
        </ul>
      </details>
    </li>
    <li><a href="#contributors">Contributors</a></li>
  </ol>
</details>

----------

## Project Description

This is a back-end project designed to explore the fundamentals of a service-orietned architecture and exposing and API that aggregates data from multiple external APIs in order to meet the specifications and requirements of a theroretical front-end team. Whether, Sweater? will ultimately help users plan road trips by providing current weather data and forecasted weather data at the desired destination. Functionality is achieved by consuming [MapQuest's Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/),  the [OpenWeather One Call API](https://openweathermap.org/api/one-call-api),  [MapQuest's Directions API](https://developer.mapquest.com/documentation/directions-api/),  and the  [Unplash API](https://unsplash.com/developers) to provide tasteful background images for the fictitious front-end views. Users are also stored in the backend database and built out as part of the exposed endpoints to ensure secure registration and login functions. This API also provides and requires an API Key for users to access road trip information. 

## Learning Goals for Project:

Explicit
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Research, select, and consume an API based on your needs as a developer

Implicit
- Project planning
- Reading/Writing documentation
- Time Management/Prioritizing Work

----------

### Versions

- `Ruby 2.7.2`
- `Rails 5.2.6`

----------

### Important Gems

- Testing: 
![Pry][Pry-img]
![RSPEC][RSPEC-img]
![Shoulda Matchers][Shoulda Matchers-img]
![Simplecov][Simplecov-img]
![VCR][VCR-img]

- API: [jsonapi-serializer](https://github.com/fotinakis/jsonapi-serializers), [figaro](https://medium.com/@MinimalGhost/the-figaro-gem-an-easier-way-to-securely-configure-rails-applications-c6f963b7e993)

- User Authentication and Security: [bcrypt](https://github.com/bcrypt-ruby/bcrypt-ruby), [Lockbox](https://github.com/ankane/lockbox), [blind_index](https://github.com/ankane/blind_index)

----------

## Database Schema
```
create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "private_api_key_ciphertext"
    t.string "private_api_key_bidx"
    t.index ["private_api_key_bidx"], name: "index_users_on_private_api_key_bidx", unique: true
  end
```
----------

## Getting Started

### Repository Set Up
On your local system, open a terminal session to run the following commands:
1. Clone this repository `$ git clone git@github.com:Sierra-T-9598/whether_sweater.git`
2. Navigate to the newly cloned directory `$ cd whether_sweater`
3. If bundler is not installed run `$ gem install bundler`
4. If or after bundler is installed run `$ bundle install` to install the required Gems
5. If errors occur, check for proper installation and versions of `bundler`, `ruby`, and `rails`
6. Set up the database locally with `$ rails db:{:drop,:create,:migrate}`
7. Open your text editor and check to see that `schema.rb` exists
8. Run the RSpec test suite locally with the command `$ bundle exec rspec` to ensure everything is functioning as expected.

### External API Set Up
1. Sign up for API keys from the following sources: 
- [MapQuest Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/)
- [MapQuest Directions API](https://developer.mapquest.com/documentation/directions-api/)
- [OpenWeather One Call API](https://openweathermap.org/api/one-call-api)
- [Unsplash API](https://unsplash.com/documentation) 
2. Set up with gem 'figaro': `$ bundle exec figaro install`
3. Navigate to `/config/application.yml`
4. Add your API credentials to the file following this format and ensure that it was properly added to the `.gitignore`:
  ```
  map_quest_api_key: 'YOUR_API_KEY'
  weather_api_key: 'YOUR_API_KEY'
  image_api_key: 'YOUR_API_KEY'
  ```

### Use of this Repository

**Backend Server**
 
On your command line:
1. Navigate to the local directory where the backend repo is housed
2. Run `$ rails s` to run the server locally
3. Open a web browser and navigate to http://localhost:3000/ 
4. Here you are able to explore the endpoints exposed by the API!

----------

## API
Available endpoints

POSTMAN BUTTON

### Forecast endpoint

| http verb | name | params | description | example |
| --- | --- | --- | --- | --- |
| GET | /forecast | location| Returns current, daily, and hourly weather data for the given location | /api/v1/forecast?location=bozeman,mt |

Data sourced from [MapQuest's Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/) and [OpenWeather One Call API](https://openweathermap.org/api/one-call-api)

<details>
    <summary> JSON response examples </summary>

Forecast by location:
  ```
  { "data": { 
      "id":null,
      "type":"forecast",
      "attributes": { 
            "current_weather": {
                  "date_time":"12:28 PM, March 08, -0700",
                  "sunrise":"06:49 AM, March 08, -0700",
                  "sunset":"06:20 PM, March 08, -0700",
                  "temperature":19.87,
                  "feels_like":11.79,
                  "humidity":73,
                  "uvi":2.56,
                  "visibility":10000,
                  "conditions":"overcast clouds",
                  "icon":"04d"},
           "daily_weather": [
              { 
                  "date":"08-03-2022",
                  "sunrise":"06:49 AM, March 08, -0700",
                  "sunset":"06:20 PM, March 08, -0700",
                  "max_temp":24.15,
                  "min_temp":6.08,
                  "conditions":"snow",
                  "icon":"13d"
              },
              {
                  "date":"09-03-2022",
                  "sunrise":"06:48 AM, March 09, -0700",
                  "sunset":"06:21 PM, March 09, -0700",
                  "max_temp":12.7,
                  "min_temp":-5.71,
                  "conditions":"overcast clouds",
                  "icon":"04d"
              },
              {
                  "date":"10-03-2022",
                  "sunrise":"06:46 AM, March 10, -0700",
                  "sunset":"06:22 PM, March 10, -0700",
                  "max_temp":19.89,
                  "min_temp":-5.62,
                  "conditions":"overcast clouds",
                  "icon":"04d"
              },
              {
                  "date":"11-03-2022",
                  "sunrise":"06:44 AM, March 11, -0700",
                  "sunset":"06:24 PM, March 11, -0700",
                  "max_temp":31.68,
                  "min_temp":11.97,
                  "conditions":"light snow", 
                  "icon":"13d"
              },
              {
                  "date":"12-03-2022",
                  "sunrise":"06:42 AM, March 12, -0700",
                  "sunset":"06:25 PM, March 12, -0700",
                  "max_temp":40.44,
                  "min_temp":24.53,
                  "conditions":"overcast clouds",
                  "icon":"04d"
              }
            ],
            "hourly_weather": [
                {"time":"12:00 PM","temperature":19.87,"conditions":"light snow","icon":"13d"},
                {"time":"01:00 PM","temperature":20.01,"conditions":"light snow","icon":"13d"},
                {"time":"02:00 PM","temperature":20.16,"conditions":"light snow","icon":"13d"},
                {"time":"03:00 PM","temperature":20.07,"conditions":"light snow","icon":"13d"},
                {"time":"04:00 PM","temperature":19.62,"conditions":"light snow","icon":"13d"},
                {"time":"05:00 PM","temperature":18.25,"conditions":"light snow","icon":"13d"},
                {"time":"06:00 PM","temperature":16.23,"conditions":"light snow","icon":"13d"},
                {"time":"07:00 PM","temperature":14.02,"conditions":"light snow","icon":"13n"}
            ]
          }
        }
      }
```

</details>


### Backgrounds endpoint

| http verb | name | params | description | example |
| --- | --- | --- | --- | --- |
| GET | /backgrounds | location| Returns an image from the given location | /api/v1/backgrounds?location=bozeman,mt |

Data sourced from [Unplash API](https://unsplash.com/developers)

<details>
  <summary> JSON response examples </summary>

Background Image:
  
  ```
  {
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "location": "chicago,IL",
            "description": "white and brown concrete building",
            "urls": {
                "raw": "https://images.unsplash.com/photo-1602276507033-1bcec514e1ef?ixid=MnwzMDc2NDN8MHwxfHNlYXJjaHwxfHxjaGljYWdvJTJDSUx8ZW58MHx8fHwxNjQ2NzY4NTU1&ixlib=rb-1.2.1",
                "full": "https://images.unsplash.com/photo-1602276507033-1bcec514e1ef?crop=entropy&cs=srgb&fm=jpg&ixid=MnwzMDc2NDN8MHwxfHNlYXJjaHwxfHxjaGljYWdvJTJDSUx8ZW58MHx8fHwxNjQ2NzY4NTU1&ixlib=rb-1.2.1&q=85",
                "regular": "https://images.unsplash.com/photo-1602276507033-1bcec514e1ef?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMDc2NDN8MHwxfHNlYXJjaHwxfHxjaGljYWdvJTJDSUx8ZW58MHx8fHwxNjQ2NzY4NTU1&ixlib=rb-1.2.1&q=80&w=1080",
                "thumb": "https://images.unsplash.com/photo-1602276507033-1bcec514e1ef?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMDc2NDN8MHwxfHNlYXJjaHwxfHxjaGljYWdvJTJDSUx8ZW58MHx8fHwxNjQ2NzY4NTU1&ixlib=rb-1.2.1&q=80&w=200"
            },
            "photographer_credit": {
                "name": "Dylan LaPierre",
                "bio": null,
                "portfolio": "https://api.unsplash.com/users/drench777/portfolio"
            }
        }
    }
}
```

</details>


### User endpoint

| http verb | name | description | example |
| --- | --- | --- | --- |
| POST | /users | Registers a new user in the backend database | /api/v1/users |

<details>
  <summary> JSON request/response examples </summary>

Register User Request:
  ```
  {
  "email": "newest_email@email.com",
  "password": "password",
  "password_confirmation": "password"
  }
```
Created User: 
  ```
  {
    "data": {
        "id": "3",
        "type": "users",
        "attributes": {
            "email": "newest_email@email.com",
            "private_api_key": "<user_api_key>"
        }
    }
}
```

</details>

### Session endpoint

| http verb | name | description | example |
| --- | --- | --- | --- |
| POST | /sessions | Log In an existing user in the backend database | /api/v1/sessions |

<details>
  <summary> JSON request/response examples </summary>

LogIn User Request:
  ```
  {
    "email": "myemail@gmail.com",
    "password": "password"
  }
```
Authenticated Session User: 
  ```
  {
    "data": {
        "id": "1",
        "type": "users",
        "attributes": {
            "email": "myemail@gmail.com",
            "private_api_key": "<user_api_key>"
        }
    }
}
```

</details>

### Road Trip endpoint

| http verb | name | description | example |
| --- | --- | --- | --- |
| POST | /road_trip | Returns road trip data for specified points | /api/v1/road_trip |

<details>
  <summary> JSON request/response examples </summary>

Road Trip Request: 
  ```
  {
    "private_api_key": "<user_api_key>",
    "origin": "Bozeman, MT",
    "destination": "Lyons, CO"
  }
  ```
  
Trip Response: 
  ```
  {
    "data": {
        "id": null,
        "type": "road_trip",
        "attributes": {
            "start_city": "Bozeman, MT",
            "end_city": "Lyons, CO",
            "travel_time": "08:55:04",
            "weather_at_eta": {
                "temperature": 15.01,
                "conditions": "clear sky"
            }
        }
    }
}
  ```
  
</details>


----------

## Contributors

([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <!-- Sierra -->
     <td align="center"><a href="https://github.com/Sierra-T-9598"><img src="https://user-images.githubusercontent.com/87088092/155652453-38a801c4-1243-46ce-a42f-b8416cff0423.png" width="100px;" alt=""/><br /><sub><b>Sierra (she/her)</b></sub></a><br /><a href="https://github.com/Sierra-T-9598/whether_sweater/commits?author=Sierra-T-9598" title="Code">💻</a> <a href="#ideas-Sierra-T-9598" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/Sierra-T-9598/whether_sweater/commits?author=Sierra-T-9598" title="Tests">⚠️</a> <a href="https://github.com/Sierra-T-9598/whether_sweater/pulls?q=is%3Apr+reviewed-by%3ASierra-T-9598" title="Reviewed Pull Requests">👀</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
[LinkedIn](https://www.linkedin.com/in/sierra-tucker-a254201a8/)
  
This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification.
<!-- #### Development -->
[Atom-img]: https://img.shields.io/badge/Atom-66595C.svg?&style=flaste&logo=atom&logoColor=white
[Faraday-img]: https://img.shields.io/badge/faraday-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Figaro-img]: https://img.shields.io/badge/figaro-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Git-img]: https://img.shields.io/badge/Git-F05032.svg?&style=flaste&logo=git&logoColor=white
[Github-img]: https://img.shields.io/badge/GitHub-181717.svg?&style=flaste&logo=github&logoColor=white
[Markdown-img]: https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white
[PostgreSQL-img]: https://img.shields.io/badge/PostgreSQL-4169E1.svg?&style=flaste&logo=postgresql&logoColor=white
[Postman-img]: https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white
[Ruby on Rails-img]: https://img.shields.io/badge/Ruby%20On%20Rails-b81818.svg?&style=flat&logo=rubyonrails&logoColor=white
<!-- [Rubocop-img]: https://img.shields.io/badge/rubocop-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Bootstrap-img]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white -->

<!-- #### Languages -->
[ActiveRecord-img]: https://img.shields.io/badge/ActiveRecord-CC0000.svg?&style=flaste&logo=rubyonrails&logoColor=white
[Ruby-img]: https://img.shields.io/badge/Ruby-CC0000.svg?&style=flaste&logo=ruby&logoColor=white
<!-- [CSS3-img]: https://img.shields.io/badge/CSS3-1572B6.svg?&style=flaste&logo=css3&logoColor=white
[HTML5-img]: https://img.shields.io/badge/HTML5-0EB201.svg?&style=flaste&logo=html5&logoColor=white -->

<!-- #### Deployment -->
<!-- [Heroku-img]: https://img.shields.io/badge/Heroku-430098.svg?&style=flaste&logo=heroku&logoColor=white
[Circle CI-img]: https://img.shields.io/badge/-CircleCi-brightgreen.svg?logo=LOGO -->


<!-- #### Testing -->
[Pry-img]: https://img.shields.io/badge/pry-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[RSPEC-img]: https://img.shields.io/badge/rspec-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Shoulda Matchers-img]: https://img.shields.io/badge/shoulda--matchers-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Simplecov-img]: https://img.shields.io/badge/simplecov-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[VCR-img]: https://img.shields.io/badge/vcr-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
<!-- [Webmock-img]: https://img.shields.io/badge/webmock-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Capybara-img]: https://img.shields.io/badge/capybara-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Launchy-img]: https://img.shields.io/badge/launchy-b81818.svg?&style=flaste&logo=rubygems&logoColor=white -->

<!-- #### Development Principles -->
[OOP-img]: https://img.shields.io/badge/OOP-b81818.svg?&style=flaste&logo=OOP&logoColor=white
[TDD-img]: https://img.shields.io/badge/TDD-b87818.svg?&style=flaste&logo=TDD&logoColor=white
[MVC-img]: https://img.shields.io/badge/MVC-b8b018.svg?&style=flaste&logo=MVC&logoColor=white
[REST-img]: https://img.shields.io/badge/REST-33b818.svg?&style=flaste&logo=REST&logoColor=white
