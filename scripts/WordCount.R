#install.packages("yaml", repos="http://cran.rstudio.com/") 

library("yaml")
config = yaml.load_file("config.yaml")

spark_home <- config$spark$home
spark_r_location <- paste0(spark_home,"/R/lib")
spark_server <- config$spark$server

library("SparkR", lib.loc = spark_r_location)

sc <- sparkR.init(master = spark_server, appName = "SparkR_Wordcount", 
                  sparkHome = spark_home)
sqlContext <- sparkRSQL.init(sc)

path <- file.path("sparkR/people.json")

peopleDF <- jsonFile(sqlContext, path)

printSchema(peopleDF)
head(peopleDF)
