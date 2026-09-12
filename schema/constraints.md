# Constraints 

## Primary Key Constraints

- `Users.User_Id` -> UNIQUE, NOT NULL
- `Movies.Movie_Id` -> UNIQUE, NOT NULL
- `Ratings(User_Id, Movie_Id)` -> UNIQUE, NOT NULL
- `Genres.Genre_Id` -> UNIQUE, NOT NULL
- `Movie_Genres(Movie_Id, Genre_Id)` -> UNIQUE, NOT NULL

## Users

`Users(User_Id: integer, Username: String, Email: string, Date_Joined: date)`

- User_Id: UNIQUE, NOT NULL
- Username: NOT NULL
- Email:  UNIQUE, NOT NULL
- Date_Joined: NOT NULL, CHECK valid date, not in the future

## Movies

`Movies(Movie_Id: integer, Title: string, Duration: float, Release_Date: date, Score: float)`

- Movie_Id: UNIQUE, NOT NULL
- Title: NOT NULL
- Duration: NOT NULL, CHECK greater than 0
- Release_Date: NOT NULL, CHECK valid date
- Score: CHECK NULL or greater than or equal to 0

## Ratings

`Ratings(User_Id: integer, Movie_Id: integer, Rating: float, Date: date)`

- (User_Id, Movie_Id): UNIQUE, NOT NULL
- Rating: NOT NULL, CHECK between 0.0 and 5.0
- Date: NOT_NULL, CHECK valid date, not in the future
- FK User_Id: ON DELETE CASCADE
- FK Movie_Id: ON DELETE CASCADE

## Genres

`Genres(Genre_Id: integer, Genre: string)`

- Genre_Id: UNIQUE, NOT NULL
- Genre: UNIQUE, NOT NULL

## Movie_Genres

`Movie_Genres(Movie_Id: integer, Genre_Id: integer)`

- (Movie_Id, Genre_Id): UNIQUE, NOT NULL
- FK Movie_Id: ON DELETE CASCADE
- FK Genre_Id: ON DELETE CASCADE