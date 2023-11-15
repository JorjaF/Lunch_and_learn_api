# Lunch_and_learn_api
## Learning Goals
The project aims to expose an API that aggregates data from multiple external APIs, providing users with a unified interface to access diverse information. This is the backend application made to a "frontend" specifications. Comprehensive testing is performed, covering both API consumption and exposure. The project utilizes the mocking tool, Webmock, to simulate external API responses during testing. The API requires an authentication token for access. The project implements Basic Authentication to ensure secure access to the endpoints

## Setting Up the Application
To clone and set up the application, follow these steps:

Clone the repository to your local machine: ```git clone https://github.com/your-username/project-name.git```

Install the following gems ```gem "rspec-rails"``` and ```gem "webmock"``` then run ```bundle install```

Create and migrate the database: ```rails db:create``` and ```rails db:migrate```

Run the server: ```rails server```

## Getting Your API Key
To get an API key:

Create an account by making a POST request to /api/v1/users with the required user information.

After successful account creation, log in using the /api/v1/sessions endpoint with your credentials to obtain the API key.

Keep the API key secure and use it for future API requests.

## Happy Path Endpoint Use
1. Get Recipes by Country ```GET /api/v1/recipes?country=your-country```
2. Get Learning Resources by Country ```GET /api/v1/learning_resources?country=your-country```
3. Create a User Account ```POST /api/v1/users```
4. Log In and Obtain API Key ```POST /api/v1/sessions```
5. Add a Favorite Recipe ```POST /api/v1/favorites```
6. Get User's Favorites ```GET /api/v1/favorites?api_key=your-api-key```

## More info
Include your API key as a parameter in the request.

Keep your API key secure and use it for authorized requests.

Happy coding! 🚀
