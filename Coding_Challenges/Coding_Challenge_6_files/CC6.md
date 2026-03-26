# Question 1

## Regarding reproducibility, what is the main point of writing your own functions and iterations?

### The main point is to independently generate syntax that executes the nuanced needs of your own dataset and analysis, and subsequently run that analysis on specific variables throughout the data set without needing to rewrite and re excute multiple lines of code, avoiding errors that may arise from issues like repetitive copying and pasting.

# Question 2

## Conceptual: In your own words, describe: 1) how to write a function in R, and 2) how to write a for loop in R. In your answer, be specific about: basic syntax, where the code is written, and how results are returned or stored. (Answer in plain text; no code required for this question.)

### 1) To write a unique function In R use function(), use \<- to save it as an named object. Once executed it should show up in the environment as an object under functions. Within the parantheses write the names of the input arguments needed to succesfully return the desired values. After the closed parentheses a curly braceket {} will open. This is where the syntax is written for your desired opertions to be stored. At the end of the desired operations, conversions, etc. use return() to return the desired outcome of the function.

### 2) To write an i for loop write for then open parentheses. Inside write “i in” specified data set or sequence that will be looped. Next, {} will open to write the desired code you want to happen to each iteration within that specified data. The output of the function can bestored as an object and then printed via print().

# Question 3

## Read in the Cities.csv file from Canvas using a relative file path.

``` r
cities <- read.csv("Cities.csv")
head(cities)
```

    ##          city  city_ascii state_id state_name county_fips county_name     lat
    ## 1    New York    New York       NY   New York       36081      Queens 40.6943
    ## 2 Los Angeles Los Angeles       CA California        6037 Los Angeles 34.1141
    ## 3     Chicago     Chicago       IL   Illinois       17031        Cook 41.8375
    ## 4       Miami       Miami       FL    Florida       12086  Miami-Dade 25.7840
    ## 5     Houston     Houston       TX      Texas       48201      Harris 29.7860
    ## 6      Dallas      Dallas       TX      Texas       48113      Dallas 32.7935
    ##        long population density
    ## 1  -73.9249   18832416 10943.7
    ## 2 -118.4068   11885717  3165.8
    ## 3  -87.6866    8489066  4590.3
    ## 4  -80.2101    6113982  4791.1
    ## 5  -95.3885    6046392  1386.5
    ## 6  -96.7667    5843632  1477.2

# Question 4

## Write a function that calculates the distance (in kilometers) between two pairs of geographic coordinates using the Haversine formula.

### a. Function requirements: i. Inputs: lat1, lon1, lat2, lon2, ii. The function must return a single numeric value called distance_km, iii. All code shown below must be placed inside the function body

``` r
gps_to_km <- function(lat1, lon1, lat2, lon2){ #using the haversine formula to create a function named gps_to_km
  rad.lat1 <- lat1 * pi/180
  rad.lon1 <- lon1 * pi/180
  rad.lat2 <- lat2 * pi/180
  rad.lon2 <- lon2 * pi/180
  delta_lat <- rad.lat2 - rad.lat1
  delta_lon <- rad.lon2 - rad.lon1
    a <- sin(delta_lat / 2)^2 + cos(rad.lat1) * cos(rad.lat2) * sin(delta_lon / 2)^2
    c <- 2 * asin(sqrt(a))
      earth_radius <- 6378137
      distance_km <- (earth_radius * c)/1000
      return(distance_km) # returns the difference in a set of gps coordinates 
}
```

# Question 5

## Using your function from question 4, calculate the distance between Auburn, AL and New York City.

### a. Subset or extract only the latitude and longitude values needed from Cities.csv

### b. Pass those values into your function

### c. Store the result in an object

``` r
distance <- cities %>% #object name is distance for the distance between Auburn and NY
  filter(city %in% c("Auburn", "New York")) %>% # select auburn and new york from the data 
    mutate(
    distance_km = gps_to_km(lat[1], long[1], lat[2], long[2]) #using the gps function to calculate the distance between the two  cities
  ) %>%
  pull(distance_km) %>% #pulls data from the column 
  first() #pulls the first value

distance
```

    ## [1] 1367.854

# Question 6

## Use your distance function inside a for loop to calculate the distance between Auburn, AL and every other city in Cities.csv. Each iteration should calculate the distance for one city

``` r
auburn <- cities %>% #dataset
  filter(city == "Auburn") #select auburn from the cities 

distances <- numeric(nrow(cities)) # creats a numeric vector equal to the number of cities

for (i in 1:nrow(cities)) { # runs the loop 
  distances[i] <- gps_to_km( # stores all the iterations in distances
    auburn$lat, auburn$long,
    cities$lat[i], cities$long[i] #changes to the next city
  )
}

cities$distance_from_auburn <- distances # adds the distances to the dataframe cities in a column called distances_from_auburn

cities$distance_from_auburn
```

    ##  [1] 1367.8540 3051.8382 1045.5213  916.4138  993.0298 1056.0217 1239.9732
    ##  [8]  162.5121 1036.9900 1665.6985 2476.2552 1108.2288 3507.9589 3388.3656
    ## [15] 2951.3816 1530.2000  591.1181 1363.2072 1909.7897 1380.1382 2961.1199
    ## [22] 2752.8142 1092.2595  796.7541 3479.5376 1290.5492 3301.9923 1191.6657
    ## [29]  608.2035 2504.6312 3337.2781  800.1452 1001.0879  732.5906 1371.1633
    ## [36] 1091.8970 1043.2727  851.3423 1382.3721    0.0000

# Question 7

## Modify your loop so that each iteration appends one new row to a dataframe with the following columns: City1 (the other city), City2 (Auburn), Distance_km

``` r
how_far <- NULL #creates an empty object

for (i in 1:nrow(cities)){ #runs the loop of all the cities and their distance from auburn
    if (cities$city[i] != "Auburn"){ #checks to see if the iteration is auburn and skips it
        distance <- gps_to_km(
        auburn$lat, auburn$long, cities$lat[i], cities$long[i]
    )
        new_row <- data.frame( # creates a new datframe as the object new_row
        City1 = cities$city[i],
        City2 = "Auburn",
        Distance_km = distance
    )
    how_far <- rbind(how_far, new_row) #Appends the new row to the table "how_far"
  }
}
how_far
```

    ##            City1  City2 Distance_km
    ## 1       New York Auburn   1367.8540
    ## 2    Los Angeles Auburn   3051.8382
    ## 3        Chicago Auburn   1045.5213
    ## 4          Miami Auburn    916.4138
    ## 5        Houston Auburn    993.0298
    ## 6         Dallas Auburn   1056.0217
    ## 7   Philadelphia Auburn   1239.9732
    ## 8        Atlanta Auburn    162.5121
    ## 9     Washington Auburn   1036.9900
    ## 10        Boston Auburn   1665.6985
    ## 11       Phoenix Auburn   2476.2552
    ## 12       Detroit Auburn   1108.2288
    ## 13       Seattle Auburn   3507.9589
    ## 14 San Francisco Auburn   3388.3656
    ## 15     San Diego Auburn   2951.3816
    ## 16   Minneapolis Auburn   1530.2000
    ## 17         Tampa Auburn    591.1181
    ## 18      Brooklyn Auburn   1363.2072
    ## 19        Denver Auburn   1909.7897
    ## 20        Queens Auburn   1380.1382
    ## 21     Riverside Auburn   2961.1199
    ## 22     Las Vegas Auburn   2752.8142
    ## 23     Baltimore Auburn   1092.2595
    ## 24     St. Louis Auburn    796.7541
    ## 25      Portland Auburn   3479.5376
    ## 26   San Antonio Auburn   1290.5492
    ## 27    Sacramento Auburn   3301.9923
    ## 28        Austin Auburn   1191.6657
    ## 29       Orlando Auburn    608.2035
    ## 30      San Juan Auburn   2504.6312
    ## 31      San Jose Auburn   3337.2781
    ## 32  Indianapolis Auburn    800.1452
    ## 33    Pittsburgh Auburn   1001.0879
    ## 34    Cincinnati Auburn    732.5906
    ## 35     Manhattan Auburn   1371.1633
    ## 36   Kansas City Auburn   1091.8970
    ## 37     Cleveland Auburn   1043.2727
    ## 38      Columbus Auburn    851.3423
    ## 39         Bronx Auburn   1382.3721

# Question 8

## Commit and push a gfm .md file to GitHub inside a directory called Coding Challenge 6. Provide me a link to your github written as a clickable link in your rendered .pdf, .docx, or .html

## here is a link to my Coding Challenges [dzt006 plpa assignments Coding Challenges](https://github.com/dzt0062/PLPA_assignments/tree/main/Coding_Challenges)
