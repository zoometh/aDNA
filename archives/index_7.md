---
title: "**Gene-culture** coevolution (GC-coev)"
author: "Thomas Huet"
bibliography:
- 'refs.bib'
output: 
  bookdown::html_document2:
    number_sections: false
    keep_md: true
  # html_document:
    toc: true
    toc_float: 
      collapsed: false
      smooth_scroll: false
---

<style>
.html-widget {
margin: auto;
}
.leaflet .legend {
text-align:left;
line-height: 12px;
font-size: 12px;
}
</style>



Gene-culture coevolution (GC-coev) is one of the main challenge of evolutionary archaeology. It requires the cross study of aDNA ('***Who ?***') and the different aspects of the culture (['***What ?***'](https://github.com/zoometh/thomashuet/blob/main/README.md#what)). 

This doc is a HTML presentation host on [GitHub](https://github.com/zoometh/aDNA), which brings together R + Leaflet coding showing how to download data from the Ancient mtDNA database (AmtDB) and we conduct and overview of GC-coev issues concerning the transition between hunter-gatherers (HG) and early farmers (EF) in the Central and West Europe.

# The AmtDB dataset

The mitochondrial DNA (mtDNA) makes it possible to trace the maternal line. It passes from the mother to her children (of both sexes). Published mitochondrial sequences coming from the ancient DNA samples (aDNA) can be download from the [Ancient mtDNA database (AmtDB)](https://amtdb.org/records/). This database gathers . The whole dataset is composed by the [data](#mt.data) and the [metadata](#mt.meta)


## data {#mt.data}

The data file [mtdb_1511.fasta](mtdb_1511.fasta) is downloaded from the AmtDB. The current metadata format is .fasta, a text-based format for representing either nucleotide sequences or peptide sequences, in which base pairs or amino acids are represented using single-letter codes. FASTA formats can be read with the [phylotools](https://github.com/helixcn/phylotools) package. A sequence in FASTA format begins with a single-line description, followed by lines of sequence data:


```r
fasta <- phylotools::read.fasta("mtdb_1511.fasta")
fasta$seq.name[1]
```

```
## [1] "RISE509"
```

```r
substr(fasta$seq.text[1], 1, 250)
```

```
## [1] "GATCACAGGTCTATCACCCTATTAACCACTCACGGGAGCTCTCCATGCATTTGGTATTTTCGTCTGGGGGGTGTGCACGCGATAGCATTGCGAGACGCTGGAGCCGGAGCACCCTATGTCGCAGTATCTGTCTTTGATTCCTGCCTCATCCTATTATTTATCGCACCTACGTTCAATATTACAGGCGAACATACTTACTAAAGTGTGTTAATTAATTAATGCTTGTAGGACATAATAATAACAATTGAAT"
```
Each of these identifiers is a unique key for a sample. The data file counts <span style='color:grey'>1511</span> different identifiers. These identifiers which allow to join the second dataset, [metadata](#mt.meta). We will use this latter for cross-analysis

## metadata {#mt.meta}

The metadata file [metadata](mtdb_metadata.csv) is downloaded from the AmtDB. The current metadata format is .csv

<table class="table" style="font-size: 11px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:meta1)aDNA metadata sample</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> identifier </th>
   <th style="text-align:left;"> alternative_identifiers </th>
   <th style="text-align:left;"> country </th>
   <th style="text-align:left;"> continent </th>
   <th style="text-align:left;"> region </th>
   <th style="text-align:left;"> culture </th>
   <th style="text-align:left;"> epoch </th>
   <th style="text-align:left;"> group </th>
   <th style="text-align:left;"> comment </th>
   <th style="text-align:right;"> latitude </th>
   <th style="text-align:right;"> longitude </th>
   <th style="text-align:left;"> sex </th>
   <th style="text-align:left;"> site </th>
   <th style="text-align:left;"> site_detail </th>
   <th style="text-align:left;"> mt_hg </th>
   <th style="text-align:left;"> ychr_hg </th>
   <th style="text-align:right;"> year_from </th>
   <th style="text-align:right;"> year_to </th>
   <th style="text-align:left;"> date_detail </th>
   <th style="text-align:left;"> bp </th>
   <th style="text-align:left;"> c14_lab_code </th>
   <th style="text-align:left;"> reference_names </th>
   <th style="text-align:left;"> reference_links </th>
   <th style="text-align:left;"> reference_data_links </th>
   <th style="text-align:right;"> c14_sample_tag </th>
   <th style="text-align:right;"> c14_layer_tag </th>
   <th style="text-align:right;"> avg_coverage </th>
   <th style="text-align:left;"> sequence_source </th>
   <th style="text-align:left;"> ychr_snps </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> I3997 </td>
   <td style="text-align:left;"> LLBE-30593 </td>
   <td style="text-align:left;"> Spain </td>
   <td style="text-align:left;"> Europe </td>
   <td style="text-align:left;"> Iberia </td>
   <td style="text-align:left;"> SE_Iberia_BA </td>
   <td style="text-align:left;"> Bronze Age </td>
   <td style="text-align:left;"> BAIB </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:right;"> 39.5268 </td>
   <td style="text-align:right;"> -0.509749 </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Lloma de Betxí, Paterna, València/Valencia, Valencian Community </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> K1a2b </td>
   <td style="text-align:left;"> R1b1a1a2a1a2a1 </td>
   <td style="text-align:right;"> -1864 </td>
   <td style="text-align:right;"> -1618 </td>
   <td style="text-align:left;"> 1864–1618 cal BCE (3400±40 BP, Beta-195318) </td>
   <td style="text-align:left;"> 3400±40 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> Olalde et al. 2019 </td>
   <td style="text-align:left;"> https://doi.org/10.1126/science.aav4040 </td>
   <td style="text-align:left;"> https://www.ebi.ac.uk/ena/browser/view/PRJEB30874 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 29.7 </td>
   <td style="text-align:left;"> bam </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> KK1 </td>
   <td style="text-align:left;"> Kotias,KotiasKlde </td>
   <td style="text-align:left;"> Georgia </td>
   <td style="text-align:left;"> Asia </td>
   <td style="text-align:left;"> Caucasus </td>
   <td style="text-align:left;"> Hunter-Gatherer </td>
   <td style="text-align:left;"> Mesolithic </td>
   <td style="text-align:left;"> HGE </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:right;"> 42.2800 </td>
   <td style="text-align:right;"> 43.280000 </td>
   <td style="text-align:left;"> M </td>
   <td style="text-align:left;"> Kotias Klde </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> H13c </td>
   <td style="text-align:left;"> J2a </td>
   <td style="text-align:right;"> -7940 </td>
   <td style="text-align:right;"> -7600 </td>
   <td style="text-align:left;"> 7940-7600 calBCE [7938-7580 calBCE (8665±65 BP, RTT-5246), 7946-7612 calBCE (8745±40, OxA-28256)] </td>
   <td style="text-align:left;"> 8665±65 </td>
   <td style="text-align:left;"> RTT-5246 </td>
   <td style="text-align:left;"> Jones et al. 2015 </td>
   <td style="text-align:left;"> https://dx.doi.org/10.1038/ncomms9912 </td>
   <td style="text-align:left;"> https://www.ebi.ac.uk/ena/data/view/PRJEB11364 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0.0 </td>
   <td style="text-align:left;"> bam </td>
   <td style="text-align:left;"> J2a:L152:22243566C-&gt;T,J2a:L212:22711465T-&gt;C,J2a:L559:21674327A-&gt;G,J2a:M410:2751678A-&gt;G,J2:L228:7771358C-&gt;T,J2:M172:14969634T-&gt;G,J:CTS687:6953311A-&gt;T,J:CTS852:7048870G-&gt;A,J:CTS1033:7163234A-&gt;G,J:CTS1250:7296343G-&gt;T,J:CTS2769:14476551T-&gt;A,J:CTS3732:15138096A-&gt;G,J:CTS3936:15277466G-&gt;A,J:CTS4204:15476324G-&gt;A,J:CTS5280:16180103A-&gt;G,J:CTS5628:16401405C-&gt;G,J:CTS5678:16427564A-&gt;T,J:CTS7028:17246058T-&gt;C,J:CTS7229:17367321C-&gt;A,J:CTS9877:19117262A-&gt;G,J:CTS10446:19460042G-&gt;C,J:CTS10858:22808236G-&gt;A,J:CTS11571:23163701C-&gt;A,J:CTS11750:23250894C-&gt;T,J:CTS11765:23255729A-&gt;T,J:CTS11787:23273016G-&gt;A,J:CTS12047:23443976A-&gt;Ghet,J:F1167:8393499G-&gt;A,J:F1181:8418927G-&gt;C,J:F1826:14705645G-&gt;A,J:F2114:16262942G-&gt;A,J:F2116:16268345C-&gt;G,J:F2174:16475682C-&gt;T,J:F2502:17495914G-&gt;A,J:F2746:18257026G-&gt;A,J:F2817:18695159C-&gt;T,J:F2839:18773505C-&gt;T,J:F3119:21097847C-&gt;T,J:F3176:21329083T-&gt;C,J:F3358:22785217G-&gt;A,J:FGC1599:21923739A-&gt;T,J:L60:14237131C-&gt;T,J:L778:23088142T-&gt;C,J:M304:22749853A-&gt;C,J:P209:19179335T-&gt;C,J:PF4505:7065239T-&gt;C,J:PF4513:7759610C-&gt;T,J:PF4519:8669451C-&gt;G,J:PF4524:10009851G-&gt;Ahet,J:PF4530:13597365C-&gt;T,J:PF4575:18410799A-&gt;G,J:PF4594:21495992C-&gt;A,J:PF4595:21858778C-&gt;A,J:YSC0000228:22172960G-&gt;T,J:Z7829:22465433G-&gt;C,J:CTS4349:15602183G-&gt;A,J:CTS5934:16562707C-&gt;T,J:CTS7483:17502703T-&gt;A,J:CTS8974:18588650A-&gt;G,J:F1744:14264859G-&gt;A,J:F2769:18552360G-&gt;C,J:F2973:19194316C-&gt;T,J:FGC1604:10038100G-&gt;A,J:FGC3271:10038717G-&gt;A,J:PF4521:9815201T-&gt;C,J:PF4567:17605948A-&gt;C,J:PF4591:21281892C-&gt;A,J:PF4598:22118776A-&gt;G,J:PF4619:23251880A-&gt;C,J:CTS7832:17693210A-&gt;G,J:CTS11291:23058442G-&gt;T,J:F3138:21148350G-&gt;A,J:CTS5545.1:16352755C-&gt;T,J:CTS6958:17210893G-&gt;A,J:CTS8938:18567169T-&gt;G,J:F1168:8393849G-&gt;A,J:PF4515:8308114G-&gt;A,J:PF4602:22246347T-&gt;A,J:CTS1068:7180976G-&gt;A,J:CTS2042:14162442T-&gt;A,J:CTS3872:15237163G-&gt;A,J:CTS4356:15607864T-&gt;A,J:CTS4937:15913787A-&gt;C,J:CTS5691:16434671C-&gt;T,J:CTS7565:17540740C-&gt;T,J:CTS7738:17637446T-&gt;Chet,J:CTS11211:23015968C-&gt;A,J:CTS12683:28669310C-&gt;G,J:CTS12887:28738577A-&gt;G,J:F1381:8687145G-&gt;T,J:F1973:15581303G-&gt;A,J:F2390:17136854T-&gt;Chet,J:F2707:18084124T-&gt;A,J:F3074:19508788G-&gt;A,J:F3347:22708656C-&gt;T,J:F4072:7292720T-&gt;C,J:FGC1601:5989356G-&gt;T,J:FGC1607:5067300G-&gt;A,J:PF4497:5111259A-&gt;G,J:PF4506:7126936G-&gt;T,J:PF4511:7517252G-&gt;T,J:PF4528:13247984G-&gt;T,J:PF4529:13431601G-&gt;T,J:PF4532:13627154C-&gt;T,J:PF4533:13943183G-&gt;C,J:PF4535:14084606G-&gt;T,J:PF4572:17996247A-&gt;Ghet,J:PF4593:21350830G-&gt;A,J:PF4596:21944571T-&gt;Chet,J:PF4622:23538307C-&gt;G,J:S19861:17534388T-&gt;A,J:Z7818:13481356G-&gt;Chet,J:Z16989:28470602A-&gt;C </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NF-47c </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> USA </td>
   <td style="text-align:left;"> America </td>
   <td style="text-align:left;"> Midwest USA </td>
   <td style="text-align:left;"> Oneota </td>
   <td style="text-align:left;"> Middle Ages </td>
   <td style="text-align:left;"> NAMA </td>
   <td style="text-align:left;"> Illinois </td>
   <td style="text-align:right;"> 40.3340 </td>
   <td style="text-align:right;"> -90.053000 </td>
   <td style="text-align:left;"> U </td>
   <td style="text-align:left;"> Norris Farms #36 </td>
   <td style="text-align:left;"> cemetery </td>
   <td style="text-align:left;"> D1 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:right;"> 1150 </td>
   <td style="text-align:right;"> 1700 </td>
   <td style="text-align:left;"> 1150-1700 CE </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> Ozga et al. 2016 </td>
   <td style="text-align:left;"> https://doi.org/10.1002/ajpa.22960 </td>
   <td style="text-align:left;"> https://www.ncbi.nlm.nih.gov/sra/SRA291772 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 7.1 </td>
   <td style="text-align:left;"> bam </td>
   <td style="text-align:left;">  </td>
  </tr>
</tbody>
</table>

It counts <span style='color:grey'>2426</span> samples and <span style='color:grey'>29</span> columns. 

# mtDNA *and* culture tag {#cross.mt.DNA.culture}

Within the AmtDB database, one (1) field concerns the mtDNA hg ('mt_hg') and two (2) other fields give insights on the cultural membership of the sample:

1. 'culture' counts <span style='color:grey'>252</span> distinct values
2. 'epoch' is more generic and counts <span style='color:grey'>14</span> distinct values 

To illustrate GC-coev, we will focus on the culture tags (i.e., 'culture' column) of the Mesolithic/Neolithic transition (i.e., 'epoch' == 'Mesolithic' or 'Neolithic'). Our region of interest is the Central and Western Mediterranean (i.e., from Greece to Spain). We will remove sample where the 'mt_hg' is empty, and to have an easily legible dataset we will also remove *unicum* (Freq == 1) in the 'culture' field


```r
df.MesoNeo <- df %>% 
  filter(mt_hg != "" & !is.na(mt_hg)) %>%
  filter(epoch == 'Mesolithic' | epoch == 'Neolithic') %>%
  filter(latitude < 46 & latitude > 35) %>%
  filter(longitude > -6 & longitude < 28)
df.MesoNeo <- df.MesoNeo %>%  
  group_by(culture) %>%
  filter(n() > 1)
MNcultures <- as.data.frame(table(df.MesoNeo$culture),
                            stringsAsFactors = F)
```

After processing, the new dataset counts <span style='color:grey'>144</span> samples and <span style='color:grey'>17</span> distinct cultures:

<img src="index_7_files/figure-html/pie_chart-1.png" style="display: block; margin: auto;" />

The selected mtDNA sample of the dataset can be mapped. Colors of points are the same as previously. Inside their popup, the hg appears always colored in <span style="color: red;">red</span> but the culture is color is value-dependent   


<div class="figure" style="text-align: center">
<!--html_preserve--><div id="htmlwidget-6eaf0000cc83f4c93730" style="width:90%;height:500px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-6eaf0000cc83f4c93730">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,"OSM",{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addCircleMarkers","args":[[43.98,43.98,43.98,43.98,43.98,43.98,43.98,43.98,43.98,43.98,44.9,44.9,44.9,43.16,43.37,43.14,42.1,43.16,42.1,44.82,44.82,43.59,43.59,43.59,43.34,43.457,43.457,43.457,36.64,36.64,36.64,36.64,36.64,37.42,43.26,42.97,44.53,42.91,44.64,44.64,44.6,44.6,44.6,44.6,44.52,44.6,44.6,44.6,44.6,44.6,44.52,44.6,44.6,44.53,44.53,44.53,44.53,44.53,44.63,44.63,44.53,44.53,44.55,44.55,44.53,44.53,44.63,44.53,44.53,44.53,44.53,44.53,44.64,44.53,39.682491,44.53,44.64,44.64,44.55,44.55,44.64,39.682491,44.6,44.63,44.52,44.6,41.37,42.5,42.5,42.6282,42.6282,42.5,42.5,41.25,41.25,41.25,41.25,43.0866,43.0866,43.085823,43.085823,43.0866,43.085823,43.085823,43.0866,43.085823,41.4391,41.4391,41.4391,41.4391,41.4391,41.4391,41.4391,41.4391,41.4391,41.4391,41.4391,41.4391,41.4391,44.26,45.48,40.41819566,37.439437,39.79,38.7025,38.7025,38.7025,38.7025,38.7025,38.7025,38.7025,38.7025,38.7025,38.7025,38.762271,38.762271,38.7025,38.7025,45.32,45.76,45.76,45.32,45.76,44.49],[26.4,26.4,26.4,26.4,26.4,26.4,26.4,26.4,26.4,26.4,19.75,19.75,19.75,25.88,23.73,25.6,25.75,25.88,25.75,13.64,13.64,16.65,16.65,16.65,5.06,5.863,5.863,5.863,22.38,22.38,22.38,22.38,22.38,23.13,-3.45,16.71,22.05,-5.38,22.3,22.3,22.01,22.01,22.01,22.01,22.72,22.01,22.01,22.01,22.01,22.01,22.72,22.01,22.01,22.05,22.05,22.05,22.05,22.05,22.61,22.61,22.05,22.05,22.03,22.03,22.05,22.05,22.61,22.05,22.05,22.05,22.05,22.05,22.3,22.05,21.68191,22.05,22.3,22.3,22.03,22.03,22.3,21.68191,22.01,22.61,22.72,22.01,1.89,0.5,0.5,-3.11649,-3.11649,0.5,0.5,-2.33,-2.33,-2.33,-2.33,-2.2154,-2.2154,-2.251197,-2.251197,-2.2154,-2.251197,-2.251197,-2.2154,-2.251197,1.5733,1.5733,1.5733,1.5733,1.5733,1.5733,1.5733,1.5733,1.5733,1.5733,1.5733,1.5733,1.5733,23.9,27,-0.11675,-3.437567,-1.033333,-0.48631,-0.48631,-0.48631,-0.48631,-0.48631,-0.48631,-0.48631,-0.48631,-0.48631,-0.48631,-0.586981,-0.586981,-0.48631,-0.48631,18.39,18.57,18.57,18.39,18.57,21.08],3,["I0700","I1113","I1297","I2216","I1108","I1109","I3879","I2215","I1295","I1296","I0634","I1131","I0633","I0704","I1298","I2526","I0698","I2521","I2529","I5072","I5071","I3433","I3947","I3948","I4308","I4304","I4305","I4303","I3920","I3708","I5427","I3709","I2937","I2318","ElMiron","I1875","I4878","I0585","I4916","I4917","I5240","I5241","I5242","I5244","I4582","I5232","I5233","I5234","I5235","I5236","I4081","I5238","I5239","I4872","I4873","I4874","I4875","I4876","I4607","I4655","I4657","I4660","I4665","I4666","I4870","I4871","I5436","I5771","I5772","I5773","I4881","I4877","I5402","I4880","Theo5","I4882","I4914","I4915","I5405","I5407","I5401","Theo1","I5237","I5411","I5408","I5409","CB13","I0413","I0409","I1972","I2199","I0410","I0412","I0408","I0406","I0405","I0407","I11300","I11248","I7603","I7606","I11249","I7605","I7604","I11301","I7602","I10284","I10277","I10286","I11303","I10278","I10285","I10283","I10282","I10280","I11304","I11305","I10287","I11306","I2533","I2532","I3209","I10899","I8130","I7598","I7595","I7597","I7642","I7594","I7601","I7645","I7646","I7643","I7644","I8567","I8568","I7647","I7600","I5077","I4168","I4167","I5078","I3498","I4918"],null,{"interactive":true,"className":"","stroke":true,"color":["#E41A1C","#E41A1C","#E41A1C","#E41A1C","#E41A1C","#E41A1C","#E41A1C","#E41A1C","#E41A1C","#E41A1C","#984560","#984560","#984560","#984560","#4C71A4","#4C71A4","#3D8D95","#3D8D95","#3D8D95","#47A265","#47A265","#47A265","#47A265","#47A265","#5B9C5A","#5B9C5A","#5B9C5A","#5B9C5A","#7B7281","#7B7281","#7B7281","#7B7281","#7B7281","#7B7281","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#CB6651","#CB6651","#CB6651","#CB6651","#CB6651","#CB6651","#CB6651","#F87B0A","#F87B0A","#F87B0A","#F87B0A","#FFAF13","#FFAF13","#FFAF13","#FFAF13","#FFAF13","#FFAF13","#FFAF13","#FFAF13","#FFAF13","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#E8D430","#E8D430","#C18A2B","#C18A2B","#C18A2B","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#D36E7C","#D36E7C","#D36E7C","#D36E7C","#F781BF","#F781BF"],"weight":1,"opacity":0.7,"fill":true,"fillColor":["#E41A1C","#E41A1C","#E41A1C","#E41A1C","#E41A1C","#E41A1C","#E41A1C","#E41A1C","#E41A1C","#E41A1C","#984560","#984560","#984560","#984560","#4C71A4","#4C71A4","#3D8D95","#3D8D95","#3D8D95","#47A265","#47A265","#47A265","#47A265","#47A265","#5B9C5A","#5B9C5A","#5B9C5A","#5B9C5A","#7B7281","#7B7281","#7B7281","#7B7281","#7B7281","#7B7281","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#9E5198","#CB6651","#CB6651","#CB6651","#CB6651","#CB6651","#CB6651","#CB6651","#F87B0A","#F87B0A","#F87B0A","#F87B0A","#FFAF13","#FFAF13","#FFAF13","#FFAF13","#FFAF13","#FFAF13","#FFAF13","#FFAF13","#FFAF13","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#FFE729","#E8D430","#E8D430","#C18A2B","#C18A2B","#C18A2B","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#B05B3A","#D36E7C","#D36E7C","#D36E7C","#D36E7C","#F781BF","#F781BF"],"fillOpacity":0.7},null,null,["<b>Malak Preslavets<\/b> <span style='color:red'>T2e<\/span> <br>culture: <span style='color:#E41A1C;'>Balkans_MP_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Malak Preslavets<\/b> <span style='color:red'>U5a1c<\/span> <br>culture: <span style='color:#E41A1C;'>Balkans_MP_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Malak Preslavets<\/b> <span style='color:red'>H5b<\/span> <br>culture: <span style='color:#E41A1C;'>Balkans_MP_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Malak Preslavets<\/b> <span style='color:red'>J2b1<\/span> <br>culture: <span style='color:#E41A1C;'>Balkans_MP_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Malak Preslavets<\/b> <span style='color:red'>T2e<\/span> <br>culture: <span style='color:#E41A1C;'>Balkans_MP_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Malak Preslavets<\/b> <span style='color:red'>J2b1<\/span> <br>culture: <span style='color:#E41A1C;'>Balkans_MP_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Malak Preslavets<\/b> <span style='color:red'>H<\/span> <br>culture: <span style='color:#E41A1C;'>Balkans_MP_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Malak Preslavets<\/b> <span style='color:red'>T2b<\/span> <br>culture: <span style='color:#E41A1C;'>Balkans_MP_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Malak Preslavets<\/b> <span style='color:red'>J1c<\/span> <br>culture: <span style='color:#E41A1C;'>Balkans_MP_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Malak Preslavets<\/b> <span style='color:red'>U5a2<\/span> <br>culture: <span style='color:#E41A1C;'>Balkans_MP_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Gomolava, Hrtkovci, Vojvodina<\/b> <span style='color:red'>K1a4<\/span> <br>culture: <span style='color:#984560;'>Balkans_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Gomolava, Hrtkovci, Vojvodina<\/b> <span style='color:red'>H<\/span> <br>culture: <span style='color:#984560;'>Balkans_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Gomolava, Hrtkovci, Vojvodina<\/b> <span style='color:red'>HV<\/span> <br>culture: <span style='color:#984560;'>Balkans_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Dzhulyunitsa<\/b> <span style='color:red'>T2b<\/span> <br>culture: <span style='color:#984560;'>Balkans_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Ohoden<\/b> <span style='color:red'>K1a<\/span> <br>culture: <span style='color:#4C71A4;'>Bulgaria_EN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Samovodene<\/b> <span style='color:red'>T2e<\/span> <br>culture: <span style='color:#4C71A4;'>Bulgaria_EN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Yabalkovo<\/b> <span style='color:red'>H<\/span> <br>culture: <span style='color:#3D8D95;'>Bulgaria_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Dzhulyunitsa<\/b> <span style='color:red'>H<\/span> <br>culture: <span style='color:#3D8D95;'>Bulgaria_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Yabalkovo<\/b> <span style='color:red'>T1a<\/span> <br>culture: <span style='color:#3D8D95;'>Bulgaria_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Kargadur<\/b> <span style='color:red'>H7c<\/span> <br>culture: <span style='color:#47A265;'>Cardial Ware<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Kargadur<\/b> <span style='color:red'>H5a<\/span> <br>culture: <span style='color:#47A265;'>Cardial Ware<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Zemunica Cave<\/b> <span style='color:red'>H1<\/span> <br>culture: <span style='color:#47A265;'>Cardial Ware<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Zemunica Cave<\/b> <span style='color:red'>K1b1a<\/span> <br>culture: <span style='color:#47A265;'>Cardial Ware<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Zemunica Cave<\/b> <span style='color:red'>N1a1<\/span> <br>culture: <span style='color:#47A265;'>Cardial Ware<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Collet Redon, La Couronne-Martigues<\/b> <span style='color:red'>U3a1<\/span> <br>culture: <span style='color:#5B9C5A;'>France_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25738\" target=\"_blank\">Olalde et al. 2018<\/a>","<b>Clos de Roque, Saint Maximin-la-Sainte-Baume<\/b> <span style='color:red'>T2c1d+152<\/span> <br>culture: <span style='color:#5B9C5A;'>France_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25738\" target=\"_blank\">Olalde et al. 2018<\/a>","<b>Clos de Roque, Saint Maximin-la-Sainte-Baume<\/b> <span style='color:red'>T2b3+151<\/span> <br>culture: <span style='color:#5B9C5A;'>France_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25738\" target=\"_blank\">Olalde et al. 2018<\/a>","<b>Clos de Roque, Saint Maximin-la-Sainte-Baume<\/b> <span style='color:red'>H3<\/span> <br>culture: <span style='color:#5B9C5A;'>France_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25738\" target=\"_blank\">Olalde et al. 2018<\/a>","<b>Diros, Alepotrypa Cave<\/b> <span style='color:red'>H<\/span> <br>culture: <span style='color:#7B7281;'>Greece_Peloponnese_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Diros, Alepotrypa Cave<\/b> <span style='color:red'>T1a<\/span> <br>culture: <span style='color:#7B7281;'>Greece_Peloponnese_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Diros, Alepotrypa Cave<\/b> <span style='color:red'>K1a24<\/span> <br>culture: <span style='color:#7B7281;'>Greece_Peloponnese_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Diros, Alepotrypa Cave<\/b> <span style='color:red'>K1b1a<\/span> <br>culture: <span style='color:#7B7281;'>Greece_Peloponnese_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Diros, Alepotrypa Cave<\/b> <span style='color:red'>K1a26<\/span> <br>culture: <span style='color:#7B7281;'>Greece_Peloponnese_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature23310\" target=\"_blank\">Lazaridis et al. 2017<\/a>","<b>Franchthi Cave<\/b> <span style='color:red'>H2<\/span> <br>culture: <span style='color:#7B7281;'>Greece_Peloponnese_Neolithic<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>El Miron<\/b> <span style='color:red'>U5b<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature17993\" target=\"_blank\">Fu et al. 2016<\/a>","<b>Vela Spila<\/b> <span style='color:red'>U5b2b<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U4a<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>La Brana-Arintero, Leon<\/b> <span style='color:red'>U5b2c<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature12960\" target=\"_blank\">Olalde et al. 2014<\/a>","<b>Hadučka Vodenica<\/b> <span style='color:red'>U5b2b<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Hadučka Vodenica<\/b> <span style='color:red'>U5a1c<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Padina<\/b> <span style='color:red'>U5a1c<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Padina<\/b> <span style='color:red'>U5a2a<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Padina<\/b> <span style='color:red'>U5a1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Padina<\/b> <span style='color:red'>K1f<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Ostrovul Corbului<\/b> <span style='color:red'>K1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Padina<\/b> <span style='color:red'>K1a<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Padina<\/b> <span style='color:red'>U5b1d1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Padina<\/b> <span style='color:red'>U4a<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Padina<\/b> <span style='color:red'>U5b2c<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Padina<\/b> <span style='color:red'>U5a2d<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Ostrovul Corbului<\/b> <span style='color:red'>H13<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Padina<\/b> <span style='color:red'>K1c<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Padina<\/b> <span style='color:red'>U5a2d<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U5a1c<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U5a2a<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U5b2a1a<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U5b1d1a<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U5a2d<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Schela Cladovei<\/b> <span style='color:red'>U5a2<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Schela Cladovei<\/b> <span style='color:red'>K1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>K1c<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U8b1b<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Lepenski Vir<\/b> <span style='color:red'>J2b1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Lepenski Vir<\/b> <span style='color:red'>H40<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>K1c<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U5b2a1a<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Schela Cladovei<\/b> <span style='color:red'>U5a2<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U5a1c1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U5a2a<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U4a<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U4b1b1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U5b1d1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Hadučka Vodenica<\/b> <span style='color:red'>U5a1c1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Vlasac<\/b> <span style='color:red'>U4b1b1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Theopetra<\/b> <span style='color:red'>K1c<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://doi.org/10.1073/pnas.1523951113\" target=\"_blank\">Hofmanova et al. 2016<\/a>","<b>Vlasac<\/b> <span style='color:red'>U4b1b1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Hadučka Vodenica<\/b> <span style='color:red'>U5a1c1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Hadučka Vodenica<\/b> <span style='color:red'>U5b2b<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Lepenski Vir<\/b> <span style='color:red'>HV<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Lepenski Vir<\/b> <span style='color:red'>H13<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Hadučka Vodenica<\/b> <span style='color:red'>U5a1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Theopetra<\/b> <span style='color:red'>K1c<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://doi.org/10.1073/pnas.1523951113\" target=\"_blank\">Hofmanova et al. 2016<\/a>","<b>Padina<\/b> <span style='color:red'>U5a2a<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Schela Cladovei<\/b> <span style='color:red'>U5a1c1<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Ostrovul Corbului<\/b> <span style='color:red'>K1c<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Padina<\/b> <span style='color:red'>U5a1c<\/span> <br>culture: <span style='color:#9E5198;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Cova Bonica, Vallirana, Barcelona<\/b> <span style='color:red'>K1a2a<\/span> <br>culture: <span style='color:#CB6651;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1093/molbev/msv181\" target=\"_blank\">Olalde et al. 2015<\/a>","<b>Els Trocs<\/b> <span style='color:red'>V<\/span> <br>culture: <span style='color:#CB6651;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature14317\" target=\"_blank\">Haak et al. 2015<\/a>","<b>Els Trocs<\/b> <span style='color:red'>J1c3<\/span> <br>culture: <span style='color:#CB6651;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature14317\" target=\"_blank\">Haak et al. 2015<\/a>","<b>El Prado de Pancorbo, Burgos<\/b> <span style='color:red'>K1a4a1<\/span> <br>culture: <span style='color:#CB6651;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature24476\" target=\"_blank\">Lipson et al. 2017<\/a>","<b>El Prado de Pancorbo, Burgos<\/b> <span style='color:red'>H1<\/span> <br>culture: <span style='color:#CB6651;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature24476\" target=\"_blank\">Lipson et al. 2017<\/a>","<b>Els Trocs<\/b> <span style='color:red'>T2c1d or T2c1d2<\/span> <br>culture: <span style='color:#CB6651;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature14317\" target=\"_blank\">Haak et al. 2015<\/a>","<b>Els Trocs<\/b> <span style='color:red'>N1a1a1<\/span> <br>culture: <span style='color:#CB6651;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature14317\" target=\"_blank\">Haak et al. 2015<\/a>","<b>La Mina<\/b> <span style='color:red'>U5b1<\/span> <br>culture: <span style='color:#F87B0A;'>Iberia_MN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature14317\" target=\"_blank\">Haak et al. 2015<\/a>","<b>La Mina<\/b> <span style='color:red'>H1<\/span> <br>culture: <span style='color:#F87B0A;'>Iberia_MN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature14317\" target=\"_blank\">Haak et al. 2015<\/a>","<b>La Mina<\/b> <span style='color:red'>K1a1b1<\/span> <br>culture: <span style='color:#F87B0A;'>Iberia_MN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature14317\" target=\"_blank\">Haak et al. 2015<\/a>","<b>La Mina<\/b> <span style='color:red'>K1b1a1<\/span> <br>culture: <span style='color:#F87B0A;'>Iberia_MN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature14317\" target=\"_blank\">Haak et al. 2015<\/a>","<b>Jentillarri, Enirio-Aralar, Gipuzkoa, Basque Country<\/b> <span style='color:red'>J2a1a1<\/span> <br>culture: <span style='color:#FFAF13;'>N_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Jentillarri, Enirio-Aralar, Gipuzkoa, Basque Country<\/b> <span style='color:red'>J2a1a1<\/span> <br>culture: <span style='color:#FFAF13;'>N_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Mandubi Zelaia, Ezkio-Itsaso, Gipuzkoa, Basque Country<\/b> <span style='color:red'>K1a2b<\/span> <br>culture: <span style='color:#FFAF13;'>N_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Mandubi Zelaia, Ezkio-Itsaso, Gipuzkoa, Basque Country<\/b> <span style='color:red'>U5b1+16189+@16192<\/span> <br>culture: <span style='color:#FFAF13;'>N_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Jentillarri, Enirio-Aralar, Gipuzkoa, Basque Country<\/b> <span style='color:red'>U5b1<\/span> <br>culture: <span style='color:#FFAF13;'>N_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Mandubi Zelaia, Ezkio-Itsaso, Gipuzkoa, Basque Country<\/b> <span style='color:red'>H3<\/span> <br>culture: <span style='color:#FFAF13;'>N_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Mandubi Zelaia, Ezkio-Itsaso, Gipuzkoa, Basque Country<\/b> <span style='color:red'>H1ak<\/span> <br>culture: <span style='color:#FFAF13;'>N_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Jentillarri, Enirio-Aralar, Gipuzkoa, Basque Country<\/b> <span style='color:red'>H1j8<\/span> <br>culture: <span style='color:#FFAF13;'>N_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Mandubi Zelaia, Ezkio-Itsaso, Gipuzkoa, Basque Country<\/b> <span style='color:red'>J1c1<\/span> <br>culture: <span style='color:#FFAF13;'>N_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cova de la Guineu, Font-rubí, Barcelona, Catalonia<\/b> <span style='color:red'>U5b1<\/span> <br>culture: <span style='color:#FFE729;'>NE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cova de la Guineu, Font-rubí, Barcelona, Catalonia<\/b> <span style='color:red'>X2c1<\/span> <br>culture: <span style='color:#FFE729;'>NE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cova de la Guineu, Font-rubí, Barcelona, Catalonia<\/b> <span style='color:red'>U5b1<\/span> <br>culture: <span style='color:#FFE729;'>NE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cova de la Guineu, Font-rubí, Barcelona, Catalonia<\/b> <span style='color:red'>H1j<\/span> <br>culture: <span style='color:#FFE729;'>NE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cova de la Guineu, Font-rubí, Barcelona, Catalonia<\/b> <span style='color:red'>U5b1<\/span> <br>culture: <span style='color:#FFE729;'>NE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cova de la Guineu, Font-rubí, Barcelona, Catalonia<\/b> <span style='color:red'>T2b<\/span> <br>culture: <span style='color:#FFE729;'>NE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cova de la Guineu, Font-rubí, Barcelona, Catalonia<\/b> <span style='color:red'>H<\/span> <br>culture: <span style='color:#FFE729;'>NE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cova de la Guineu, Font-rubí, Barcelona, Catalonia<\/b> <span style='color:red'>K1a3<\/span> <br>culture: <span style='color:#FFE729;'>NE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cova de la Guineu, Font-rubí, Barcelona, Catalonia<\/b> <span style='color:red'>J1c1<\/span> <br>culture: <span style='color:#FFE729;'>NE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cova de la Guineu, Font-rubí, Barcelona, Catalonia<\/b> <span style='color:red'>U5a2+16294<\/span> <br>culture: <span style='color:#FFE729;'>NE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cova de la Guineu, Font-rubí, Barcelona, Catalonia<\/b> <span style='color:red'>J1c1b<\/span> <br>culture: <span style='color:#FFE729;'>NE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cova de la Guineu, Font-rubí, Barcelona, Catalonia<\/b> <span style='color:red'>T2b3+151<\/span> <br>culture: <span style='color:#FFE729;'>NE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cova de la Guineu, Font-rubí, Barcelona, Catalonia<\/b> <span style='color:red'>J2b1a2<\/span> <br>culture: <span style='color:#FFE729;'>NE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Carcea<\/b> <span style='color:red'>J1c5<\/span> <br>culture: <span style='color:#E8D430;'>Romania_EN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Coțatcu<\/b> <span style='color:red'>K1a2<\/span> <br>culture: <span style='color:#E8D430;'>Romania_EN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Cingle del Mas Nou, Ares del Maestre, Castelló/Castellón, Valencian Community<\/b> <span style='color:red'>U5b1d1<\/span> <br>culture: <span style='color:#C18A2B;'>SE_Iberia_Meso<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cueva de la Carigüela, Piñar, Granada, Andalusia<\/b> <span style='color:red'>U5b1<\/span> <br>culture: <span style='color:#C18A2B;'>SE_Iberia_Meso<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Cueva de la Cocina, Dos Aguas, València/Valencia, Valencian Community<\/b> <span style='color:red'>U5b2b<\/span> <br>culture: <span style='color:#C18A2B;'>SE_Iberia_Meso<\/span> <i>Mesolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Les Llometes, Alcoi, Alacant/Alicante, Valencian Community<\/b> <span style='color:red'>U5b3<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Les Llometes, Alcoi, Alacant/Alicante, Valencian Community<\/b> <span style='color:red'>U5b2b5<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Les Llometes, Alcoi, Alacant/Alicante, Valencian Community<\/b> <span style='color:red'>J2b1a<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Les Llometes, Alcoi, Alacant/Alicante, Valencian Community<\/b> <span style='color:red'>J2b1a<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Les Llometes, Alcoi, Alacant/Alicante, Valencian Community<\/b> <span style='color:red'>U5b2b5<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Les Llometes, Alcoi, Alacant/Alicante, Valencian Community<\/b> <span style='color:red'>X2b+226<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Les Llometes, Alcoi, Alacant/Alicante, Valencian Community<\/b> <span style='color:red'>HV0d<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Les Llometes, Alcoi, Alacant/Alicante, Valencian Community<\/b> <span style='color:red'>H1e1c<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Les Llometes, Alcoi, Alacant/Alicante, Valencian Community<\/b> <span style='color:red'>K1a1b1<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Les Llometes, Alcoi, Alacant/Alicante, Valencian Community<\/b> <span style='color:red'>no_data<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>La Coveta Emparetà, Bocairent, València/Valencia, Valencian Community<\/b> <span style='color:red'>X2b+226<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>La Coveta Emparetà, Bocairent, València/Valencia, Valencian Community<\/b> <span style='color:red'>X2b+226<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Les Llometes, Alcoi, Alacant/Alicante, Valencian Community<\/b> <span style='color:red'>K1b1a1c<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Les Llometes, Alcoi, Alacant/Alicante, Valencian Community<\/b> <span style='color:red'>K1a2a<\/span> <br>culture: <span style='color:#B05B3A;'>SE_Iberia_MLN<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://doi.org/10.1126/science.aav4040\" target=\"_blank\">Olalde et al. 2019<\/a>","<b>Osijek<\/b> <span style='color:red'>U5a1a2<\/span> <br>culture: <span style='color:#D36E7C;'>Sopot<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Beli Manastir-Popova zemlja<\/b> <span style='color:red'>N1a1<\/span> <br>culture: <span style='color:#D36E7C;'>Sopot<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Beli Manastir-Popova zemlja<\/b> <span style='color:red'>U5b2b<\/span> <br>culture: <span style='color:#D36E7C;'>Sopot<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Osijek<\/b> <span style='color:red'>H10<\/span> <br>culture: <span style='color:#D36E7C;'>Sopot<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Beli Manastir-Popova zemlja<\/b> <span style='color:red'>U8b1b1<\/span> <br>culture: <span style='color:#F781BF;'>Starcevo<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>","<b>Saraorci-Jezava<\/b> <span style='color:red'>K1a4a1<\/span> <br>culture: <span style='color:#F781BF;'>Starcevo<\/span> <i>Neolithic<\/i><br>ref: <a href=\"https://dx.doi.org/10.1038/nature25778\" target=\"_blank\">Mathieson et al. 2018<\/a>"],null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addLegend","args":[{"colors":["#E41A1C","#984560","#4C71A4","#3D8D95","#47A265","#5B9C5A","#7B7281","#9E5198","#CB6651","#F87B0A","#FFAF13","#FFE729","#E8D430","#C18A2B","#B05B3A","#D36E7C","#F781BF"],"labels":["Balkans_MP_Neolithic","Balkans_Neolithic","Bulgaria_EN","Bulgaria_Neolithic","Cardial Ware","France_MLN","Greece_Peloponnese_Neolithic","Hunter-Gatherer","Iberia_EN","Iberia_MN","N_Iberia_MLN","NE_Iberia_MLN","Romania_EN","SE_Iberia_Meso","SE_Iberia_MLN","Sopot","Starcevo"],"na_color":null,"na_label":"NA","opacity":1,"position":"bottomleft","type":"unknown","title":"cultures","extra":null,"layerId":null,"className":"info legend","group":null}]}],"limits":{"lat":[36.64,45.76],"lng":[-5.38,27]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption">(\#fig:cldd)Cleaned [Ancient mtDNA database](https://amtdb.org/records/) using RShiny and Leaflet in R</p>
</div>

A simple manner to model GC-coev is to create a co-occurences' graph of hg and cultures ('mt_hg' and 'culture' fields). The create graph will be a bipartite one (i.e, 2-mode graph, two classes of vertices). It could be created with the  [igraph](https://cran.r-project.org/web/packages/igraph/index.html) package. Graph drawing is a well-known heuristic, the default layout is a force-directed algorithm (e.g. Fruchterman-Reingold layout) allowing to bring  closer or move away vertices depending on the edges they share. It allows to manipulate easily the graphs. Here, graph vertices are either cultures or hg. There is a link between a culture and a hg  when an entity of the culture refers to a hg. 

![](index_7_files/figure-html/ddeodd-1.png)<!-- -->

A first reading of the graph shows that:

1. U5 hg characterize the HG group [@Bramanti09]
2. N1a hg characterize the EF group [@Brandt13]
3. H hg characterize the Late Neolithic groups [@Brandt13]

The dataset variability can be reduced with agglomeration techniques like the the [community detection algorithm](#com.det)

## Community detection {#com.det}

To to detect communities of each vertex, one can uses the 'fast greedy' algorithm  ([fastgreedy.community](https://www.rdocumentation.org/packages/igraph/versions/0.4.1/topics/fastgreedy.community) from the igraph package. This algorithm is a hierarchical ranking algorithm where initially each vertex belongs to a distinct community, and the communities are merged iteratively, so that each merge is locally optimal. The algorithm stops when it is no longer possible to increase the modularity, it will be thus gives a grouping as well as a dendrogram. This algorithm is close to the agglomeration of Ward used in hierarchical clustering (HC)

![](index_7_files/figure-html/frr-1.png)<!-- -->

A first reading of the clusters show a clear separation (i.e. edge distance) between three groups:

1. Hunter-Gatherers (Hunter-Gatherer)
2. Spain Early Neolithic (Iberia_EN)
3. Spain and France Middle/Late Neolithic (NE_Iberia_MLN and France_MLN) 

GC-coev needs to be refined. Maybe the cultural membership of mtDNA sample can be discussed upstream specifying the cultures they belong to, or downstream, choosing a different [community detection algorithm](#com.det), etc.

# mtDNA *and* radiocarbon dates

With their unique LabCode, the  dates associated with mtDNA samples can be easily be connected to existing [databases](https://neolithic.shinyapps.io/AbsoluteDating/#Databases). We will use the metadata .csv file [mtdb_metadata.csv](mtdb_metadata.csv) to join the sample identifiers with the radiocarbon dates. These latter have a unique laboratory number ([LabCode](https://zoometh.github.io/C14/neonet/#mf.labcode)). This permit to associate the mtDNA sample with the radiocarbon date. 

The dataset needs to be cleaned keeping interesting fields and removing samples with typo errors (like longitude < - 90). For this training, the selected samples are those associated to radiocarbon dates: empty radiocarbon values and empty LabCode are removed. The radiocarbon field 'bp' is not strictly formatted, a text edition has to be done with regular expressions (*regex*) by splitting the values from 'bp' field (split on '±') to copy them in two: columns BP and SD. Finally, the analysis will still focus on Early Neolithic in West Europe (longitude < 7)


```r
# selected.fields <- c("identifier", "mt_hg", "site", "culture", "epoch", "bp", "c14_lab_code", "year_from", "year_to", "longitude", "latitude", "reference_names", "reference_links")
selected.fields <- c("identifier", "site", "country", "culture", "epoch", "mt_hg", "c14_lab_code", "bp", "longitude", "latitude", "reference_names", "reference_links")
df <- read.csv(metadata, encoding = "UTF-8")
df <- df[, selected.fields]
df <- df %>% 
  # select(selected.fields) %>%
  filter(country == "Spain") %>%
  # filter(latitude > 35) %>%
  # filter(longitude > -6 & longitude < 5) %>%
  # filter(longitude >= -90 & longitude < 9) %>%
  # filter(longitude >= -90 & longitude <= 90) %>%
  # filter(latitude >= -90 & latitude <= 90) %>%
  filter(mt_hg != "" & !is.na(mt_hg)) %>%
  filter(epoch == 'Neolithic' | epoch == 'Mesolithic') %>%
  filter(bp != "" & !is.na(bp))  %>%
  filter(c14_lab_code != "" & !is.na(c14_lab_code))  %>%
  filter(str_detect(bp, "±"))  %>%
  filter(!str_detect(bp, "BP|and")) # %>%
# filter(year_from >= -6500 & year_from <= -4500)
bps <- unlist(sapply(df$bp,
                     function(x) strsplit(x, "±")),
              use.names = FALSE)
mat <- matrix(bps, ncol=2, byrow=TRUE)
df$c14bp <- as.integer(mat[, 1])
df$c14sd <- as.integer(mat[, 2])
df$bp <- NULL
```

Now the new dataset has <span style="color: grey;">12</span> samples and <span style="color: grey;">13</span> columns:

<table class="table" style="font-size: 11px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:c14)aDNA metadata sample</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> identifier </th>
   <th style="text-align:left;"> site </th>
   <th style="text-align:left;"> country </th>
   <th style="text-align:left;"> culture </th>
   <th style="text-align:left;"> epoch </th>
   <th style="text-align:left;"> mt_hg </th>
   <th style="text-align:left;"> c14_lab_code </th>
   <th style="text-align:right;"> longitude </th>
   <th style="text-align:right;"> latitude </th>
   <th style="text-align:left;"> reference_names </th>
   <th style="text-align:left;"> reference_links </th>
   <th style="text-align:right;"> c14bp </th>
   <th style="text-align:right;"> c14sd </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> I0409 </td>
   <td style="text-align:left;"> Els Trocs </td>
   <td style="text-align:left;"> Spain </td>
   <td style="text-align:left;"> Iberia_EN </td>
   <td style="text-align:left;"> Neolithic </td>
   <td style="text-align:left;"> J1c3 </td>
   <td style="text-align:left;"> MAMS-16159 </td>
   <td style="text-align:right;"> 0.500000 </td>
   <td style="text-align:right;"> 42.5000 </td>
   <td style="text-align:left;"> Haak et al. 2015 </td>
   <td style="text-align:left;"> https://dx.doi.org/10.1038/nature14317 </td>
   <td style="text-align:right;"> 6280 </td>
   <td style="text-align:right;"> 25 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CB13 </td>
   <td style="text-align:left;"> Cova Bonica, Vallirana, Barcelona </td>
   <td style="text-align:left;"> Spain </td>
   <td style="text-align:left;"> Iberia_EN </td>
   <td style="text-align:left;"> Neolithic </td>
   <td style="text-align:left;"> K1a2a </td>
   <td style="text-align:left;"> Beta-384724 </td>
   <td style="text-align:right;"> 1.890000 </td>
   <td style="text-align:right;"> 41.3700 </td>
   <td style="text-align:left;"> Olalde et al. 2015 </td>
   <td style="text-align:left;"> https://doi.org/10.1093/molbev/msv181 </td>
   <td style="text-align:right;"> 6410 </td>
   <td style="text-align:right;"> 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I0410 </td>
   <td style="text-align:left;"> Els Trocs </td>
   <td style="text-align:left;"> Spain </td>
   <td style="text-align:left;"> Iberia_EN </td>
   <td style="text-align:left;"> Neolithic </td>
   <td style="text-align:left;"> T2c1d or T2c1d2 </td>
   <td style="text-align:left;"> MAMS-16161 </td>
   <td style="text-align:right;"> 0.500000 </td>
   <td style="text-align:right;"> 42.5000 </td>
   <td style="text-align:left;"> Haak et al. 2015 </td>
   <td style="text-align:left;"> https://dx.doi.org/10.1038/nature14317 </td>
   <td style="text-align:right;"> 6217 </td>
   <td style="text-align:right;"> 25 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I0412 </td>
   <td style="text-align:left;"> Els Trocs </td>
   <td style="text-align:left;"> Spain </td>
   <td style="text-align:left;"> Iberia_EN </td>
   <td style="text-align:left;"> Neolithic </td>
   <td style="text-align:left;"> N1a1a1 </td>
   <td style="text-align:left;"> MAMS-16164 </td>
   <td style="text-align:right;"> 0.500000 </td>
   <td style="text-align:right;"> 42.5000 </td>
   <td style="text-align:left;"> Haak et al. 2015 </td>
   <td style="text-align:left;"> https://dx.doi.org/10.1038/nature14317 </td>
   <td style="text-align:right;"> 6249 </td>
   <td style="text-align:right;"> 28 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> I1972 </td>
   <td style="text-align:left;"> El Prado de Pancorbo, Burgos </td>
   <td style="text-align:left;"> Spain </td>
   <td style="text-align:left;"> Iberia_EN </td>
   <td style="text-align:left;"> Neolithic </td>
   <td style="text-align:left;"> K1a4a1 </td>
   <td style="text-align:left;"> Beta-366569 </td>
   <td style="text-align:right;"> -3.116490 </td>
   <td style="text-align:right;"> 42.6282 </td>
   <td style="text-align:left;"> Lipson et al. 2017 </td>
   <td style="text-align:left;"> https://dx.doi.org/10.1038/nature24476 </td>
   <td style="text-align:right;"> 5880 </td>
   <td style="text-align:right;"> 30 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Val05 </td>
   <td style="text-align:left;"> Valdavara 1, Becerrea, Lugo </td>
   <td style="text-align:left;"> Spain </td>
   <td style="text-align:left;"> Iberian_MN </td>
   <td style="text-align:left;"> Neolithic </td>
   <td style="text-align:left;"> H1ay </td>
   <td style="text-align:left;"> Beta-235729, Beta-235730 </td>
   <td style="text-align:right;"> -7.231459 </td>
   <td style="text-align:right;"> 42.8571 </td>
   <td style="text-align:left;"> Gonzalez-Fortes et al. 2019 </td>
   <td style="text-align:left;"> https://doi.org/10.1098/rspb.2018.2288 </td>
   <td style="text-align:right;"> 4490 </td>
   <td style="text-align:right;"> 40 </td>
  </tr>
</tbody>
</table>

The dataset can be spatialized

<div class="figure" style="text-align: center">
<!--html_preserve--><div id="htmlwidget-4be90b9ba3d54ff5ba00" style="width:60%;height:400px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-4be90b9ba3d54ff5ba00">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,"OSM",{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addCircleMarkers","args":[[42.91,43.26,41.37,42.5,42.5,42.5,42.5,42.6282,42.6282,41.25,42.7679965,42.8570953],[-5.38,-3.45,1.89,0.5,0.5,0.5,0.5,-3.11649,-3.11649,-2.33,-7.2133946,-7.2314595],3,["I0585","ElMiron","CB13","I0410","I0412","I0413","I0409","I1972","I2199","I0408","Eiros2","Val05"],null,{"interactive":true,"className":"","stroke":true,"color":["#E41A1C","#E41A1C","#47A265","#47A265","#47A265","#47A265","#47A265","#47A265","#47A265","#CB6651","#E8D430","#F781BF"],"weight":1,"opacity":0.7,"fill":true,"fillColor":["#E41A1C","#E41A1C","#47A265","#47A265","#47A265","#47A265","#47A265","#47A265","#47A265","#CB6651","#E8D430","#F781BF"],"fillOpacity":0.7},null,null,["<b>La Brana-Arintero, Leon<\/b> <span style='color:red'>U5b2c<\/span> <br>culture: <span style='color:#E41A1C;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>c14: 6980 ± 50 BP [Beta-226472]<br> ref: <a href=\"https://dx.doi.org/10.1038/nature12960\" target=\"_blank\">Olalde et al. 2014<\/a>","<b>El Miron<\/b> <span style='color:red'>U5b<\/span> <br>culture: <span style='color:#E41A1C;'>Hunter-Gatherer<\/span> <i>Mesolithic<\/i><br>c14: 15460 ± 40 BP [MAMS-14585]<br> ref: <a href=\"https://dx.doi.org/10.1038/nature17993\" target=\"_blank\">Fu et al. 2016<\/a>","<b>Cova Bonica, Vallirana, Barcelona<\/b> <span style='color:red'>K1a2a<\/span> <br>culture: <span style='color:#47A265;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>c14: 6410 ± 30 BP [Beta-384724]<br> ref: <a href=\"https://doi.org/10.1093/molbev/msv181\" target=\"_blank\">Olalde et al. 2015<\/a>","<b>Els Trocs<\/b> <span style='color:red'>T2c1d or T2c1d2<\/span> <br>culture: <span style='color:#47A265;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>c14: 6217 ± 25 BP [MAMS-16161]<br> ref: <a href=\"https://dx.doi.org/10.1038/nature14317\" target=\"_blank\">Haak et al. 2015<\/a>","<b>Els Trocs<\/b> <span style='color:red'>N1a1a1<\/span> <br>culture: <span style='color:#47A265;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>c14: 6249 ± 28 BP [MAMS-16164]<br> ref: <a href=\"https://dx.doi.org/10.1038/nature14317\" target=\"_blank\">Haak et al. 2015<\/a>","<b>Els Trocs<\/b> <span style='color:red'>V<\/span> <br>culture: <span style='color:#47A265;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>c14: 6234 ± 28 BP [MAMS-16166]<br> ref: <a href=\"https://dx.doi.org/10.1038/nature14317\" target=\"_blank\">Haak et al. 2015<\/a>","<b>Els Trocs<\/b> <span style='color:red'>J1c3<\/span> <br>culture: <span style='color:#47A265;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>c14: 6280 ± 25 BP [MAMS-16159]<br> ref: <a href=\"https://dx.doi.org/10.1038/nature14317\" target=\"_blank\">Haak et al. 2015<\/a>","<b>El Prado de Pancorbo, Burgos<\/b> <span style='color:red'>K1a4a1<\/span> <br>culture: <span style='color:#47A265;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>c14: 5880 ± 30 BP [Beta-366569]<br> ref: <a href=\"https://dx.doi.org/10.1038/nature24476\" target=\"_blank\">Lipson et al. 2017<\/a>","<b>El Prado de Pancorbo, Burgos<\/b> <span style='color:red'>H1<\/span> <br>culture: <span style='color:#47A265;'>Iberia_EN<\/span> <i>Neolithic<\/i><br>c14: 6170 ± 30 BP [Beta-438208]<br> ref: <a href=\"https://dx.doi.org/10.1038/nature24476\" target=\"_blank\">Lipson et al. 2017<\/a>","<b>La Mina<\/b> <span style='color:red'>U5b1<\/span> <br>culture: <span style='color:#CB6651;'>Iberia_MN<\/span> <i>Neolithic<\/i><br>c14: 4970 ± 30 BP [Beta-316132]<br> ref: <a href=\"https://dx.doi.org/10.1038/nature14317\" target=\"_blank\">Haak et al. 2015<\/a>","<b>Eiros, Triacastela, Lugo<\/b> <span style='color:red'>U5b3<\/span> <br>culture: <span style='color:#E8D430;'>Iberia_MN/CA<\/span> <i>Neolithic<\/i><br>c14: 4750 ± 30 BP [Beta-356716]<br> ref: <a href=\"https://doi.org/10.1098/rspb.2018.2288\" target=\"_blank\">Gonzalez-Fortes et al. 2019<\/a>","<b>Valdavara 1, Becerrea, Lugo<\/b> <span style='color:red'>H1ay<\/span> <br>culture: <span style='color:#F781BF;'>Iberian_MN<\/span> <i>Neolithic<\/i><br>c14: 4490 ± 40 BP [Beta-235729, Beta-235730]<br> ref: <a href=\"https://doi.org/10.1098/rspb.2018.2288\" target=\"_blank\">Gonzalez-Fortes et al. 2019<\/a>"],null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addLegend","args":[{"colors":["#E41A1C","#47A265","#CB6651","#E8D430","#F781BF"],"labels":["Hunter-Gatherer","Iberia_EN","Iberia_MN","Iberia_MN/CA","Iberian_MN"],"na_color":null,"na_label":"NA","opacity":1,"position":"bottomleft","type":"unknown","title":"cultures","extra":null,"layerId":null,"className":"info legend","group":null}]}],"limits":{"lat":[41.25,43.26],"lng":[-7.2314595,1.89]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption">(\#fig:map_ok)Cleaned [Ancient mtDNA database](https://amtdb.org/records/) using RShiny and Leaflet in R</p>
</div>

R offers packages to calibrate dates like [Bchron](https://cran.r-project.org/web/packages/Bchron/index.html) or [rcarbon](https://cran.r-project.org/web/packages/rcarbon/index.html)


```r
c14dates <- calibrate(x=df.MesoNeo.b$c14bp,
                      errors=df.MesoNeo.b$c14sd,
                      calCurves='intcal20',
                      ids=df.MesoNeo.b$c14_lab_code)
```

```
## [1] "Calibrating radiocarbon ages..."
##   |                                                                              |                                                                      |   0%  |                                                                              |======                                                                |   8%  |                                                                              |============                                                          |  17%  |                                                                              |==================                                                    |  25%  |                                                                              |=======================                                               |  33%  |                                                                              |=============================                                         |  42%  |                                                                              |===================================                                   |  50%  |                                                                              |=========================================                             |  58%  |                                                                              |===============================================                       |  67%  |                                                                              |====================================================                  |  75%  |                                                                              |==========================================================            |  83%  |                                                                              |================================================================      |  92%  |                                                                              |======================================================================| 100%
## [1] "Done."
```

```r
multiplot(c14dates,decreasing=TRUE,rescale=TRUE,HPD=TRUE)
```

<div class="figure" style="text-align: center">
<img src="index_7_files/figure-html/calib.all-1.png" alt="Calibration of multiple radiocarbon date with [rcarbon](https://cran.r-project.org/web/packages/rcarbon/index.html)"  />
<p class="caption">(\#fig:calib.all)Calibration of multiple radiocarbon date with [rcarbon](https://cran.r-project.org/web/packages/rcarbon/index.html)</p>
</div>

### Comtemporaneous mtDNA samples

If one wants to study contemporaneous mtDNA samples, a statistical test has be performed. At first, we can discard the date with the LabCode MAMS-14585 which it clearly isolated, and replot the rest of the dates. We add the identifiers of mtDNA samples on each summed probability distributions


```r
df.MesoNeo.c <- df.MesoNeo.b[df.MesoNeo.b$c14_lab_code != 'MAMS-14585', ]
idfs <- paste0(df.MesoNeo.c$c14_lab_code,"\n",df.MesoNeo.c$identifier)
c14dates <- calibrate(x=df.MesoNeo.c$c14bp,
                      errors=df.MesoNeo.c$c14sd,
                      calCurves='intcal20',
                      ids=idfs)
```

```
## [1] "Calibrating radiocarbon ages..."
##   |                                                                              |                                                                      |   0%  |                                                                              |======                                                                |   9%  |                                                                              |=============                                                         |  18%  |                                                                              |===================                                                   |  27%  |                                                                              |=========================                                             |  36%  |                                                                              |================================                                      |  45%  |                                                                              |======================================                                |  55%  |                                                                              |=============================================                         |  64%  |                                                                              |===================================================                   |  73%  |                                                                              |=========================================================             |  82%  |                                                                              |================================================================      |  91%  |                                                                              |======================================================================| 100%
## [1] "Done."
```

```r
multiplot(c14dates,decreasing=TRUE,rescale=TRUE,HPD=TRUE)
```

<div class="figure" style="text-align: center">
<img src="index_7_files/figure-html/calib.sel-1.png" alt="Calibration of multiple radiocarbon date with [rcarbon](https://cran.r-project.org/web/packages/rcarbon/index.html)"  />
<p class="caption">(\#fig:calib.sel)Calibration of multiple radiocarbon date with [rcarbon](https://cran.r-project.org/web/packages/rcarbon/index.html)</p>
</div>

Then we will perform a Mann-Whitney test (function [wilcox.test](https://www.rdocumentation.org/packages/stats/versions/3.6.2/topics/wilcox.test)) on the ageGrid (results of the function [BchronCalibrate](https://rdrr.io/cran/Bchron/man/BchronCalibrate.html)) for each radiocarbon date pairwise. When for a pairwise the p-value is superior to 0.05 (95%), the two dates are considered contemporaneous 


```r
l <- list()
for(i in 1:nrow(df.MesoNeo.c)){
  ids <- df.MesoNeo.c[i, "identifier"]
  a.date <- BchronCalibrate(ages=df.MesoNeo.c[i, "c14bp"],
                            ageSds=df.MesoNeo.c[i, "c14sd"],
                            calCurves='intcal20',
                            ids=df.MesoNeo.c[i, "identifier"])
  lst <- list(eval(parse(text=paste0("a.date$",ids,"$ageGrid"))))
  names(lst) <- ids
  l[length(l)+1] <- lst
}
n.obs <- sapply(l, length)
seq.max <- seq_len(max(n.obs))
mat <- t(sapply(l, "[", i = seq.max))
rownames(mat) <- df.MesoNeo.c[, "identifier"]
mat.t <- t(mat)
n.col <- 1:length(rownames(mat))
lcompar <- t(combn(n.col, 2))
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
  geom_tile(na.rm = T) +
  scale_fill_gradient2(low = "yellow", high = "red", space = "Lab",
                       na.value = 'white')+
  geom_text(aes(Var1, Var2, label = value),
            color = "black", size = 2.5)+
  theme_minimal()+
  theme_bw()+
  theme(axis.title = element_blank())+
  theme(axis.text=element_text(size=8))+
  theme(axis.ticks = element_blank())+
  theme(axis.ticks.length=unit(.1, "cm"))+
  theme(legend.position = "none")
```

<div class="figure" style="text-align: center">
<img src="index_7_files/figure-html/wilcox-1.png" alt="Mann-Whitney test results on grid ages extents of all dates pairwise"  />
<p class="caption">(\#fig:wilcox)Mann-Whitney test results on grid ages extents of all dates pairwise</p>
</div>

Only two mtDNA/radiocarbon dates have homogenized grid ages extents and can be considerated has contemporaneous, I0413 and I0410

<table class="table" style="font-size: 11px; width: auto !important; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">(\#tab:c14.contemp)Contemporaneus mtDNA samples</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> site </th>
   <th style="text-align:left;"> country </th>
   <th style="text-align:left;"> culture </th>
   <th style="text-align:left;"> identifier </th>
   <th style="text-align:left;"> mt_hg </th>
   <th style="text-align:left;"> c14_lab_code </th>
   <th style="text-align:right;"> c14bp </th>
   <th style="text-align:right;"> c14sd </th>
   <th style="text-align:left;"> reference_names </th>
   <th style="text-align:left;"> reference_links </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Els Trocs </td>
   <td style="text-align:left;"> Spain </td>
   <td style="text-align:left;"> Iberia_EN </td>
   <td style="text-align:left;"> I0410 </td>
   <td style="text-align:left;"> T2c1d or T2c1d2 </td>
   <td style="text-align:left;"> MAMS-16161 </td>
   <td style="text-align:right;"> 6217 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:left;"> Haak et al. 2015 </td>
   <td style="text-align:left;"> https://dx.doi.org/10.1038/nature14317 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Els Trocs </td>
   <td style="text-align:left;"> Spain </td>
   <td style="text-align:left;"> Iberia_EN </td>
   <td style="text-align:left;"> I0413 </td>
   <td style="text-align:left;"> V </td>
   <td style="text-align:left;"> MAMS-16166 </td>
   <td style="text-align:right;"> 6234 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:left;"> Haak et al. 2015 </td>
   <td style="text-align:left;"> https://dx.doi.org/10.1038/nature14317 </td>
  </tr>
</tbody>
</table>

# References
