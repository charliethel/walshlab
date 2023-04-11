df2 <- read_xlsx("c:/Users/18047/Desktop/Walsh/COVID Combined Data.xlsx")
df2 <- select(df2, -c("vial #", "Record_ID", "Collection Site", "Location", "Zipcode"))
df2 <- arrange(df2, desc(VAF))

df2 <- df2[complete.cases(df2$'CHIP (>2%)'), ]
df2 <- df2[complete.cases(df2$'CHIP (0.5%)'), ]
df2$VAF <- gsub("[^0-9.]+", "", df2$VAF)

# convert the "x" column to numeric
df2$VAF <- as.numeric(df2$VAF)

df2 <- df2[complete.cases(df2$VAF), ]


for (i in 1:nrow(df2)) {
  if (df2$VAF[i] < 2 & df2$VAF[i] >= 0.5) {
    df2$`CHIP (0.5%)`[i] <- 1
  } 
  else {
    df2$`CHIP (0.5%)`[i] <- 0
  }
}

for (i in 1:nrow(df2)) {
  if (df2$VAF[i] > 2) {
    df2$`CHIP (>2%)`[i] <- 1
  }
  else {
    df2$`CHIP (>2%)`[i] <- 0
  }
}

table(df2$`Gene Symbol`)
df2$`Height (m)`

df2

ggplot(data = df2, aes(x = 'Height (m)', y = VAF)) + geom_point()
