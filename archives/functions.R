library(RPostgreSQL)
library(openxlsx)
library(seqinr)

aaa <- read.fasta(#file = system.file("sequences/ct.fasta.gz", package = "seqinr"), 
           file =mtdb_1511.fasta,
           seqtype = c("DNA", "AA"), as.string = FALSE, forceDNAtolower = TRUE,
           set.attributes = TRUE, legacy.mode = TRUE, seqonly = FALSE, strip.desc = FALSE,
           whole.header = FALSE,
           bfa = FALSE, sizeof.longlong = .Machine$sizeof.longlong,
           endian = .Platform$endian, apply.mask = TRUE)

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv,
                 dbname="mailhac_9",
                 host="localhost",
                 port=5432,
                 user="postgres",
                 password="postgres")
sqll <- "select site, numero, type, description, bib, chr_1, 
ST_X(geom) as x, ST_Y(geom) as y 
from objets where type like 'aDNA'"
aDNA <- dbGetQuery(con, sqll)
write.xlsx(x = aDNA, file = "test.xlsx",
           col.names=TRUE)

dbDisconnect(con)