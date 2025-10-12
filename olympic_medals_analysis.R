# ===============================================================
# Rio 2016 Olympics Medals Analysis (Base R)
# Author: Uche Dumzo-Ajufo
# Date: 12/10/2025
# Description: Data analysis and visualisation of Rio 2016 medal results
# ===============================================================

# Clear environment and console
rm(list = ls())
cat("\014")

# Loading data
rio2016 <- read.csv("C:/Users/udumz/OneDrive/Documents/Rio2016.csv", header = TRUE)

# Creating total medals column
rio2016$Total <- rio2016$Gold + rio2016$Silver + rio2016$Bronze

# Sort by total medals
rio2016 <- rio2016[order(-rio2016$Total), ]

# Create outputs folder if it doesn't exist
if(!dir.exists("outputs")) {
  dir.create("outputs")
}

# Summary statistics
cat("Total medals awarded:", sum(rio2016$Total), "\n")
cat("Country with most gold medals:", rio2016$Country[which.max(rio2016$Gold)], "\n")
cat("Country with most total medals:", rio2016$Country[which.max(rio2016$Total)], "\n\n")

# Bar plot showing total medals by country
png("outputs/total_medals.png", width = 1000, height = 600)
barplot(rio2016$Total,
        names.arg = rio2016$Country,
        las = 2,
        col = "skyblue",
        cex.names = 0.7,
        main = "Total Medals by Country (Rio 2016)",
        xlab = "Country",
        ylab = "Number of Total Medals")
dev.off()

# Bar plot showing top 10 countries by total medals
top10 <- rio2016[1:10, ]

png("outputs/top10_medals.png", width = 800, height = 600)
bp <- barplot(top10$Total,
              names.arg = top10$Country,
              las = 2,
              col = "lightgreen",
              main = "Top 10 Countries by Total Medals (Rio 2016)",
              xlab = "Country",
              ylab = "Number of Total Medals")
# Add numerical labels above bars
text(bp, top10$Total, labels = top10$Total, pos = 3, cex = 0.8)
dev.off()

# Stacked bar chart showing Gold, Silver, Bronze comparison
medals_matrix <- as.matrix(rio2016[, c("Gold", "Silver", "Bronze")])
rownames(medals_matrix) <- rio2016$Country

png("outputs/stacked_medals.png", width = 1000, height = 600)
barplot(t(medals_matrix),
        beside = FALSE,
        col = c("gold", "grey70", "brown"),
        main = "Rio 2016 Medals by Type",
        xlab = "Country",
        ylab = "Number of Medals",
        las = 2)

legend("topright",
       legend = c("Gold", "Silver", "Bronze"),
       fill = c("gold", "grey70", "brown"),
       bty = "n")
dev.off()

