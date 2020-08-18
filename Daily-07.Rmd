---
title: "daily-07"
author: "Devina"
date: "8/18/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


```{r, eval = FALSE}
https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv
```

```{r, message=FALSE, warning=FALSE}
library(tidyverse)
library(ggplot2)

url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'

covid = read_csv(url)

```

```{r}
region = data.frame(state = state.name, region = state.region)
head(region)
```

```{r}
inner_join(covid, region, by = 'state') %>%
  count(region) %>%
  mutate(tot = sum(n))

full_join(covid, region, by = 'state') %>%
  count(region) %>%
  mutate(tot = sum(n))

left_join(covid, region, by = 'state') %>%
  count(region) %>%
  mutate(tot = sum(n))

right_join(covid, region, by = 'state') %>%
  count(region) %>%
  mutate(tot = sum(n))
```
```{r}
covid %>%
  filter(!state %in% state.name) %>%
  filter(date == max(date)) %>%
  count(state)
```
```{r}
(covid %>%
  right_join(region, by = "state") %>%
  group_by(region, date) %>%
  summarize(cases = sum(cases),
            deaths = sum(deaths)) %>%
  pivot_longer(cols = c('cases', 'deaths')) ->
  covid_region)

ggplot(covid_region, aes(x = date, y = value)) +
  geom_line(aes(col = region)) +
  facet_grid(name~region, scale = "free_y") +
  theme_linedraw() +
  theme(legend.position = "NA") +
  theme(axis.text.y = element_text(angle = 45, size = 5)) +
  labs(title = "Cummulative Cases and Deaths per Region",
       y = "Daily Cummulative Count",
       x = "Date",
       caption = "Daily Exercise 07",
       subtitle = "Covid-19 Data: NY Times") +
  theme(plot.subtitle = element_text( color = "dark gray", face = "bold")) +
  theme(plot.title = element_text(color = "dark red", face = "bold")) +
  theme(plot.caption = element_text(color = "light gray", face = "italic"))


```



