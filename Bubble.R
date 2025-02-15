# plot for project 1

#convert wide to long 
# install.packages("ggrepel")
require("ggrepel")
require("tidyverse")
require("readr")
require("ggplot2")

setwd('/Users/yirenlu/Documents/data_studio/olympic_us')
df <- read_csv('bubble.csv')

df$male_pct <- as.numeric(sub("%","",df$male_pct))

df$female_pct <- as.numeric(sub("%","",df$female_pct))

df_long <- df %>%
  pivot_longer(
    cols = -Sport, # Keep 'Sport' as the identifier
    names_to = c("gender", "variable"), # Split column names into 'variable' and 'gender'
    names_sep = "_" # Separate column names by underscore
  ) %>%
  pivot_wider(
    names_from = "variable", # Spread 'variable' into separate columns
    values_from = "value" # Use the values from the 'value' column
  )

df_long[df_long == 0] <- NA

#label for dominant sports
dominant <- df_long$Sport %in% c("Athletics", "Gymnastics", "Artistic Gymnastic", "Swimming")

# scatter plot -- Complete
complete <- ggplot(df_long) +
  aes(x = pct, y = average, fill = gender, size = owned, color=Sport) +
  geom_point(alpha = .7,troke = 1, shape = 21) +
  scale_size_continuous(range = c(5,20)) +
  labs(title="medal counts",
       subtitle = "Contribution to the total medalsvs no. of athletes per sport,
       size represents total medals by sport",
       x = 'Percetage of medals by sport',
       y = 'Medals per anthlete by sport',
       color = "Gender") +
  xlim(0,100) +
  ylim(0,1.25) +
  theme_minimal() +
  theme(plot.title.position = 'plot', legend.position = "top") +
  #set colors legends
  scale_fill_manual(values = c("male" = "lightblue", "female" = "lightcoral")) +
  guides(size = "none", alpha = "none") +
  theme(legend.position = "right")

complete


# for the Display
Display <- ggplot(df_long) +
  aes(x = pct, y = average, 
      fill = gender, 
      size = owned,
      color=Sport) +
  geom_point(alpha = .7,
             stroke = 1.5, 
             shape = 21) +
  scale_size_continuous(range = c(5,20)) +
  labs(color = "Sports",
       x = 'Percetage of medals by sport',
       y = 'Medals per anthlete by sport') +
  xlim(0,100) +
  ylim(0,1.25) +
  theme_minimal() +
  theme(plot.title.position = 'plot',legend.position = c(0.1,0.9)) +
  labs(
    title = "Female Athletes Have Higher Medal Counts Per Perseon and Percentage Contribution"
  )+
  #set colors
  scale_fill_manual(values = c("male" = "lightblue", "female" = "lightcoral")) +
  guides(size = "none", alpha = "none") +
  theme(legend.position = "right") 

Display

# Only for dominant sport
main <- ggplot(data = subset(df_long,dominant)) +
  aes(x = pct, y = average, fill = gender, size = owned, color = Sport) +
  geom_point(alpha = .7,stroke = 2, shape = 21) +
  #highlight over 50%
  geom_point(data = subset(df_long, df_long$Sport %in% c("Swimming", "Gymnastics")&df_long$pct > 50),  
             aes(x = pct, y = average, size = owned, alpha = .1),
             show.legend = FALSE,
             color = "yellow", stroke = 1, shape = 21) +
  # add the 50% line 
  geom_vline(xintercept = 50,
             linetype = "dotted",
             color = "coral",
             alpha = .7 ) +
  # add labels of the 50% line
  geom_text(data = df_long, aes(x=53,y=1.1),
            label = "50% of the medals",
            color = "coral",
            alpha = .7,
            size = 3,
            hjust = 0.7) +
  # label for total number owned
  geom_text_repel(data = subset(df_long, dominant), 
                  aes(label = owned), 
                  vjust = -3, size = 4,
                  segment.color = "grey",
                  segment.linetype = "dotted",
                  color = "darkgrey",
                  show.legend = FALSE) +
  scale_size_continuous(range = c(5,20)) +
  labs(color = "Gender",
       x = 'Percetage of medals by sport',
       y = 'Medals per anthlete by sport',
       title = "Female Swimmers and Gymnnasts Contribute to More Than 50%",
       subtitle = "Female swimmers and gymnasts also have the highest no. of medals per person") +
  xlim(0,100) +
  ylim(0,1.25) +
  theme_minimal() +
  theme(plot.title.position = 'plot',legend.position = c(0.1,0.9)) +
  #set colors
  scale_fill_manual(values = c("male" = "lightblue", "female" = "lightcoral")) +
  guides(size = "none", alpha = "none") +
  theme(legend.position = "right") 

main

# Other Sport -- Only female
other<-ggplot(data = subset(df_long,!dominant&df_long$gender=="female")) +
  aes(x = pct, y = average, fill = gender, size = owned, color = Sport) +
  geom_point(alpha = .7) +
  scale_size_continuous(range = c(5,20)) +
  # label sports
  geom_text_repel(data = subset(df_long, !dominant&gender=="female"&pct > 50), 
                  aes(label = Sport, color = Sport), 
                  vjust = -2, size = 3,hjust = 1.5,
                  segment.color = "grey",
                  segment.linetype = "dotted",
                  show.legend = FALSE) +
  # add the 50% line 
  geom_vline(xintercept = 50,
             linetype = "dotted",
             color = "coral",
             alpha = .7 ) +
  # add labels of the 50% line
  geom_text(data = df_long, aes(x=55,y=1.15),
            label = "50% of the medals",
            color = "coral",
            alpha = .7,
            size = 3,
            hjust = 0.7) +
  labs(color = "Sport",
       x = 'Percentage of medals by sport',
       y = 'Medals per anthlete by sport',
       title = "Female Athletes Won over 50% in Other 11 Sports",
       subtitle = "Among other 26 sports, females won over 50% of the medals in 11 of them and half in 3") +
  xlim(0,100) +
  ylim(0,1.25) +
  theme_minimal() +
  theme(plot.title.position = 'plot',legend.position = c(0.1,0.9)) +
  #set colors
  scale_fill_manual(values = c("male" = "lightblue", "female" = "lightcoral")) +
  guides(size = "none", alpha = "none",fill="none") +
  theme(legend.position = "right")

other

#bar
main

historical <- read_csv("Female_pct_historical.csv")
historical$color <- ifelse(historical$year == 2024, "lightcoral", "grey")

Total_bar <- ggplot(historical) +
  aes(x = as.Date(paste0(year, "-01-01")),y=female_pct,fill = color)+
  geom_col() +
  geom_hline(yintercept = 50, 
             linetype = "dotted",
             color = "lightcoral",
             size = 0.5) +
  geom_text(x=as.Date("2000-01-01"), 
            y=53, 
            label="50% of medals",
            color = "coral") +
  labs(
       title = "Females have been winning over 50% since 2008.",
       subtitle = "Percentage of medals won by female athletes since 1984")+
  scale_x_date(
    breaks = as.Date(c("2008-01-01", "2024-01-01")),  # Set breaks only for 2008 and 2024
    labels = c("2008", "2024")  # Set the corresponding labels
  )  +
  geom_rect(data = historical, 
            aes(
              xmin = as.Date("2006-01-01"),xmax=as.Date("2026-01-01"),
                               ymin = 0, ymax = 60,
                fill = "yellow"), 
            alpha = 0.01, 
            inherit.aes = FALSE) +
  theme_minimal() +
  scale_fill_identity() +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank())

Total_bar
Display
main
other
ggsave("Historical_trend.png",Total_bar)
ggsave("team.png",Display)
ggsave("dominant.png",main)
ggsave("niche.png",other)
