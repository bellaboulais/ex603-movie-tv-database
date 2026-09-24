# Unit 2 Analysis

### Your script encodes decisions it cannot explain. Write it in /analysis/unit2.md.

## The constraints table

| Foreign Key | ON DELETE | Reason |
|---|---|---|
| `Ratings.User_Id → Users.User_Id` | `CASCADE` | If a user is deleted, their ratings should also be deleted because the ratings belong to that user and I don't want stale ratings. |
| `Ratings.Movie_Id → Movies.Movie_Id` | `CASCADE` | If a movie is deleted, its ratings should also be deleted because the ratings cannot exist without the movie. |
| `Movie_Genres.Movie_Id → Movies.Movie_Id` | `CASCADE` | If a movie is deleted, its movie-genre relationships should also be deleted because the relationship no longer exists. |
| `Movie_Genres.Genre_Id → Genres.Genre_Id` | `CASCADE` | If a genre is deleted, its movie-genre relationships should also be deleted because the relationship no longer exists. |

1. If a user deletes their account, their rating should be deleted too. I made this decision, because if we kept the old one with null, a user could recreate an account and re-rate the movie, and then there would be 2 ratings by the same person. I also felt if a user deleted their account, that implies they want their data deleted, so this choice respects data privacy.
2. If a movie is deleted from the system, its ratings would be stale data if it did not get deleted to. For example, a user could look at their ratings and would just see 3.4 for movie NULL. This is not desired. 
3. If a movie is deleted from the system, there is no more relationship for the genre to be attached to. In the movie_genres table, we would see the genre and a null value, which holds no valuable information for us. 
4. Similar to #3, if the genre is deleted it's movie-genre relationship should be deleted too. We do not want to keep a movie and null genre value. Most likely, this would happen if a sub-genre is deleted, so there is probably another genre relationship with the movie elsewhere. 

## The CHECK constraints

1. CONSTRAINT chk_valid_rating CHECK (rating <= 5 and rating >= 0)

This check ensures a user cannot make negative rating or a rating greater than 5. Without this constriant, the ratings would hold no value, because its scale would not be enforced. One user might try to rate 0-10 while another rates by 0-5. 

2. CONSTRAINT chk_valid_genre CHECK (genre in ...)

This check ensures a genre cannot be mispelled or abbreviated and reduces the risk of user/sysetm data-insertion errors. When the system goes to search through genres, this check ensures the search is accurate and does not miss data because of inconsistent names. 