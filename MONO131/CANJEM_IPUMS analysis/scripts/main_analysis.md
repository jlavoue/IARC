Merging CANJEM with the IPUMS international census data : Cobalt,
Antimony and Tungsten - global descriptive analysis
================
Jérôme Lavoué
October 20, 2021

**Descriptive analysis of the IPUMS file**

population covered in millions

    ## [1] 896.6227

working population covered in millions

    ## [1] 345.4254

#number of countries

    ## [1] 43

population by country

| country | country.lab         |    n.M | year |
|--------:|:--------------------|-------:|-----:|
|     704 | Vietnam             | 36.432 | 1999 |
|     826 | United Kingdom      | 31.738 | 1991 |
|     608 | Philippines         | 31.360 | 2010 |
|     764 | Thailand            | 25.250 | 2000 |
|     231 | Ethiopia            | 25.169 | 1994 |
|     250 | France              | 23.098 | 1999 |
|     818 | Egypt               | 20.172 | 2006 |
|     364 | Iran                | 17.382 | 2006 |
|     710 | South Africa        | 12.319 | 2007 |
|     642 | Romania             |  8.909 | 2011 |
|     862 | Venezuela           |  8.352 | 2001 |
|     458 | Malaysia            |  8.166 | 2000 |
|     508 | Mozambique          |  8.016 | 2007 |
|     800 | Uganda              |  7.509 | 2002 |
|     116 | Cambodia            |  6.957 | 2008 |
|     218 | Ecuador             |  4.915 | 2001 |
|     620 | Portugal            |  4.899 | 2001 |
|     716 | Zimbabwe            |  4.616 | 2012 |
|     112 | Belarus             |  4.562 | 2009 |
|     152 | Chile               |  4.542 | 1992 |
|     192 | Cuba                |  4.295 | 2002 |
|     300 | Greece              |  4.126 | 2001 |
|     894 | Zambia              |  3.886 | 2010 |
|     756 | Switzerland         |  3.795 | 2000 |
|     646 | Rwanda              |  3.626 | 2002 |
|     320 | Guatemala           |  3.450 | 2002 |
|     324 | Guinea              |  3.381 | 1996 |
|     686 | Senegal             |  3.206 | 2002 |
|      68 | Bolivia             |  3.032 | 2001 |
|     598 | Papua New Guinea    |  2.364 | 2000 |
|     600 | Paraguay            |  1.989 | 2002 |
|     222 | El Salvador         |  1.961 | 2007 |
|     340 | Honduras            |  1.866 | 2001 |
|     558 | Nicaragua           |  1.747 | 2005 |
|     858 | Uruguay             |  1.304 | 2006 |
|     188 | Costa Rica          |  1.299 | 2000 |
|     591 | Panama              |  1.120 | 2000 |
|      51 | Armenia             |  1.087 | 2011 |
|     400 | Jordan              |  1.065 | 2004 |
|     496 | Mongolia            |  0.796 | 2000 |
|      72 | Botswana            |  0.639 | 2011 |
|     480 | Mauritius           |  0.558 | 2000 |
|     780 | Trinidad and Tobago |  0.470 | 2000 |

**CANJEM only , top 5 occupations in terms of prevalence for each JEM**

*COBALT*

| ISCO88 | Title                                               | n.jobs |    p | confidence | intensity | frequency |
|:-------|:----------------------------------------------------|-------:|-----:|:-----------|:----------|:----------|
| 722    | Blacksmiths, tool-makers and related trades workers |    309 | 19.0 | probable   | high      | 2-12h     |
| 731    | Precision workers in metal and related materials    |    115 | 12.0 | probable   | medium    | \<2h      |
| 816    | Power-production and related plant operators        |    151 | 11.0 | probable   | low       | 2-12h     |
| 821    | Metal- and mineral-products machine operators       |    392 |  7.9 | probable   | medium    | 2-12h     |
| 815    | Chemical-processing-plant operators                 |    115 |  6.1 | probable   | low       | 2-12h     |

| ISCO88 | Title                                                    | n.jobs |    p | confidence | intensity | frequency |
|:-------|:---------------------------------------------------------|-------:|-----:|:-----------|:----------|:----------|
| 816    | Power-production and related plant operators             |    151 | 31.0 | possible   | low       | 2-12h     |
| 734    | Printing and related trades workers                      |    133 | 25.0 | definite   | medium    | 40h+      |
| 825    | Printing-, binding- and paper-products machine operators |    187 | 11.0 | definite   | low       | 40h+      |
| 812    | Metal-processing-plant operators                         |    158 |  6.3 | probable   | low       | 40h+      |
| 815    | Chemical-processing-plant operators                      |    115 |  2.6 | possible   | low       | 2-12h     |

| ISCO88 | Title                                                     | n.jobs |     p | confidence | intensity | frequency |
|:-------|:----------------------------------------------------------|-------:|------:|:-----------|:----------|:----------|
| 722    | Blacksmiths, tool-makers and related trades workers       |    309 | 24.00 | probable   | high      | 2-12h     |
| 821    | Metal- and mineral-products machine operators             |    392 |  8.40 | probable   | medium    | 2-12h     |
| 312    | Computer associate professionals                          |     57 |  1.80 | definite   | low       | 2-12h     |
| 315    | Safety and quality inspectors                             |    203 |  0.49 | possible   | low       | 40h+      |
| 724    | Electrical and electronic equipment mechanics and fitters |    240 |  0.42 | possible   | low       | 2-12h     |

**IPUMS analysis : portrait by occupation**

*Cobalt*

| country.lab    | n.people | perc.people | estatus     | n.unexp | n.low | n.medium | n.high | most.freq.confidence | most.freq.frequency |
|:---------------|---------:|------------:|:------------|--------:|------:|---------:|-------:|:---------------------|:--------------------|
| Iran           |   298000 |       1.710 | pot.exposed |  240000 | 18000 |     7700 |  31000 | probable             | 2-12h               |
| United Kingdom |   227000 |       0.715 | pot.exposed |  180000 | 14000 |     5900 |  24000 | probable             | 2-12h               |
| France         |   200000 |       0.866 | pot.exposed |  160000 | 12000 |     5200 |  21000 | probable             | 2-12h               |
| Egypt          |   126000 |       0.625 | pot.exposed |  100000 |  7700 |     3300 |  13000 | probable             | 2-12h               |
| Romania        |    96000 |       1.080 | pot.exposed |   78000 |  5900 |     2500 |   9900 | probable             | 2-12h               |

| metric     | value       |
|:-----------|:------------|
| total.n    | 1510000     |
| total.perc | 0.437       |
| estatus    | pot.exposed |
| n.unexp    | 1210000     |
| n.low      | 91900       |
| n.medium   | 39100       |
| n.high     | 157000      |

*Antimony*

| country.lab | n.people | perc.people | estatus   | n.unexp | n.low | n.medium | n.high | most.freq.confidence | most.freq.frequency |
|:------------|---------:|------------:|:----------|--------:|------:|---------:|-------:|:---------------------|:--------------------|
| Armenia     |     2040 |       0.188 | unexposed |    2000 |     0 |        0 |      0 | NA                   | NA                  |
| Bolivia     |    11000 |       0.363 | unexposed |   11000 |     0 |        0 |      0 | NA                   | NA                  |
| Belarus     |    55000 |       1.210 | unexposed |   55000 |     0 |        0 |      0 | NA                   | NA                  |
| Switzerland |    24400 |       0.643 | unexposed |   24000 |     0 |        0 |      0 | NA                   | NA                  |
| Chile       |    16500 |       0.363 | unexposed |   16000 |     0 |        0 |      0 | NA                   | NA                  |

| metric     | value     |
|:-----------|:----------|
| total.n    | 1510000   |
| total.perc | 0.437     |
| estatus    | unexposed |
| n.unexp    | 1510000   |
| n.low      | 0         |
| n.medium   | 0         |
| n.high     | 0         |

*Tungsten*

| country.lab    | n.people | perc.people | estatus     | n.unexp | n.low | n.medium | n.high | most.freq.confidence | most.freq.frequency |
|:---------------|---------:|------------:|:------------|--------:|------:|---------:|-------:|:---------------------|:--------------------|
| Iran           |   298000 |       1.710 | pot.exposed |  230000 | 23000 |    22000 |  27000 | probable             | 2-12h               |
| United Kingdom |   227000 |       0.715 | pot.exposed |  170000 | 18000 |    17000 |  21000 | probable             | 2-12h               |
| France         |   200000 |       0.866 | pot.exposed |  150000 | 16000 |    15000 |  18000 | probable             | 2-12h               |
| Egypt          |   126000 |       0.625 | pot.exposed |   95000 |  9800 |     9400 |  11000 | probable             | 2-12h               |
| Romania        |    96000 |       1.080 | pot.exposed |   73000 |  7500 |     7100 |   8700 | probable             | 2-12h               |

| metric     | value       |
|:-----------|:------------|
| total.n    | 1510000     |
| total.perc | 0.437       |
| estatus    | pot.exposed |
| n.unexp    | 1140000     |
| n.low      | 118000      |
| n.medium   | 112000      |
| n.high     | 136000      |

**IPUMS analysis : portrait by country**

*Cobalt*

``` r
     selected.country <- 250
       
     country.tab.cobalt <- data.frame( isco88 = unique( ipums$isco88a[ ipums$country == selected.country] )) 
     
     country.tab.cobalt$isco.lab <- isco$Label[ match( country.tab.cobalt$isco88 , isco$Value)]
     
     country.tab.cobalt <- country.tab.cobalt[ !is.element( country.tab.cobalt$isco88 , c(998,999) )   ,  ]
     
     country.tab.cobalt$n.people <- signif( ipums$n_people[ ipums$country == selected.country ][ match( country.tab.cobalt$isco88 ,ipums$isco88a[ ipums$country == selected.country ] )] , 3)
     
     country.tab.cobalt$estatus <- canjem.pop.cobalt$exposed[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D)]
     
     country.tab.cobalt$estatus[ is.na(country.tab.cobalt$estatus)] <- "unknown"
     
     country.tab.cobalt$p.exp <- canjem.pop.cobalt$p[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D)]
     
          country.tab.cobalt$p.exp[ country.tab.cobalt$estatus == "unexposed" ] <- 0
     
    country.tab.cobalt$n.low <- signif(country.tab.cobalt$n.people*canjem.pop.cobalt$p.C1[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 , 2 )
    
          country.tab.cobalt$n.low[ country.tab.cobalt$estatus == "unexposed" ] <- 0
     
    country.tab.cobalt$n.medium <- signif(country.tab.cobalt$n.people*canjem.pop.cobalt$p.C2[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 , 2 )
    
          country.tab.cobalt$n.medium[ country.tab.cobalt$estatus == "unexposed" ] <- 0
     
    country.tab.cobalt$n.high <- signif(country.tab.cobalt$n.people*canjem.pop.cobalt$p.C3[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 , 2 )
    
          country.tab.cobalt$n.high[ country.tab.cobalt$estatus == "unexposed" ] <- 0
     
    country.tab.cobalt$most.freq.confidence <- ifelse(country.tab.cobalt$estatus == "pot.exposed", 
                                                        confidence$label[ match( canjem.pop.cobalt$most.freq.confidence[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ] , confidence$code ) ],
                                                        NA)
     
    country.tab.cobalt$n.lessthan2h <- signif(country.tab.cobalt$n.people*canjem.pop.cobalt$p.F1[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 , 2 )
    
    country.tab.cobalt$n.lessthan2h[ country.tab.cobalt$estatus == "unexposed" ] <- 0
    
    country.tab.cobalt$n.2_12h <- signif(country.tab.cobalt$n.people*canjem.pop.cobalt$p.F2[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 , 2 )
    
    country.tab.cobalt$n.2_12h[ country.tab.cobalt$estatus == "unexposed" ] <- 0
    
    country.tab.cobalt$n.12_39h <- signif(country.tab.cobalt$n.people*canjem.pop.cobalt$p.F3[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 , 2 )
    
    country.tab.cobalt$n.12_39h[ country.tab.cobalt$estatus == "unexposed" ] <- 0
    
    country.tab.cobalt$n.40handover <- signif(country.tab.cobalt$n.people*canjem.pop.cobalt$p.F4[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 , 2 )
    
    country.tab.cobalt$n.40handover[ country.tab.cobalt$estatus == "unexposed" ] <- 0
    
    knitr::kable( country.tab.cobalt[ order( country.tab.cobalt$p.exp , decreasing = TRUE )[ 1:5] , ] , row.names = FALSE) 
```

| isco88 | isco.lab                                            | n.people | estatus     |     p.exp | n.low | n.medium | n.high | most.freq.confidence | n.lessthan2h | n.2_12h | n.12_39h | n.40handover |
|-------:|:----------------------------------------------------|---------:|:------------|----------:|------:|---------:|-------:|:---------------------|-------------:|--------:|---------:|-------------:|
|    722 | Blacksmiths, tool-makers and related trades workers |   200000 | pot.exposed | 19.093851 | 12000 |     5200 |  21000 | probable             |            0 |   36000 |      650 |         1300 |
|    731 | Precision workers in metal and related materials    |    18900 | pot.exposed | 12.173913 |   490 |     1800 |      0 | probable             |         1800 |     490 |        0 |            0 |
|    816 | Power-production and related plant operators        |    11800 | pot.exposed | 11.258278 |  1300 |        0 |      0 | probable             |            0 |    1300 |        0 |            0 |
|    821 | Metal- and mineral-products machine operators       |    69200 | pot.exposed |  7.908163 |  2300 |     3000 |    180 | probable             |          350 |    4200 |        0 |          880 |
|    815 | Chemical-processing-plant operators                 |   174000 | pot.exposed |  6.086957 |  7600 |     3000 |      0 | probable             |            0 |   11000 |        0 |            0 |

``` r
    ## global portrait
    
    country.overall.cobalt <- data.frame( metric = c("total.n" , "P.exp" , "P.unexp" ,"P.unknown" , "n.low" , "n.medium" , "n.high" , "n.lessthan2h" , "n.2_12h" , "n.12_39h" , "n.40handover") , stringsAsFactors = FALSE )
    
    country.overall.cobalt$value[1] <- signif(sum(country.tab.cobalt$n.people),3)
    
    country.overall.cobalt$value[2] <- signif( 100*sum(country.tab.cobalt$n.people[ country.tab.cobalt$estatus == "pot.exposed"] * country.tab.cobalt$p.exp[ country.tab.cobalt$estatus == "pot.exposed"]/100)/country.overall.cobalt$value[1]  , 3)
    
    country.overall.cobalt$value[3] <- signif( 100* ( sum(country.tab.cobalt$n.people[ country.tab.cobalt$estatus=="unexposed" ]) + 
                                                        sum(country.tab.cobalt$n.people[ country.tab.cobalt$estatus == "pot.exposed"])-
                                                        sum(country.tab.cobalt$n.people[ country.tab.cobalt$estatus == "pot.exposed"] * country.tab.cobalt$p.exp[ country.tab.cobalt$estatus == "pot.exposed"]/100)) / country.overall.cobalt$value[1]  , 3)
    
    country.overall.cobalt$value[4] <- signif( 100*sum(country.tab.cobalt$n.people[ country.tab.cobalt$estatus == "unknown"])/country.overall.cobalt$value[1]  , 3)
    
    country.overall.cobalt$value[5] <- signif( sum( country.tab.cobalt$n.low , na.rm = TRUE ) , 3)
    
    country.overall.cobalt$value[6] <- signif( sum( country.tab.cobalt$n.medium , na.rm = TRUE  ) , 3)
    
    country.overall.cobalt$value[7] <- signif( sum( country.tab.cobalt$n.high , na.rm = TRUE  ) , 3)
    
    country.overall.cobalt$value[8] <- signif( sum( country.tab.cobalt$n.lessthan2h , na.rm = TRUE  ) , 3)
    
    country.overall.cobalt$value[9] <- signif( sum( country.tab.cobalt$n.2_12h , na.rm = TRUE  ) , 3)
    
    country.overall.cobalt$value[10] <- signif( sum( country.tab.cobalt$n.12_39h , na.rm = TRUE  ) , 3)
    
    country.overall.cobalt$value[11] <- signif( sum( country.tab.cobalt$n.40handover , na.rm = TRUE  ) , 3)
    
    knitr::kable( country.overall.cobalt , row.names = FALSE) 
```

| metric       |    value |
|:-------------|---------:|
| total.n      | 2.31e+07 |
| P.exp        | 2.75e-01 |
| P.unexp      | 9.02e+01 |
| P.unknown    | 9.57e+00 |
| n.low        | 2.84e+04 |
| n.medium     | 1.38e+04 |
| n.high       | 2.12e+04 |
| n.lessthan2h | 2.15e+03 |
| n.2_12h      | 5.76e+04 |
| n.12_39h     | 1.05e+03 |
| n.40handover | 2.68e+03 |

*Antimony*

``` r
    selected.country <- 250
    
    country.tab.antimony <- data.frame( isco88 = unique( ipums$isco88a[ ipums$country == selected.country] )) 
    
    country.tab.antimony$isco.lab <- isco$Label[ match( country.tab.antimony$isco88 , isco$Value)]
    
    country.tab.antimony <- country.tab.antimony[ !is.element( country.tab.antimony$isco88 , c(998,999) )   ,  ]
    
    country.tab.antimony$n.people <- signif( ipums$n_people[ ipums$country == selected.country ][ match( country.tab.antimony$isco88 ,ipums$isco88a[ ipums$country == selected.country ] )] ,3)
    
    country.tab.antimony$estatus <- canjem.pop.antimony$exposed[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D)]
    
    country.tab.antimony$estatus[ is.na(country.tab.antimony$estatus)] <- "unknown"
    
    country.tab.antimony$p.exp <- canjem.pop.antimony$p[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D)]
    
    country.tab.antimony$p.exp[ country.tab.antimony$estatus == "unexposed" ] <- 0
    
    country.tab.antimony$n.low <- signif(country.tab.antimony$n.people*canjem.pop.antimony$p.C1[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 , 2 )
    
    country.tab.antimony$n.low[ country.tab.antimony$estatus == "unexposed" ] <- 0
    
    country.tab.antimony$n.medium <- signif(country.tab.antimony$n.people*canjem.pop.antimony$p.C2[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 , 2 )
    
    country.tab.antimony$n.medium[ country.tab.antimony$estatus == "unexposed" ] <- 0
    
    country.tab.antimony$n.high <- signif(country.tab.antimony$n.people*canjem.pop.antimony$p.C3[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 , 2 )
    
    country.tab.antimony$n.high[ country.tab.antimony$estatus == "unexposed" ] <- 0
    
    country.tab.antimony$most.freq.confidence <- ifelse(country.tab.antimony$estatus == "pot.exposed", 
                                                      confidence$label[ match( canjem.pop.antimony$most.freq.confidence[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ] , confidence$code ) ],
                                                      NA)
    
    country.tab.antimony$n.lessthan2h <- signif(country.tab.antimony$n.people*canjem.pop.antimony$p.F1[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 , 2 )
    
    country.tab.antimony$n.lessthan2h[ country.tab.antimony$estatus == "unexposed" ] <- 0
    
    country.tab.antimony$n.2_12h <- signif(country.tab.antimony$n.people*canjem.pop.antimony$p.F2[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 , 2 )
    
    country.tab.antimony$n.2_12h[ country.tab.antimony$estatus == "unexposed" ] <- 0
    
    country.tab.antimony$n.12_39h <- signif(country.tab.antimony$n.people*canjem.pop.antimony$p.F3[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 , 2 )
    
    country.tab.antimony$n.12_39h[ country.tab.antimony$estatus == "unexposed" ] <- 0
    
    country.tab.antimony$n.40handover <- signif(country.tab.antimony$n.people*canjem.pop.antimony$p.F4[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 , 2 )
    
    country.tab.antimony$n.40handover[ country.tab.antimony$estatus == "unexposed" ] <- 0
    
    knitr::kable( country.tab.antimony[ order( country.tab.antimony$p.exp , decreasing = TRUE )[ 1:5] , ] , row.names = FALSE) 
```

| isco88 | isco.lab                                                 | n.people | estatus     |     p.exp | n.low | n.medium | n.high | most.freq.confidence | n.lessthan2h | n.2_12h | n.12_39h | n.40handover |
|-------:|:---------------------------------------------------------|---------:|:------------|----------:|------:|---------:|-------:|:---------------------|-------------:|--------:|---------:|-------------:|
|    816 | Power-production and related plant operators             |    11800 | pot.exposed | 31.125828 |  3700 |        0 |      0 | possible             |            0 |    3700 |        0 |            0 |
|    734 | Printing and related trades workers                      |    33600 | pot.exposed | 24.812030 |  3800 |     4300 |    250 | definite             |            0 |     760 |      250 |         7300 |
|    825 | Printing-, binding- and paper-products machine operators |    75000 | pot.exposed | 11.229947 |  7600 |      800 |      0 | definite             |            0 |    2400 |      400 |         5600 |
|    812 | Metal-processing-plant operators                         |    84900 | pot.exposed |  6.329114 |  3800 |      540 |   1100 | probable             |            0 |    2700 |        0 |         2700 |
|    815 | Chemical-processing-plant operators                      |   174000 | pot.exposed |  2.608696 |  4500 |        0 |      0 | possible             |            0 |    4500 |        0 |            0 |

``` r
    ## global portrait
    
    country.overall.antimony <- data.frame( metric = c("total.n" , "P.exp" , "P.unexp" ,"P.unknown" , "n.low" , "n.medium" , "n.high" , "n.lessthan2h" , "n.2_12h" , "n.12_39h" , "n.40handover") , stringsAsFactors = FALSE )
    
    country.overall.antimony$value[1] <- signif( sum(country.tab.antimony$n.people) )
    
    country.overall.antimony$value[2] <- signif( 100*sum(country.tab.antimony$n.people[ country.tab.antimony$estatus == "pot.exposed"] * country.tab.antimony$p.exp[ country.tab.antimony$estatus == "pot.exposed"]/100)/country.overall.antimony$value[1]  , 3)
    
    country.overall.antimony$value[3] <- signif( 100* ( sum(country.tab.antimony$n.people[ country.tab.antimony$estatus=="unexposed" ]) + 
                                                        sum(country.tab.antimony$n.people[ country.tab.antimony$estatus == "pot.exposed"])-
                                                        sum(country.tab.antimony$n.people[ country.tab.antimony$estatus == "pot.exposed"] * country.tab.antimony$p.exp[ country.tab.antimony$estatus == "pot.exposed"]/100)) / country.overall.antimony$value[1]  , 3)
    
    country.overall.antimony$value[4] <- signif( 100*sum(country.tab.antimony$n.people[ country.tab.antimony$estatus == "unknown"])/country.overall.antimony$value[1]  , 3)
    
    country.overall.antimony$value[5] <- signif( sum( country.tab.antimony$n.low , na.rm = TRUE ) , 3)
    
    country.overall.antimony$value[6] <- signif( sum( country.tab.antimony$n.medium , na.rm = TRUE  ) , 3)
    
    country.overall.antimony$value[7] <- signif( sum( country.tab.antimony$n.high , na.rm = TRUE  ) , 3)
    
    country.overall.antimony$value[8] <- signif( sum( country.tab.antimony$n.lessthan2h , na.rm = TRUE  ) , 3)
    
    country.overall.antimony$value[9] <- signif( sum( country.tab.antimony$n.2_12h , na.rm = TRUE  ) , 3)
    
    country.overall.antimony$value[10] <- signif( sum( country.tab.antimony$n.12_39h , na.rm = TRUE  ) , 3)
    
    country.overall.antimony$value[11] <- signif( sum( country.tab.antimony$n.40handover , na.rm = TRUE  ) , 3)
    
    knitr::kable( country.overall.antimony , row.names = FALSE) 
```

| metric       |      value |
|:-------------|-----------:|
| total.n      | 2.3102e+07 |
| P.exp        | 1.4500e-01 |
| P.unexp      | 9.0300e+01 |
| P.unknown    | 9.5700e+00 |
| n.low        | 2.6500e+04 |
| n.medium     | 5.6400e+03 |
| n.high       | 1.3500e+03 |
| n.lessthan2h | 0.0000e+00 |
| n.2_12h      | 1.4100e+04 |
| n.12_39h     | 1.2000e+03 |
| n.40handover | 1.8100e+04 |

*Tungsten*

``` r
    selected.country <- 250
    
    country.tab.tungsten <- data.frame( isco88 = unique( ipums$isco88a[ ipums$country == selected.country] )) 
    
    country.tab.tungsten$isco.lab <- isco$Label[ match( country.tab.tungsten$isco88 , isco$Value)]
    
    country.tab.tungsten <- country.tab.tungsten[ !is.element( country.tab.tungsten$isco88 , c(998,999) )   ,  ]
    
    country.tab.tungsten$n.people <- signif( ipums$n_people[ ipums$country == selected.country ][ match( country.tab.tungsten$isco88 ,ipums$isco88a[ ipums$country == selected.country ] )] , 3)
    
    country.tab.tungsten$estatus <- canjem.pop.tungsten$exposed[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D)]
    
    country.tab.tungsten$estatus[ is.na(country.tab.tungsten$estatus)] <- "unknown"
    
    country.tab.tungsten$p.exp <- canjem.pop.tungsten$p[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D)]
    
    country.tab.tungsten$p.exp[ country.tab.tungsten$estatus == "unexposed" ] <- 0
    
    country.tab.tungsten$n.low <- signif(country.tab.tungsten$n.people*canjem.pop.tungsten$p.C1[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 , 2 )
    
    country.tab.tungsten$n.low[ country.tab.tungsten$estatus == "unexposed" ] <- 0
    
    country.tab.tungsten$n.medium <- signif(country.tab.tungsten$n.people*canjem.pop.tungsten$p.C2[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 , 2 )
    
    country.tab.tungsten$n.medium[ country.tab.tungsten$estatus == "unexposed" ] <- 0
    
    country.tab.tungsten$n.high <- signif(country.tab.tungsten$n.people*canjem.pop.tungsten$p.C3[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 , 2 )
    
    country.tab.tungsten$n.high[ country.tab.tungsten$estatus == "unexposed" ] <- 0
    
    country.tab.tungsten$most.freq.confidence <- ifelse(country.tab.tungsten$estatus == "pot.exposed", 
                                                      confidence$label[ match( canjem.pop.tungsten$most.freq.confidence[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ] , confidence$code ) ],
                                                      NA)
    
    country.tab.tungsten$n.lessthan2h <- signif(country.tab.tungsten$n.people*canjem.pop.tungsten$p.F1[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 , 2 )
    
    country.tab.tungsten$n.lessthan2h[ country.tab.tungsten$estatus == "unexposed" ] <- 0
    
    country.tab.tungsten$n.2_12h <- signif(country.tab.tungsten$n.people*canjem.pop.tungsten$p.F2[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 , 2 )
    
    country.tab.tungsten$n.2_12h[ country.tab.tungsten$estatus == "unexposed" ] <- 0
    
    country.tab.tungsten$n.12_39h <- signif(country.tab.tungsten$n.people*canjem.pop.tungsten$p.F3[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 , 2 )
    
    country.tab.tungsten$n.12_39h[ country.tab.tungsten$estatus == "unexposed" ] <- 0
    
    country.tab.tungsten$n.40handover <- signif(country.tab.tungsten$n.people*canjem.pop.tungsten$p.F4[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 , 2 )
    
    country.tab.tungsten$n.40handover[ country.tab.tungsten$estatus == "unexposed" ] <- 0
    
    knitr::kable( country.tab.tungsten[ order( country.tab.tungsten$p.exp , decreasing = TRUE )[ 1:5] , ] , row.names = FALSE) 
```

| isco88 | isco.lab                                                         | n.people | estatus     |     p.exp | n.low | n.medium | n.high | most.freq.confidence | n.lessthan2h | n.2_12h | n.12_39h | n.40handover |
|-------:|:-----------------------------------------------------------------|---------:|:------------|----------:|------:|---------:|-------:|:---------------------|-------------:|--------:|---------:|-------------:|
|    722 | Blacksmiths, tool-makers and related trades workers              |   200000 | pot.exposed | 24.271845 | 16000 |    15000 |  18000 | probable             |         2600 |   40000 |     2600 |         3200 |
|    821 | Metal- and mineral-products machine operators                    |    69200 | pot.exposed |  8.418367 |   880 |     4400 |    530 | probable             |          530 |    3900 |      350 |         1100 |
|    312 | Computer associate professionals                                 |   135000 | pot.exposed |  1.754386 |  2400 |        0 |      0 | definite             |            0 |    2400 |        0 |            0 |
|    714 | Painters, building structure cleaners and related trades workers |   129000 | unexposed   |  0.000000 |     0 |        0 |      0 | NA                   |            0 |       0 |        0 |            0 |
|    713 | Building finishers and related trades workers                    |   446000 | unexposed   |  0.000000 |     0 |        0 |      0 | NA                   |            0 |       0 |        0 |            0 |

``` r
    ## global portrait
    
    country.overall.tungsten <- data.frame( metric = c("total.n" , "P.exp" , "P.unexp" ,"P.unknown" , "n.low" , "n.medium" , "n.high" , "n.lessthan2h" , "n.2_12h" , "n.12_39h" , "n.40handover") , stringsAsFactors = FALSE )
    
    country.overall.tungsten$value[1] <- signif( sum(country.tab.tungsten$n.people) , 3)
    
    country.overall.tungsten$value[2] <- signif( 100*sum(country.tab.tungsten$n.people[ country.tab.tungsten$estatus == "pot.exposed"] * country.tab.tungsten$p.exp[ country.tab.tungsten$estatus == "pot.exposed"]/100)/country.overall.tungsten$value[1]  , 3)
    
    country.overall.tungsten$value[3] <- signif( 100* ( sum(country.tab.tungsten$n.people[ country.tab.tungsten$estatus=="unexposed" ]) + 
                                                        sum(country.tab.tungsten$n.people[ country.tab.tungsten$estatus == "pot.exposed"])-
                                                        sum(country.tab.tungsten$n.people[ country.tab.tungsten$estatus == "pot.exposed"] * country.tab.tungsten$p.exp[ country.tab.tungsten$estatus == "pot.exposed"]/100)) / country.overall.tungsten$value[1]  , 3)
    
    country.overall.tungsten$value[4] <- signif( 100*sum(country.tab.tungsten$n.people[ country.tab.tungsten$estatus == "unknown"])/country.overall.tungsten$value[1]  , 3)
    
    country.overall.tungsten$value[5] <- signif( sum( country.tab.tungsten$n.low , na.rm = TRUE ) , 3)
    
    country.overall.tungsten$value[6] <- signif( sum( country.tab.tungsten$n.medium , na.rm = TRUE  ) , 3)
    
    country.overall.tungsten$value[7] <- signif( sum( country.tab.tungsten$n.high , na.rm = TRUE  ) , 3)
    
    country.overall.tungsten$value[8] <- signif( sum( country.tab.tungsten$n.lessthan2h , na.rm = TRUE  ) , 3)
    
    country.overall.tungsten$value[9] <- signif( sum( country.tab.tungsten$n.2_12h , na.rm = TRUE  ) , 3)
    
    country.overall.tungsten$value[10] <- signif( sum( country.tab.tungsten$n.12_39h , na.rm = TRUE  ) , 3)
    
    country.overall.tungsten$value[11] <- signif( sum( country.tab.tungsten$n.40handover , na.rm = TRUE  ) , 3)
    
    knitr::kable( country.overall.tungsten , row.names = FALSE)     
```

| metric       |    value |
|:-------------|---------:|
| total.n      | 2.31e+07 |
| P.exp        | 2.46e-01 |
| P.unexp      | 9.02e+01 |
| P.unknown    | 9.57e+00 |
| n.low        | 1.93e+04 |
| n.medium     | 1.94e+04 |
| n.high       | 1.85e+04 |
| n.lessthan2h | 3.13e+03 |
| n.2_12h      | 4.63e+04 |
| n.12_39h     | 2.95e+03 |
| n.40handover | 4.30e+03 |
