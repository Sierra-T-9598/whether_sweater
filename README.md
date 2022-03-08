# Whether, Sweater?
#####  Module 3 Turing School of Software and Design Final Project

Reference: [Turing documentation](https://backend.turing.edu/module3/projects/sweater_weather/)

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#set-up">Set Up</a></li>
        <li><a href="#use-of-this-repository">Use of this Repository</a>
          <ul>
            <li>Backend Server</li>
          </ul>
        </li>
    </li>
    </ul>
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
      <a href="#apis">Whether, Sweater? API</a>
      <details>
        <summary>Available Endpoints</summary>
        <ul>
          <li><a href="#forecast-endpoint">Forecast Endpoint</a></li>
          <li><a href="#backgrounds-endpoint">Background Image Endpoint</a></li>
          <li><a href="#user-endpoints">User Endpoints</a></li>
          <li><a href="#road-trip-endpoints">Road Trip Endpoints</a></li>
        </ul>
      </details>
    </li>
    <li><a href="#contributors">Contributors</a></li>
  </ol>
</details>

----------

## Getting Started

### Set Up
On your local system, open a terminal session to run the following commands:
1. Clone this repository `$ git clone git@github.com:Sierra-T-9598/whether_sweater.git`
2. Navigate to the newly cloned directory `$ cd whether_sweater`
3. If bundler is not installed run `$ gem install bundler`
4. If or after bundler is installed run `$ bundle install` to install the required Gems
5. If errors occur, check for proper installation and versions of `bundler`, `ruby`, and `rails`
6. Set up the database locally with `$ rails db:{:drop,:create,:migrate,:seed}`
7. Open your text editor and check to see that `schema.rb` exists
8. Run the RSpec test suite locally with the command `$ bundle exec rspec` to ensure everything is functioning as expected.

### Use of this Repository

**Backend Server**
 
On your command line:
1. Navigate to the local directory where the backend repo is housed
2. Run `$ rails s` to run the server locally
3. Open a web browser and navigate to http://localhost:3000/ 
4. Here you are able to explore the endpoints exposed by the API!

----------

## Project Description

This is a back-end project designed to explore the fundamentals of a service-orietned architecture and exposing and API that aggregates data from multiple external APIs in order to meet the specifications and requirements of a theroretical front-end team. Whether, Sweater? will ultimately help users plan road trips by providing current weather data and forecasted weather data at the desired destination. Functionality is achieved by consuming [MapQuest's Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/), the [OpenWeather One Call API](https://openweathermap.org/api/one-call-api), [MapQuest's Directions API](https://developer.mapquest.com/documentation/directions-api/), and the [Unplash API](https://unsplash.com/developers) to provide tasteful background images for the front-end views. Users are also stored in the backend database and built out as part of the exposed endpoints to ensure secure registration and login functions. This API also provides and requires an API Key for users to access road trip information. 

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

- Ruby 2.7.2
- Rails 5.2.6

----------

### Important Gems

- Testing: [rspec-rails](https://github.com/rspec/rspec-rails), [simplecov](https://github.com/simplecov-ruby/simplecov), [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails), [faker](https://github.com/vajradog/faker-rails), [webmock](https://github.com/bblimke/webmock), [vcr](https://github.com/vcr/vcr)

- API: [jsonapi-serializer](https://github.com/fotinakis/jsonapi-serializers), [figaro](https://medium.com/@MinimalGhost/the-figaro-gem-an-easier-way-to-securely-configure-rails-applications-c6f963b7e993)

- User Authentication and Security: [bcrypt](https://github.com/bcrypt-ruby/bcrypt-ruby), [Lockbox](https://github.com/ankane/lockbox), [blind_index](https://github.com/ankane/blind_index)

----------

## Database Schema

----------

## APIs
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


</details>


### Backgrounds endpoint

| http verb | name | params | description | example |
| --- | --- | --- | --- | --- |
| GET | /backgrounds | location| Returns an image from the given location | /api/v1/backgrounds?location=bozeman,mt |

Data sourced from [Unplash API](https://unsplash.com/developers)

<details>
  <summary> JSON response examples </summary>

Background Image:


</details>


### User endpoints

| http verb | name | data type | description | example |
| --- | --- | --- | --- | --- |
| GET | /users | String | Returns all users | /api/v1/users |
| GET | /users/:id | Integer | Returns a single user based on id | /api/v1/users/{{users id}} |
| GET | /users/:id/clubs | String | Returns all clubs that a specific user belongs to | /api/v1/users/{{user_id}}/clubs |
| PATCH/PUT | /users/:id | | Edits a single user based on id | /api/v1/comments/{{user_id}} |
| DELETE | /users/:id | | Deletes a single user based on id | /api/v1/comments/{{user_id}} |

<details>
  <summary> JSON response examples </summary>

All users:

</details>


### Road Trip endpoints

| http verb | name | data type | description | example |
| --- | --- | --- | --- | --- |
| GET | /clubs | String | Returns all clubs | /api/v1/clubs |
| GET | /clubs/:id | Integer | Returns a single club based on id | /api/v1/clubs/{{club_id}} |
| GET | /clubs/:id/users | String | Returns all users belonging to a specific club | /api/v1/clubs/{{club_id}}/users |
| GET | /clubs/:id/comments | String | Returns all comments belonging to a specific club | /api/v1/clubs/{{club_id}}/comments |
| PATCH/PUT | /clubs/:id| | Edits a specific club's data | /api/v1/clubs/{{club_id}} |
| DELETE | /clubs/:id| | Deletes a specific club's data | /api/v1/clubs/{{club_id}} |


<details>
  <summary> JSON response examples </summary>

All clubs:
  
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

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification.
<!--
