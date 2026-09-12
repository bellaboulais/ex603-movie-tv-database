# Schema Definition

## Users

`Users(User_Id: integer, Username: string, Email: string, Date_Joined: date)`

- **PK:** `User_Id`

## Movies

`Movies(Movie_Id: integer, Title: string, Duration: float, Release_Date: date)`

- **PK:** `Movie_Id`

## Ratings

`Ratings(User_Id: integer, Movie_Id: integer, Rating: float, Date: date)`

- **PK:** `(User_Id, Movie_Id)`
- **FK:** `User_Id → Users(User_Id)`
- **FK:** `Movie_Id → Movies(Movie_Id)`

## Genres

`Genres(Genre_Id: integer, Genre: string)`

- **PK:** `Genre_Id`

## Movie_Genres

`Movie_Genres(Movie_Id: integer, Genre_Id: integer)`

- **PK:** `(Movie_Id, Genre_Id)`
- **FK:** `Movie_Id → Movies(Movie_Id)`
- **FK:** `Genre_Id → Genres(Genre_Id)`