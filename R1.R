"Hello World!"
mydata <- read.csv(file.choose())
install.packages("ggplot2")
ggplot(data=mydata, aes(x=carat, y=price))+
  geom_point()  
slice_vector <- c(1,2,3,4,5,6,7,8,9,10)
slice_vector[1:5]
#integer
x <- 2 
typeof(x)
#double 
y <- 2.5 
typeof(y)
add1(x, y)
z <- 3+2i
typeof(z)
a <- "s"
typeof(a)
q1 <- T
typeof(q1)




