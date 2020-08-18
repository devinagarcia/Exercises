---
#Devina Garcia Exercise 5#
---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## COVID-19 Data

### Data

We are going to practice some data wrangling skills using a real-world dataset about COVID cases curated and maintained by the New York Times. The data has been used to create reports and data visualizations like [this](https://www.nytimes.com/interactive/2020/us/coronavirus-spread.html?referringSource=articleShare), and are archived on a GitHub repo [here](https://github.com/nytimes/covid-19-data). Looking at the README in this repository we read:
  
  > "We are providing two sets of data with cumulative counts of coronavirus cases and deaths: one with our most current numbers for each geography and another with historical data showing the tally for each day for each geography ... the historical files are the final counts at the end of each day ... The historical and live data are released in three files, one for each of these geographic levels: U.S., states and counties."

For this lab we will use the historic, country level data which is stored as an updating CSV at this URL:
  
  
  ```{r, eval = FALSE}
https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv
```

### Start

I will get you started this week, in the following code chunk, I am attaching the tidyverse package; saving the NY-Times URL as a value called "url"; and I am reading that URL into an object called `covid`

```{r, message=FALSE, warning=FALSE}
library(tidyverse)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

head(covid, 5)
```

Hint: You can print the top X rows of a `data.frame` with `head`. In the above example, I used:
  
  ```{r, eval = FALSE}
head(covid, 5)
```


to print the top 5 columns of the raw covid `object` 

## Question 1: 

Use `dplyr` verbs to  create a data.frame of the **5** counties with the most current cases. Remember, the cases and deaths are cumulative, so you only need to deal with the data for the most current (`max`) date.

(**Hint:** `filter`, `arrange`)

```{r}
counties <- covid %>%
  filter(date==max(date)) %>%
  arrange(desc(cases))
head(counties, 5)
```

## Question 2: 

Use `dplyr` verbs to create a data.frame of the **5** states with the _most_ cases current cases. 

(**Hint:** `filter`, `group_by`, `summarize`, `arrange`)

```{r}
statedata <- covid %>%
  filter(date==max(date)) %>%
  group_by(state) %>%
  summarize(totalstate = sum(cases, na.rm = TRUE),
            n = n())%>%
  arrange(desc(totalstate))
head(statedata, 5)
```

## Question 3: 

Use the `dplyr` verbs to report the **5** counties with the _worst_ current death/cases ratio: (e.g.$100* (deaths/cases)$)

(**Hint:** `filter`, `mutate`, `arrange`)

```{r}
countyratio <- covid %>%
  filter(date==max(date)) %>%
  mutate(ratio = deaths/cases) %>%
  mutate(ratio100 = ratio * 100) %>%
  arrange(-ratio100)
head(countyratio, 5)
```


## Question 4: 

Use the `dplyr` verbs to report the **5** states with the _worst_ current death/case ratio.

(**Hint:** `filter`, `group_by`, `summarize`, `mutate`, `arrange`)

```{r}
stateratio <- covid %>%
  filter(date==max(date)) %>%
  select(state, cases, deaths) %>%
  group_by(state) %>%
  summarize(statecases = sum(cases), statedeaths = sum(deaths)) %>%
  mutate(ratio = statedeaths/statecases) %>%
  mutate(ratio100 = ratio * 100) %>%
  arrange(-ratio100)
head(stateratio, 5)
```


```{r}


```


# END



