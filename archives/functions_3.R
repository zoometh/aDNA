library(seqinr)
library(phylotools)
library(data.table)
library(plotly)
## EDGES
edges.hg.cult <- df.MesoNeo.a[, c("culture", "mt_hg")]
edges.identif <- df.MesoNeo.a[, c("mt_hg", "identifier")]
edges <- c(edges.hg.cult, edges.identif)
## NODES
# cultures
nds.culture <- as.character(data$Var1)
nds.culture.color <- as.character(data$color)
length(nds.culture)
# hg groups
nds.mt_hg <- unique(df.MesoNeo.a$mt_hg)
nds.mt_hg.color <- rep("lightgrey", length(nds.mt_hg))
length(nds.mt_hg)
# sample identifier
nds.mt_hg.identifier <- unique(df.MesoNeo.a$identifier)
nds.mt_hg.identifier.color <- rep("grey", length(nds.mt_hg.identifier))
length(nds.mt_hg.identifier)

length(nds.culture)+length(nds.mt_hg)+length(nds.mt_hg.identifier)
length(nds.culture.color)+length(nds.mt_hg.color)+length(nds.mt_hg.identifier.color)

thm.ths.nds <- data.frame(name=c(nds.culture, nds.mt_hg, nds.mt_hg.identifier),
                          color=c(nds.culture.color, nds.mt_hg.color, nds.mt_hg.identifier.color),
                          stringsAsFactors = F)

# hyperlinks to sample identifier
thm.ths.nds$ref <- NA
for (i in 1:nrow(thm.ths.nds)){
  # i <- 154
  if (thm.ths.nds[i, "name"] %in% nds.mt_hg.identifier){
    # edges.leaf[edges.leaf$identifier == thm.ths.nds[i,"name"],"mt_hg"]
    thm.ths.nds[i,"ref"] <- paste0("<a href = 'https://amtdb.org/records/",
                                   thm.ths.nds[i, "name"],"'><b>",
                                   thm.ths.nds[i, "name"],"</b></a>")
  } else {
    thm.ths.nds[i,"ref"] <- thm.ths.nds[i, "name"]
  }
}

g <- graph_from_data_frame(edges,
                           directed=F,
                           vertices= thm.ths.nds)
g <- simplify(g)
set.seed(123)
L <- layout.fruchterman.reingold(g) # spat
# g <- set.vertex.attribute(g, "site", value=V(g)$name)
g <- set.vertex.attribute(g, "degree", value=degree(g))
# g <- set.vertex.attribute(g, "ref", value=paste0("<a href = 'https://amtdb.org/records/",
#                                                  V(g)$identifier,"'><b>",
#                                                  V(g)$name,"</b></a>"))
g <- set.vertex.attribute(g, "x", value=L[,1])
g <- set.vertex.attribute(g, "y", value=L[,2])
# igraph::as_data_frame(g, 'vertices') # check vertices
es <- as.data.frame(get.edgelist(g),
                    stringsAsFactors = F)
# merge with color
# es <- merge(es, obj.colors, by.x = "V2", by.y="nom",all.x = T)
Xn <- L[,1]
Yn <- L[,2]
df.nds <- igraph::as_data_frame(g, what="vertices") # to retrieve coordinates
# edges
edge_shapes <- list()
for(i in 1:nrow(es)) {
  # i <- 48
  v0 <- es[i,]$V1
  v1 <- es[i,]$V2
  edge_shape = list(
    type = "line",
    line = list(color = "black", #es[i,]$couleur,
                width = 1.5),
    layer='below', # plot below
    #♦ renversant... x~y
    x0 = df.nds[df.nds$name == v0,"y"],
    y0 = df.nds[df.nds$name == v0,"x"],
    x1 = df.nds[df.nds$name == v1,"y"],
    y1 = df.nds[df.nds$name == v1,"x"],
    opacity = .3,
    width = .5
  )
  edge_shapes[[i]] <- edge_shape
}
# set.seed(41)
plot_ly() %>%
  # nodes
  layout(shapes = edge_shapes,
         xaxis = list(title = "",
                      showgrid = FALSE,
                      showticklabels = FALSE,
                      zeroline = FALSE),
         yaxis = list(title = "",
                      showgrid = FALSE,
                      showticklabels = FALSE,
                      zeroline = FALSE)
  ) %>%
  add_markers(
    y = ~V(g)$x,
    x = ~V(g)$y,
    mode = "markers",
    # text = V(g)$name,
    # hoverinfo = "text",
    # name = ~thm,
    # opacity = 1,
    marker = list(
      # symbol = V(g)$contexte.forme.ply,
      # size = log2(V(g)$degree*1000),
      size = (log(V(g)$degree)+1)*10,
      color = V(g)$color,
      opacity = 1,
      line = list(
        color = "#000000",
        width = 0))) %>% 
  # renversant
  add_annotations(x = ~V(g)$y,
                  y = ~V(g)$x,
                  text = ~V(g)$ref,
                  # text =  ~V(g)$name,
                  # text =  paste0("<b>",V(g)$name,"</b>"),
                  # text =  ~V(g)$num,
                  font=list(size=8),
                  # xref = "x",
                  # yref = "y",
                  # yanchor = 'center',
                  # xanchor = 'center',
                  showarrow = FALSE,
                  inherit = T)





