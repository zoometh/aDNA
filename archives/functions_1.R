library(seqinr)
library(phylotools)
library(data.table)

# Downloaded from [https://amtdb.org](https://amtdb.org/records/)

aDNA <- read.fasta("mtdb_1511.fasta")
geo <- read.csv("mtdb_metadata.csv", encoding = "UTF-8")
# lapply(aDNA[1], attributes)
fasta.names <- get.fasta.name("mtdb_1511.fasta")
cat(head(fasta.names, 10), sep = "\n")

a <- "3910-3650 calBCE (4960±40 BP, VERA-5402)"

df.MesoNeo <- df[df$epoch == 'Mesolithic' | df$epoch == 'Neolithic', ]
df.MesoNeo <- df[df$la == 'Mesolithic' | df$epoch == 'Neolithic', ]

df.MesoNeo <- df %>% 
  # select(selected.fields) %>%
  filter(epoch == 'Mesolithic' | epoch == 'Neolithic') %>%
  filter(latitude < 46 & latitude > 36) %>%
  filter(longitude > -6 & longitude < 22.5)

hh <- as.data.frame(table(df.MesoNeo$culture), stringsAsFactors = F)
pie.cultures <- ggplot(hh, aes(x="", y=Freq, fill=Var1))+
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0) + theme_minimal() + 
  geom_text(aes(y = Freq/3 + c(0, cumsum(Freq)[-length(Freq)]),
                label = Freq, size=5))
pie.cultures

qq <- data.frame(
  group = c("Male", "Female", "Child"),
  value = c(25, 25, 50)
)
head(qq)
sapply(qq, class)

View(df.MesoNeo)

actors <- data.frame(name=df.MesoNeo$identifier,
                     site=df.MesoNeo$site)
relations <- data.frame(from=df.MesoNeo$culture,
                        to=df.MesoNeo$mt_hg)
library(igraph)
df.MesoNeo$culture <- toupper(df.MesoNeo$culture)
edges <- df.MesoNeo[, c("culture", "mt_hg")]
# grph <- graph_from_data_frame(edges, directed = TRUE, vertices = NULL)
nds.culture <- unique(df.MesoNeo$culture)
nds.culture.color <- rep("gold", length(nds.culture))
nds.mt_hg<- unique(df.MesoNeo$mt_hg)
nds.mt_hg.color <- rep("grey", length(nds.mt_hg))
thm.ths.nds <- data.frame(name=c(nds.culture, nds.mt_hg),
                          color=c(nds.culture.color, nds.mt_hg.color))
g <- graph_from_data_frame(edges,
                           directed=F,
                           vertices= thm.ths.nds)
plot(g, vertex.label.cex= 0.6,
     vertex.frame.color=NA,
     vertex.label.color = "black",
     vertex.label.family="Helvetica",
     vertex.size=8)

g <- simplify(g)

g_community <- fastgreedy.community(g)
# g_c_mbrsh <- g_community$membership
# g_c_names <- g_community$names


ggplot(MNcultures, aes(x="", y=Freq, fill=Var1))+
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0) + theme_minimal() + 
  geom_text(aes(y = Freq/3 + c(0, cumsum(Freq)[-length(Freq)]),
                label = Freq))



library(rcarbon)
data(euroevol)
# DK=subset(euroevol,Country=="Denmark") #subset of Danish dates
# DK=subset(df, culture=="Motala_HG") #subset of Danish 
DK <- df.MesoNeo.b
# DK.caldates=calibrate(x=DK$C14Age,errors=DK$C14SD,calCurves='intcal20')
DK.caldates=calibrate(x=DK$c14bp,errors=DK$c14sd,calCurves='intcal20')
DK.spd = spd(DK.caldates,timeRange=c(max(DK$c14bp)-1950,min(DK$c14bp)-1950)) 
plot(DK.spd) 
# plot(DK.spd,runm=200,add=TRUE,type="simple",col="darkorange",lwd=1.5,lty=2) #using a rolling average of 200 years for smoothing
nsim = 100
# DK.bins = binPrep(sites=DK$SiteID,ages=DK$C14Age,h=100)
DK.bins = binPrep(sites=DK$identifier,ages=DK$c14bp,h=100)
uninull <- modelTest(DK.caldates,
                     errors=DK$c14sd,
                     bins=DK.bins,
                     nsim=nsim,
                     # timeRange=c(8000,4000),
                     model="uniform",
                     # runm=100,
                     raw=TRUE)
p2pTest(uninull,p1=7610,p2=7570)


data(emedyd)
caldates <- calibrate(x=emedyd$CRA, 
                      errors=emedyd$Error, 
                      normalised=FALSE)
bins <- binPrep(sites=emedyd$SiteName, 
                ages=emedyd$CRA, h=50)
expnull <- modelTest(caldates, 
                     errors=emedyd$Error, 
                     bins=bins, 
                     nsim=5, 
                     runm=50,
                     timeRange=c(16000,9000), 
                     model="exponential", 
                     datenormalised=FALSE)
plot(expnull, xlim=c(16000,9000))
round(expnull$pval,4)
summary(expnull)



# Define the number of colors you want
nb.cols <- nrow(MNcultures)
mycolors <- colorRampPalette(brewer.pal(8, "Set1"))(nb.cols)
df.colors <- data.frame(Var1=unique(MNcultures$Var1),
                        color=mycolors)
# Compute the position of labels
data <- MNcultures %>% 
  arrange(desc(Var1)) %>%
  mutate(prop = Freq / sum(MNcultures$Freq) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )

data <- merge(data, df.colors, by="Var1")
# data <- data[order(data$Freq),]
# data[5,5]<- "#FF0004"

data$Var1 = factor(data$Var1, levels = data$Var1, ordered = T)
data$color = factor(data$color, levels = data$color, ordered = T)

ggplot(data, aes (x="", y = prop, fill = color)) + 
  geom_bar(width = 1, stat = "identity", color="white") +
  # geom_col(color="white", width = 1, aes(fill = color))+
  # geom_col(color="white", width = 1)+
  coord_polar("y")+
  geom_text(aes(label = Freq),
            position = position_stack(vjust = 0.5)) +
  # scale_fill_identity()+
  scale_fill_identity(guide = "legend", name = "cultures", label = data$Var1) +
  # scale_fill_identity(guide = "legend", name = "cultures", label = rev(data$color)) +
  # scale_fill_identity(guide = "legend", name = "cultures", label = rev(data$Var1)) +
  blank_theme

library("igraph")
E <- matrix(c(1,1,1,2,2,2),3,2)
G <- graph.edgelist(E)

G2 <- graph.adjacency(get.adjacency(G),weighted=TRUE)



library(quantmod)
symetf = c('SPY')
end<- format(Sys.Date(),"%Y-%m-%d")
start<-"2006-01-01"
l = length(symetf)
dat0 <- lapply(symetf, getSymbols, src="yahoo", from=start, to=end,
               auto.assign = F,warnings = FALSE,symbol.lookup = F)
xd <- dat0[[1]]
timee <- index(xd)
retd <- as.numeric(xd[2:NROW(xd),4])/as.numeric(xd[1:(NROW(xd)-1),4]) -1
tail(retd)
# get the index up to 2018. 
# We later compare 2018 with the rest
tmpind <- which(index(dat0[[1]])=="2017-12-29")
# Mean and SD of daily returns (2018 excluded)

mean(100*retd[1:tmpind])


set.seed(100)
x <- sample(x=1:30,size = 30,replace = T)
y <- sample(x=1:40,size = 35,replace = T)
a=density(x)
b=density(y)
plot(a)
lines(b)

ks.test(x,y)

x
a

ages3 = BchronCalibrate(ages=c(3445,11000), 
                        ageSds=c(50,200), 
                        positions=c(100,150), 
                        calCurves=c('intcal20','normal'))
summary(ages3)
age_samples = sampleAges(ages3)

age_diff = age_samples[,2] - age_samples[,1]
qplot(age_diff, geom = 'histogram', bins = 30,
      main = 'Age difference between 3445+/-50 and 11553+/-230',
      ylab = 'Frequency', xlab = 'Age difference')

datesBC <- BchronCalibrate(ages=df.MesoNeo.b[, "c14bp"],
                          ageSds=df.MesoNeo.b[, "c14sd"],
                          calCurves=rep('intcal20', nrow(df.MesoNeo.b)),
                          ids=df.MesoNeo.b[, "c14_lab_code"])
datesBC$`Beta-226472`$ageGrid
datesBC$df.MesoNeo.b[1, "c14_lab_code"]$ageGrid
l <- list()
for(i in 1:nrow(df.MesoNeo.b)){
  # i <- 2
  ids <- df.MesoNeo.b[i, "identifier"]
  a.date <- BchronCalibrate(ages=df.MesoNeo.b[i, "c14bp"],
                             ageSds=df.MesoNeo.b[i, "c14sd"],
                             calCurves='intcal20',
                             ids=df.MesoNeo.b[i, "identifier"])
  lst <- list(eval(parse(text=paste0("a.date$",ids,"$ageGrid"))))
  names(lst) <- ids
  l[length(l)+1] <- lst
}
str(l)
# dd <- rbindlist(l)
# View(dd)
# 
# plyr::ldply(l, rbind)
# 
# word.list <- list(letters[1:4], 
#                   letters[1:5], 
#                   letters[1:2], 
#                   letters[1:6])
# str(word.list)
# n.obs <- sapply(word.list, length)
# seq.max <- seq_len(max(n.obs))
# mat <- t(sapply(word.list, "[", i = seq.max))
n.obs <- sapply(l, length)
seq.max <- seq_len(max(n.obs))
mat <- t(sapply(l, "[", i = seq.max))
rownames(mat) <- df.MesoNeo.b[, "identifier"]
mat.t <- t(mat)
# mat.test <- as.data.frame(matrix(NA, 
#                    nrow = length(rownames(mat)),
#                    ncol = length(rownames(mat))))
lcompar <- t(combn(as.integer(rownames(mat.test)), 2)) # couple de zones à comparer
df.test <- data.frame(a = character(0),
                      b = character(0),
                      pval = integer(0))
for(i in 1:nrow(lcompar)){
  p1 <- lcompar[i, 1]
  p2 <- lcompar[i, 2]
  a <- colnames(mat.t)[p1]
  b <- colnames(mat.t)[p2]
  pval <- round(wilcox.test(mat.t[, p1], mat.t[, p2])$p.value, 3)
  df.test <- rbind(df.test, c(a, b, pval))
  df.test <- rbind(df.test, c(b, a, pval))
}
colnames(df.test) <- c("Var1", "Var2", "value")
df.test$value <- as.numeric(df.test$value)
ggplot(data = df.test, aes(x=Var1, y=Var2, fill=value)) +
  # ggtitle(paste(per,tax, mesur))+
  geom_tile(na.rm = T) +
  scale_fill_gradient2(low = "yellow", high = "red", space = "Lab",
                       # limits=c(0.05,1),
                       # name="Mann-Withney-\nWilcoxon\np-value",
                       na.value = 'white')+
  geom_text(aes(Var1, Var2, label = value),
            color = "black", size = 2)+
  #theme_minimal()+
  theme_bw()+
  theme(axis.title = element_blank())+
  theme(axis.text=element_text(size=6))+
  theme(axis.ticks = element_blank())+
  theme(plot.title = element_text(size=9))+
  theme(axis.ticks.length=unit(.1, "cm"))+
  theme(legend.position = "none")


a<-seq(0,300,3)
b<-runif(length(a))
c<-runif(length(a))
d<-as.data.frame(cbind(a,b,c))
d$a<-as.factor(d$a)
melt(d,d$a)
