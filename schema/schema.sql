-- ============================================================================
-- EX 603 Assignment 2 — schema.sql
-- Theme: Movie/Tv
-- Author: Isabella Boulais
-- Target: PostgreSQL 14+
-- ============================================================================
-- Reset. Reverse creation order, so no dependency blocks a drop.
DROP TABLE IF EXISTS genres         CASCADE;
DROP TABLE IF EXISTS movie_genres   CASCADE;
DROP TABLE IF EXISTS movies         CASCADE;
DROP TABLE IF EXISTS ratings        CASCADE;
DROP TABLE IF EXISTS users          CASCADE;

-- ----------------------------------------------------------------------------
-- 1. user — first, because it references nothing.
-- ----------------------------------------------------------------------------
CREATE TABLE users
(
    user_id     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username    VARCHAR(100) NOT NULL,
    email       VARCHAR(255) NOT NULL UNIQUE,
    date_joined TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- ----------------------------------------------------------------------------
-- 2. movies — second, because it references nothing.
-- ----------------------------------------------------------------------------
CREATE TABLE movies
(
    movie_id        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title           VARCHAR(100) NOT NULL,
    duration_min    INTEGER NOT NULL,
    release_date    DATE NOT NULL
);
-- ----------------------------------------------------------------------------
-- 3. ratings — third, because it references the user table and movies table.
-- ----------------------------------------------------------------------------
CREATE TABLE ratings
(
    rating_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id     INTEGER NOT NULL,
    movie_id    INTEGER NOT NULL,
    rating      NUMERIC(3,2) NOT NULL,
    comment     VARCHAR(255),
    date        TIMESTAMP NOT NULL,
    CONSTRAINT chk_ratings_movie_user
        UNIQUE (user_id, movie_id),
    CONSTRAINT fk_ratings_user
        FOREIGN KEY (user_id) REFERENCES users (user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_ratings_movie
        FOREIGN KEY (movie_id) REFERENCES movies (movie_id)
        ON DELETE CASCADE,
    CONSTRAINT chk_valid_rating
        CHECK (rating <= 5 and rating >= 0)
);
-- ----------------------------------------------------------------------------
-- 4. genres — fourth, because it does not reference user, movies, or ratings
-- ----------------------------------------------------------------------------
CREATE TABLE genres
(
    genre_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    genre    VARCHAR(100) UNIQUE NOT NULL,
    CONSTRAINT chk_valid_genre
        CHECK (genre in ('Action','Adventure','Adult Animation','Animation',
                         'Anime','Biography','Comedy','Crime','Documentary',
                         'Drama','Family','Fantasy','Game Show','History',
                         'Horror','Independent','International','LGBTQ+',
                         'Music','Musical','Mystery','Reality TV','Romance',
                         'Science Fiction','Short','Sports','Stand-Up Comedy',
                         'Talk Show','Thriller','True Crime','War','Western',
                         'Action Adventure','Action Comedy','Action Epic',
                         'Action Thriller','Alien Sci-Fi','Animal Tales',
                         'Art House','Backstage Musical','B-Horror',
                         'Biographical Documentary','Black Comedy',
                         'Body Horror','British Reality','Buddy Comedy',
                         'CGI Animation','Chilling Horror','Classic Movies',
                         'Claymation','Coming-of-Age','Conspiracy Thriller',
                         'Contemporary Fantasy','Contemporary Romance',
                         'Cosmic Horror','Courtroom Drama','Cozy Mystery',
                         'Crime Action','Crime Documentary','Crime Drama',
                         'Crime Thriller','Cyberpunk','Dark Comedy',
                         'Dark Fantasy','Dark Romance','Detective','Disaster',
                         'Docuseries','Domestic Drama','Dystopian',
                         'Dystopian Sci-Fi','Epic','Epic Fantasy',
                         'Erotic Thriller','Experimental','Family Drama',
                         'Fantasy Movie','Fantasy Sci-Fi','Film-Noir',
                         'Folk Horror','Food & Travel','Foreign Documentaries',
                         'Found Footage','Gallows Humor','Gothic Horror',
                         'Heist','High Fantasy','Historical Drama',
                         'Historical Romance','Historical War','Home Invasion',
                         'Hospital Drama','Independent Drama',
                         'Intergenerational','Jukebox Musical','Kids Animation',
                         'Legal Thriller','Lifestyle','Magical Realism',
                         'Martial Arts','Medical Drama','Melodrama','Military',
                         'Military Documentary','Military Sci-Fi',
                         'Mockumentary','Monster Movie',
                         'Multi-Timeline Narrative','Mythology & Folk Tale',
                         'Neo-Noir','Non-Linear Narrative','Occult',
                         'One-Person Army Action','Paranormal Romance','Parody',
                         'Period Drama','Period Piece','Physical Danger',
                         'Police Procedural','Political Drama',
                         'Political Western','Pop-Culture Satire',
                         'Post-Apocalyptic','Psychological Drama',
                         'Psychological Horror','Psychological Thriller',
                         'Raunchy Comedy','Revenge Thriller',
                         'Revisionist Western','Romantic Comedy',
                         'Romantic Drama','Satire','Sci-Fi Adventure',
                         'Sci-Fi Horror','Sci-Fi Thriller','Screwball Comedy',
                         'Serial Killer','Sitcom','Sketch Comedy','Slasher',
                         'Social Drama','Southern Gothic','Space Opera',
                         'Space Western','Spaghetti Western','Splatter',
                         'Sports Documentary','Sports Drama','Stage Musical',
                         'Steampunk','Steamy Romance','Steamy Thriller',
                         'Supernatural Horror','Supernatural Mystery',
                         'Superhero','Survival Adventure','Survival Horror',
                         'Surgical Interns','Swashbuckler','Tech Noir',
                         'Techno-Paranoia','Techno-Thriller','Teen Comedies',
                         'Teen Drama','Teen Screams','Teen TV','Time Travel',
                         'Traditional Animation','True Crime Parody',
                         'Urban Fantasy','Vigilante Justice','Virtual Reality',
                         'Webnovel Adaptation','Whodunit',
                         'Witchcraft & Dark Arts','Workplace Comedy','Zombie'))
);
-- ----------------------------------------------------------------------------
-- 5. movie_genres — fifth, because it references movies and genres
-- ----------------------------------------------------------------------------
CREATE TABLE movie_genres
(
    genre_id INTEGER NOT NULL,
    movie_id INTEGER NOT NULL,
    CONSTRAINT pk_movie_genres PRIMARY KEY(genre_id, movie_id),
    CONSTRAINT fk_movie_genres_genre
        FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_movie_genres_movie
        FOREIGN KEY (movie_id) REFERENCES movies (movie_id)
        ON DELETE CASCADE
)