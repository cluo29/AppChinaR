#setwd("~/Desktop/july15")
setwd("F:/Study/submissions/doing/APPCHINA/Data")


options(digits=22)
#install.packages("RSQLite")


library(RSQLite)


db = dbConnect(RSQLite::SQLite(), dbname="applications.db")



result = dbSendQuery(conn=db,
                     "SELECT * FROM applications_history ORDER BY timestamp ASC")

data = fetch(result,n=-1)

dfdata = data.frame(data)


#device_id
ID = dfdata[1,3]

#timestamp

Time_dfdata = dfdata
Time_dfdata[,2] = Time_dfdata[,2]-Time_dfdata[1,2]
Time_dfdata[,2] = Time_dfdata[,2]%/%(1000*3600*24)

User_ID_Set22 = data.frame(unique(Time_dfdata[,c("timestamp")]))

dbDisconnect(db)

db1 = dbConnect(RSQLite::SQLite(), dbname="screen.db")



result1 = dbSendQuery(conn=db1,
                     "SELECT * FROM screen ORDER BY timestamp ASC")

data = fetch(result1,n=-1)

dfdata2 = data.frame(data)


#timestamp

Time_dfdata = dfdata2
Time_dfdata[,2] = Time_dfdata[,2]-Time_dfdata[1,2]
Time_dfdata[,2] = Time_dfdata[,2]%/%(1000*3600*24)

User_ID_Set23 = data.frame(unique(Time_dfdata[,c("timestamp")]))

dbDisconnect(db1)


db2 = dbConnect(RSQLite::SQLite(), dbname="locations.db")



result2 = dbSendQuery(conn=db2,
                     "SELECT * FROM locations ORDER BY timestamp ASC")



data = fetch(result2,n=-1)

dfdata3 = data.frame(data)


#timestamp

Time_dfdata = dfdata3
Time_dfdata[,2] = Time_dfdata[,2]-Time_dfdata[1,2]
Time_dfdata[,2] = Time_dfdata[,2]%/%(1000*3600*24)

User_ID_Set25 = data.frame(unique(Time_dfdata[,c("timestamp")]))

dbDisconnect(db2)


ID
print("app hist")
nrow(User_ID_Set22)
print("screen")
nrow(User_ID_Set23)
print("location")
nrow(User_ID_Set25)


