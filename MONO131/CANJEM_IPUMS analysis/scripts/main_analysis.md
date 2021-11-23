Merging CANJEM with the IPUMS international census data : Cobalt,
Antimony and Tungsten - global descriptive analysis
================
Jérôme Lavoué
October 20, 2021

**Descriptive analysis of the IPUMS file**

population covered in millions

    ## [1] 896.6227

working population covered in millions

    ## [1] 335.4262

#number of countries

    ## [1] 43

population by country

| country | country.lab         |       n.M | year |
|--------:|:--------------------|----------:|-----:|
|     704 | Vietnam             | 36.417614 | 1999 |
|     826 | United Kingdom      | 31.484800 | 1991 |
|     608 | Philippines         | 30.714585 | 2010 |
|     231 | Ethiopia            | 24.924136 | 1994 |
|     250 | France              | 23.097700 | 1999 |
|     764 | Thailand            | 22.385510 | 2000 |
|     818 | Egypt               | 19.974660 | 2006 |
|     364 | Iran                | 17.381785 | 2006 |
|     710 | South Africa        | 10.353952 | 2007 |
|     642 | Romania             |  8.909040 | 2011 |
|     458 | Malaysia            |  8.081050 | 2000 |
|     508 | Mozambique          |  7.988730 | 2007 |
|     862 | Venezuela           |  7.781080 | 2001 |
|     800 | Uganda              |  7.508910 | 2002 |
|     116 | Cambodia            |  6.957120 | 2008 |
|     620 | Portugal            |  4.899160 | 2001 |
|     218 | Ecuador             |  4.570860 | 2001 |
|     152 | Chile               |  4.485380 | 1992 |
|     716 | Zimbabwe            |  4.383900 | 2012 |
|     112 | Belarus             |  4.296500 | 2009 |
|     192 | Cuba                |  4.191160 | 2002 |
|     300 | Greece              |  4.031560 | 2001 |
|     894 | Zambia              |  3.716550 | 2010 |
|     320 | Guatemala           |  3.449750 | 2002 |
|     646 | Rwanda              |  3.412850 | 2002 |
|     324 | Guinea              |  3.287740 | 1996 |
|     686 | Senegal             |  3.079070 | 2002 |
|      68 | Bolivia             |  2.878040 | 2001 |
|     756 | Switzerland         |  2.739000 | 2000 |
|     598 | Papua New Guinea    |  2.351870 | 2000 |
|     222 | El Salvador         |  1.961290 | 2007 |
|     600 | Paraguay            |  1.932430 | 2002 |
|     340 | Honduras            |  1.776160 | 2001 |
|     558 | Nicaragua           |  1.735460 | 2005 |
|     858 | Uruguay             |  1.302478 | 2006 |
|     188 | Costa Rica          |  1.298980 | 2000 |
|     591 | Panama              |  1.119970 | 2000 |
|      51 | Armenia             |  1.072400 | 2011 |
|     400 | Jordan              |  1.059700 | 2004 |
|     496 | Mongolia            |  0.787350 | 2000 |
|      72 | Botswana            |  0.638490 | 2011 |
|     480 | Mauritius           |  0.556430 | 2000 |
|     780 | Trinidad and Tobago |  0.451030 | 2000 |

**CANJEM only , top 5 occupations in terms of prevalence for each JEM**

*COBALT*

| ISCO88 | Title                                               | n.jobs |         p | confidence | intensity | frequency |
|:-------|:----------------------------------------------------|-------:|----------:|:-----------|:----------|:----------|
| 722    | Blacksmiths, tool-makers and related trades workers |    309 | 19.093851 | probable   | high      | 2-12h     |
| 731    | Precision workers in metal and related materials    |    115 | 12.173913 | probable   | medium    | \<2h      |
| 816    | Power-production and related plant operators        |    151 | 11.258278 | probable   | low       | 2-12h     |
| 821    | Metal- and mineral-products machine operators       |    392 |  7.908163 | probable   | medium    | 2-12h     |
| 815    | Chemical-processing-plant operators                 |    115 |  6.086957 | probable   | low       | 2-12h     |

| ISCO88 | Title                                                    | n.jobs |         p | confidence | intensity | frequency |
|:-------|:---------------------------------------------------------|-------:|----------:|:-----------|:----------|:----------|
| 816    | Power-production and related plant operators             |    151 | 31.125828 | possible   | low       | 2-12h     |
| 734    | Printing and related trades workers                      |    133 | 24.812030 | definite   | medium    | 40h+      |
| 825    | Printing-, binding- and paper-products machine operators |    187 | 11.229947 | definite   | low       | 40h+      |
| 812    | Metal-processing-plant operators                         |    158 |  6.329114 | probable   | low       | 40h+      |
| 815    | Chemical-processing-plant operators                      |    115 |  2.608696 | possible   | low       | 2-12h     |

| ISCO88 | Title                                               | n.jobs |         p | confidence | intensity | frequency |
|:-------|:----------------------------------------------------|-------:|----------:|:-----------|:----------|:----------|
| 722    | Blacksmiths, tool-makers and related trades workers |    309 | 24.271845 | probable   | high      | 2-12h     |
| 821    | Metal- and mineral-products machine operators       |    392 |  8.418367 | probable   | medium    | 2-12h     |
| 312    | Computer associate professionals                    |     57 |  1.754386 | definite   | low       | 2-12h     |
| 10     | Armed forces                                        |    802 |  0.000000 | NA         | NA        | NA        |
| 112    | Senior government officials                         |     50 |  0.000000 | NA         | NA        | NA        |

**IPUMS analysis : portrait by occupation**

*Cobalt*

| country.lab    | n.people | perc.people | estatus     |   n.unexp |     n.low | n.medium |    n.high | most.freq.confidence | most.freq.frequency |
|:---------------|---------:|------------:|:------------|----------:|----------:|---------:|----------:|:---------------------|:--------------------|
| Iran           | 298476.5 |   1.7171797 | pot.exposed | 241485.83 | 18352.923 | 7727.547 | 30910.187 | probable             | 2-12h               |
| United Kingdom | 227300.0 |   0.7219357 | pot.exposed | 183899.68 | 13976.375 | 5884.790 | 23539.159 | probable             | 2-12h               |
| France         | 199640.0 |   0.8643285 | pot.exposed | 161521.04 | 12275.599 | 5168.673 | 20674.693 | probable             | 2-12h               |
| Egypt          | 125590.0 |   0.6287466 | pot.exposed | 101610.03 |  7722.362 | 3251.521 | 13006.084 | probable             | 2-12h               |
| Romania        |  95980.0 |   1.0773327 | pot.exposed |  77653.72 |  5901.683 | 2484.919 |  9939.676 | probable             | 2-12h               |

| metric     | value             |
|:-----------|:------------------|
| total.n    | 1505152.02        |
| total.perc | 0.448728180670838 |
| estatus    | pot.exposed       |
| n.unexp    | 1217760.53398058  |
| n.low      | 92549.8005825244  |
| n.medium   | 38968.3370873787  |
| n.high     | 155873.348349515  |

*Antimony*

| country.lab | n.people | perc.people | estatus   | n.unexp | n.low | n.medium | n.high | most.freq.confidence | most.freq.frequency |
|:------------|---------:|------------:|:----------|--------:|------:|---------:|-------:|:---------------------|:--------------------|
| Armenia     |     2040 |   0.1902275 | unexposed |    2040 |     0 |        0 |      0 | NA                   | NA                  |
| Bolivia     |    10950 |   0.3804673 | unexposed |   10950 |     0 |        0 |      0 | NA                   | NA                  |
| Belarus     |    55020 |   1.2805772 | unexposed |   55020 |     0 |        0 |      0 | NA                   | NA                  |
| Switzerland |    24420 |   0.8915663 | unexposed |   24420 |     0 |        0 |      0 | NA                   | NA                  |
| Chile       |    16510 |   0.3680848 | unexposed |   16510 |     0 |        0 |      0 | NA                   | NA                  |

| metric     | value             |
|:-----------|:------------------|
| total.n    | 1505152.02        |
| total.perc | 0.448728180670838 |
| estatus    | unexposed         |
| n.unexp    | 1505152.02        |
| n.low      | 0                 |
| n.medium   | 0                 |
| n.high     | 0                 |

*Tungsten*

| country.lab    | n.people | perc.people | estatus     |   n.unexp |     n.low |  n.medium |    n.high | most.freq.confidence | most.freq.frequency |
|:---------------|---------:|------------:|:------------|----------:|----------:|----------:|----------:|:---------------------|:--------------------|
| Iran           | 298476.5 |   1.7171797 | pot.exposed | 226030.74 | 23182.640 | 22216.697 | 27046.413 | probable             | 2-12h               |
| United Kingdom | 227300.0 |   0.7219357 | pot.exposed | 172130.10 | 17654.369 | 16918.770 | 20596.764 | probable             | 2-12h               |
| France         | 199640.0 |   0.8643285 | pot.exposed | 151183.69 | 15506.019 | 14859.935 | 18090.356 | probable             | 2-12h               |
| Egypt          | 125590.0 |   0.6287466 | pot.exposed |  95106.99 |  9754.563 |  9348.123 | 11380.324 | probable             | 2-12h               |
| Romania        |  95980.0 |   1.0773327 | pot.exposed |  72683.88 |  7454.757 |  7144.142 |  8697.217 | probable             | 2-12h               |

| metric     | value             |
|:-----------|:------------------|
| total.n    | 1505152.02        |
| total.perc | 0.448728180670838 |
| estatus    | pot.exposed       |
| n.unexp    | 1139823.85980583  |
| n.low      | 116905.011262136  |
| n.medium   | 112033.969126214  |
| n.high     | 136389.179805825  |

**IPUMS analysis : portrait by country**

*Cobalt*

| isco88 | isco.lab                                            | n.people | estatus     |     p.exp |     n.low | n.medium |     n.high | most.freq.confidence | n.lessthan2h |   n.2_12h | n.12_39h | n.40handover |
|-------:|:----------------------------------------------------|---------:|:------------|----------:|----------:|---------:|-----------:|:---------------------|-------------:|----------:|---------:|-------------:|
|    722 | Blacksmiths, tool-makers and related trades workers |   199640 | pot.exposed | 19.093851 | 12275.599 | 5168.673 | 20674.6926 | probable             |       0.0000 | 36180.712 | 646.0841 |     1292.168 |
|    731 | Precision workers in metal and related materials    |    18940 | pot.exposed | 12.173913 |   494.087 | 1811.652 |     0.0000 | probable             |    1811.6522 |   494.087 |   0.0000 |        0.000 |
|    816 | Power-production and related plant operators        |    11780 | pot.exposed | 11.258278 |  1326.225 |    0.000 |     0.0000 | probable             |       0.0000 |  1326.225 |   0.0000 |        0.000 |
|    821 | Metal- and mineral-products machine operators       |    69180 | pot.exposed |  7.908163 |  2294.235 | 3000.153 |   176.4796 | probable             |     352.9592 |  4235.510 |   0.0000 |      882.398 |
|    815 | Chemical-processing-plant operators                 |   173960 | pot.exposed |  6.086957 |  7563.478 | 3025.391 |     0.0000 | probable             |       0.0000 | 10588.870 |   0.0000 |        0.000 |

| metric       |        value |
|:-------------|-------------:|
| total.n      | 2.309770e+07 |
| P.exp        | 2.743285e-01 |
| P.unexp      | 9.015320e+01 |
| P.unknown    | 9.572468e+00 |
| n.low        | 2.870460e+04 |
| n.medium     | 1.380779e+04 |
| n.high       | 2.085117e+04 |
| n.lessthan2h | 2.164611e+03 |
| n.2_12h      | 5.748138e+04 |
| n.12_39h     | 1.047047e+03 |
| n.40handover | 2.670529e+03 |

*Antimony*

| isco88 | isco.lab                                                 | n.people | estatus     |     p.exp |    n.low |  n.medium |    n.high | most.freq.confidence | n.lessthan2h |   n.2_12h | n.12_39h | n.40handover |
|-------:|:---------------------------------------------------------|---------:|:------------|----------:|---------:|----------:|----------:|:---------------------|-------------:|----------:|---------:|-------------:|
|    816 | Power-production and related plant operators             |    11780 | pot.exposed | 31.125828 | 3666.623 |    0.0000 |    0.0000 | possible             |            0 | 3666.6225 |   0.0000 |        0.000 |
|    734 | Printing and related trades workers                      |    33560 | pot.exposed | 24.812030 | 3784.962 | 4289.6241 |  252.3308 | definite             |            0 |  756.9925 | 252.3308 |     7317.594 |
|    825 | Printing-, binding- and paper-products machine operators |    74980 | pot.exposed | 11.229947 | 7618.289 |  801.9251 |    0.0000 | definite             |            0 | 2405.7754 | 400.9626 |     5613.476 |
|    812 | Metal-processing-plant operators                         |    84920 | pot.exposed |  6.329114 | 3762.278 |  537.4684 | 1074.9367 | probable             |            0 | 2687.3418 |   0.0000 |     2687.342 |
|    815 | Chemical-processing-plant operators                      |   173960 | pot.exposed |  2.608696 | 4538.087 |    0.0000 |    0.0000 | possible             |            0 | 4538.0870 |   0.0000 |        0.000 |

| metric       |        value |
|:-------------|-------------:|
| total.n      | 2.309770e+07 |
| P.exp        | 1.448400e-01 |
| P.unexp      | 9.028269e+01 |
| P.unknown    | 9.572468e+00 |
| n.low        | 2.649843e+04 |
| n.medium     | 5.629018e+03 |
| n.high       | 1.327268e+03 |
| n.lessthan2h | 0.000000e+00 |
| n.2_12h      | 1.405482e+04 |
| n.12_39h     | 1.199438e+03 |
| n.40handover | 1.820046e+04 |

*Tungsten*

| isco88 | isco.lab                                                         | n.people | estatus     |     p.exp |     n.low | n.medium |     n.high | most.freq.confidence | n.lessthan2h |   n.2_12h |  n.12_39h | n.40handover |
|-------:|:-----------------------------------------------------------------|---------:|:------------|----------:|----------:|---------:|-----------:|:---------------------|-------------:|----------:|----------:|-------------:|
|    722 | Blacksmiths, tool-makers and related trades workers              |   199640 | pot.exposed | 24.271845 | 15506.019 | 14859.94 | 18090.3560 | probable             |    2584.3366 | 40057.217 | 2584.3366 |     3230.421 |
|    821 | Metal- and mineral-products machine operators                    |    69180 | pot.exposed |  8.418367 |   882.398 |  4411.99 |   529.4388 | probable             |     529.4388 |  3882.551 |  352.9592 |     1058.878 |
|    312 | Computer associate professionals                                 |   134840 | pot.exposed |  1.754386 |  2365.614 |     0.00 |     0.0000 | definite             |       0.0000 |  2365.614 |    0.0000 |        0.000 |
|    714 | Painters, building structure cleaners and related trades workers |   129360 | unexposed   |  0.000000 |     0.000 |     0.00 |     0.0000 | NA                   |       0.0000 |     0.000 |    0.0000 |        0.000 |
|    713 | Building finishers and related trades workers                    |   445560 | unexposed   |  0.000000 |     0.000 |     0.00 |     0.0000 | NA                   |       0.0000 |     0.000 |    0.0000 |        0.000 |

| metric       |        value |
|:-------------|-------------:|
| total.n      | 2.309770e+07 |
| P.exp        | 2.452441e-01 |
| P.unexp      | 9.018229e+01 |
| P.unknown    | 9.572468e+00 |
| n.low        | 1.875403e+04 |
| n.medium     | 1.927193e+04 |
| n.high       | 1.861979e+04 |
| n.lessthan2h | 3.113775e+03 |
| n.2_12h      | 4.630538e+04 |
| n.12_39h     | 2.937296e+03 |
| n.40handover | 4.289298e+03 |

*Making an overall / overall table for COBALT*

| metric       |       value |
|:-------------|------------:|
| total.n      | 335.4262301 |
| n.exp        |   0.5438307 |
| n.unexp      | 258.9255413 |
| n.unknown    |  75.9568581 |
| n.low        |   0.2418236 |
| n.medium     |   0.1440152 |
| n.high       |   0.1579919 |
| n.lessthan2h |   0.0624684 |
| n.2_12h      |   0.4433326 |
| n.12_39h     |   0.0063379 |
| n.40handover |   0.0316918 |

*Making an overall / overall table for ANTIMONY*

| metric       |       value |
|:-------------|------------:|
| total.n      | 335.4262301 |
| n.exp        |   0.3597778 |
| n.unexp      | 259.1095942 |
| n.unknown    |  75.9568581 |
| n.low        |   0.2756293 |
| n.medium     |   0.0761072 |
| n.high       |   0.0080413 |
| n.lessthan2h |   0.0000000 |
| n.2_12h      |   0.1792140 |
| n.12_39h     |   0.0097497 |
| n.40handover |   0.1708141 |

*Making an overall / overall table for TUNGSTEN*

| metric       |       value |
|:-------------|------------:|
| total.n      | 335.4262301 |
| n.exp        |   0.4437399 |
| n.unexp      | 259.0256321 |
| n.unknown    |  75.9568581 |
| n.low        |   0.1359984 |
| n.medium     |   0.1649968 |
| n.high       |   0.1427447 |
| n.lessthan2h |   0.0258397 |
| n.2_12h      |   0.3571127 |
| n.12_39h     |   0.0237212 |
| n.40handover |   0.0370663 |
