#The code is typed in the console or source windows 
#The output of the code is in the Console
#Plots shows up under the plots tab under the environment window
#The global environment is where you store and see all created objects, 
#When typing a function there is a window that pops up and prompts the necessary inputs successful execution
#An R package is a group of functions that can be installed to run various commands
#A function is code that you want done to an object
#Under the packages tab you can see a list of installed packages and search for specific ones that are not installed
#A working directory is specific group of files/programs
#A relative file path is the location of a file within a directory and absolute is the file path specific to your computer

###Steps to new R Project with GitHUb Repository###
#Go to the terminal and type git con fig and user.name “dzt0062” 
#then user.email "dzt006@auburn.edu"
#then generate a new classic token in GitHub. 
#Create a new repository in your GtiHub profile. 
#Go to RStudio and create a New Project, select version control, copy and paste the new repository email

#A Vector is a string of a singular type of data 
#A dataframe is tabular data where columns can vary in data type but are the same within the column
#A matrix is also two dimensional/tabular structure with columns and rows of all the same data type
#All three can be object that house data

#Code#

z<-(1:100)
mean(z)
sd(z)

zlog<-(z > 30)
zlog

zdf<-data.frame(zlog, z)
zdf

colnames(zdf) <- c("zlogic", "zvec")
zdf

zsquared<- z^2
zdf<-data.frame(zlog, z, zsquared)
zdf

subset(zdf, zdf$zsquared > 10 & zdf$zsquared < 100)
zdf[zdf$zsquared > 10 & zdf$zsquared < 100, ]

zdf[26,]
zdf[180,]

#read a data file
tips<-read.csv("C:/Users/djter/Downloads/TipsR.csv", na.strings = ".")

#I know it is coding the missing files correctly because when I select the object in the environment 
#I can see the "NA"s where the periods were in the original file.







