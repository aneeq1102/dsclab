library(arules)
library(arulesViz)
# create a list of baskets
market_basket <-  
  list(  
    c("apple", "beer", "rice", "meat"),
    c("apple", "beer", "rice"),
    c("apple", "beer"), 
    c("apple", "pear"),
    c("milk", "beer", "rice", "meat"), 
    c("milk", "beer", "rice"), 
    c("milk", "beer"),
    c("milk", "pear")
  )

# set transaction names (T1 to T8)
names(market_basket) <- paste("T", c(1:8), sep = "")

trans <- as(market_basket, "transactions")
dim(trans)
itemLabels(trans)
summary(trans)
image(trans)
itemFrequencyPlot(trans, topN=10,  cex.names=1)
#Min Support 0.3, confidence as 0.5.
rules <- apriori(trans, 
                 parameter = list(supp=0.3, conf=0.5, 
                                  maxlen=10, 
                                  target= "rules"))
summary(rules)
inspect(rules)
plot(rules, engine = "plotly")
plot(rules, measure = "confidence")

subrules <- head(rules, n = 10, by = "confidence")

plot(subrules, method = "graph",  engine = "htmlwidget")
