---
title: "Daily 08"
author: "Devina Garcia"
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
install.packages("zoo")
library(zoo)
install.packages("knitr")
library(knitr)
install.packages("kableExtra")
library(kableExtra)


```

```{r}
state.of.interest = "California"

covid %>%
  filter(state == state.of.interest) %>%
  group_by(date) %>%
  summarise(cases = sum(cases)) %>%
  mutate(newCases = cases - lag(cases),
         roll7 = rollmean(newCases, 7, fill = NA, align="right")) %>%
ggplot(aes(x = date)) +
  geom_col(aes(y = newCases), col = NA, fill = "#F5B8B5") +
  geom_line(aes(y = roll7), col = "darkred", size = 1) +
  labs(title = paste("New Reported Cases by Day in", state.of.interest)) +
  theme(plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"),
        plot.title = element_text(size = 14, face = 'bold')) +
  theme(aspect.ratio = .5) 
          
```

```{r}
dat = covid %>%
  filter(state == "California") %>%
  group_by(county) %>%
  mutate(newCases = cases - lag(cases)) %>%
  ungroup() %>%
  filter(date == max(date))

(most_new_cases = dat %>%
    slice_max(newCases, n = 5) %>%
    select(county, newCases))

knitr::kable(most_new_cases, caption = "New Cases in California Counties",
             col.names = c("County", "New Cases"),
             format.args = list(big.mark = ",")) %>%
kableExtra::kable_styling("striped", full_width = TRUE, font_size = 14)
```

