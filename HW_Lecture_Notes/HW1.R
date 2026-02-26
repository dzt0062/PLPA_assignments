# PLPA_assignments

Test

Test

#this is a comment

#Exercise number 1
2+2
2-2
3*3
3/4

#Exercise 2
x<-2
y=3

x+y
x-y

name <- "Doug"
eight<-"8"

x+eight

class(eight)
class(x)

vec<-c(1,2,3,4,5,6,7,8,9,10)
vec1<-C(1:10)
vec2<-c("Doug", "Jade")
Vec3<-c(TRUE, FALSE, TRUE)

vec[7]

#Functions

vec
mean(vec)
sd(vec)
sum(vec)
min(vec)
summary(vec)
sqrt(sum(vec))
log(vec)

#Logic operators

1>2
1<2
1<=2
1==1
1=1

t<- 1:10
t
t[(t>8)]
t[(t>8)| (t<5)]
t[t !=2]

2 %in% t
32 %in% t

#Data types

mat1 <- matrix(data = c(1,2,3), nrow = 3, ncol =3)
mat2 <- matrix(data = c("Doug", "Jade", "Jude"), nrow=3, ncol=3)

mat2
mat1

mat1[1]
mat1[4]
mat1[9]

mat1[1,3]
mat1[2,]

#Data Frames

df<- data.frame(mat1[,1], mat2[,1])
df

colnames(df) <-c("value", "name")
df

df[1]
df[1,2]

df[,"value"]

df$value

df$value[1]
df$name[3]
df$name[2:3]

#subsetting

df$value[df$name == "Jade"]

df$value[!df$name %in% "Jade"]

df$value[!df$name %in% c("Jade", "Jude")]


subset(df, name=="Doug")

df$log_value <- log(df$value)
df

#installing packages

install.packages("tidyverse")

library(tidyverse)


#Reading data into R

HBraw<-read.csv("C:/Users/djter/Downloads/HB raw.csv")
