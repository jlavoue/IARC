Merging CANJEM with the IPUMS international census data : Cobalt,
Antimony and Tungsten - global descriptive analysis
================
Jérôme Lavoué
October 20, 2021

**Descriptive analysis of the IPUMS file**

population covered in millions

    ## [1] 896.6227

#number of countries

    ## [1] 43

population by country

| country | country.lab         |   n.M |
|--------:|:--------------------|------:|
|     608 | Philippines         | 92.09 |
|     704 | Vietnam             | 76.33 |
|     818 | Egypt               | 72.82 |
|     364 | Iran                | 61.50 |
|     764 | Thailand            | 60.62 |
|     250 | France              | 58.70 |
|     826 | United Kingdom      | 54.19 |
|     231 | Ethiopia            | 52.16 |
|     710 | South Africa        | 47.17 |
|     800 | Uganda              | 24.97 |
|     862 | Venezuela           | 23.06 |
|     458 | Malaysia            | 21.76 |
|     508 | Mozambique          | 20.47 |
|     642 | Romania             | 19.92 |
|     116 | Cambodia            | 13.40 |
|     152 | Chile               | 13.35 |
|     894 | Zambia              | 13.22 |
|     716 | Zimbabwe            | 13.09 |
|     218 | Ecuador             | 12.14 |
|     320 | Guatemala           | 11.22 |
|     192 | Cuba                | 11.19 |
|     620 | Portugal            | 10.34 |
|     300 | Greece              | 10.29 |
|     686 | Senegal             |  9.95 |
|     112 | Belarus             |  9.41 |
|     646 | Rwanda              |  8.43 |
|      68 | Bolivia             |  8.28 |
|     324 | Guinea              |  7.29 |
|     756 | Switzerland         |  7.28 |
|     340 | Honduras            |  6.09 |
|     222 | El Salvador         |  5.74 |
|     598 | Papua New Guinea    |  5.19 |
|     600 | Paraguay            |  5.18 |
|     558 | Nicaragua           |  5.15 |
|     400 | Jordan              |  5.11 |
|     188 | Costa Rica          |  3.82 |
|     858 | Uruguay             |  3.07 |
|      51 | Armenia             |  3.02 |
|     591 | Panama              |  2.84 |
|     496 | Mongolia            |  2.44 |
|      72 | Botswana            |  2.02 |
|     480 | Mauritius           |  1.20 |
|     780 | Trinidad and Tobago |  1.12 |

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
| Iran           |   300000 |        0.49 | pot.exposed |  240000 | 18000 |     7800 |  31000 | probable             | 2-12h               |
| United Kingdom |   230000 |        0.42 | pot.exposed |  190000 | 14000 |     6000 |  24000 | probable             | 2-12h               |
| France         |   200000 |        0.34 | pot.exposed |  160000 | 12000 |     5200 |  21000 | probable             | 2-12h               |
| Egypt          |   130000 |        0.18 | pot.exposed |  110000 |  8000 |     3400 |  13000 | probable             | 2-12h               |
| Romania        |    96000 |        0.48 | pot.exposed |   78000 |  5900 |     2500 |   9900 | probable             | 2-12h               |

| metric     | value       |
|:-----------|:------------|
| total.n    | 1516250     |
| total.perc | 0.17        |
| estatus    | pot.exposed |
| n.unexp    | 1200000     |
| n.low      | 92000       |
| n.medium   | 39000       |
| n.high     | 160000      |

*Antimony*

| country.lab | n.people | perc.people | estatus   | n.unexp | n.low | n.medium | n.high | most.freq.confidence | most.freq.frequency |
|:------------|---------:|------------:|:----------|--------:|------:|---------:|-------:|:---------------------|:--------------------|
| Armenia     |     2000 |       0.066 | unexposed |    2000 |     0 |        0 |      0 | NA                   | NA                  |
| Bolivia     |    11000 |       0.130 | unexposed |   11000 |     0 |        0 |      0 | NA                   | NA                  |
| Belarus     |    55000 |       0.580 | unexposed |   55000 |     0 |        0 |      0 | NA                   | NA                  |
| Switzerland |    24000 |       0.330 | unexposed |   24000 |     0 |        0 |      0 | NA                   | NA                  |
| Chile       |    17000 |       0.130 | unexposed |   17000 |     0 |        0 |      0 | NA                   | NA                  |

| metric     | value     |
|:-----------|:----------|
| total.n    | 1516250   |
| total.perc | 0.17      |
| estatus    | unexposed |
| n.unexp    | 1500000   |
| n.low      | 0         |
| n.medium   | 0         |
| n.high     | 0         |

*Tungsten*

| country.lab    | n.people | perc.people | estatus     | n.unexp | n.low | n.medium | n.high | most.freq.confidence | most.freq.frequency |
|:---------------|---------:|------------:|:------------|--------:|------:|---------:|-------:|:---------------------|:--------------------|
| Iran           |   300000 |        0.49 | pot.exposed |  230000 | 23000 |    22000 |  27000 | probable             | 2-12h               |
| United Kingdom |   230000 |        0.42 | pot.exposed |  170000 | 18000 |    17000 |  21000 | probable             | 2-12h               |
| France         |   200000 |        0.34 | pot.exposed |  150000 | 16000 |    15000 |  18000 | probable             | 2-12h               |
| Egypt          |   130000 |        0.18 | pot.exposed |   98000 | 10000 |     9700 |  12000 | probable             | 2-12h               |
| Romania        |    96000 |        0.48 | pot.exposed |   73000 |  7500 |     7100 |   8700 | probable             | 2-12h               |

| metric     | value       |
|:-----------|:------------|
| total.n    | 1516250     |
| total.perc | 0.17        |
| estatus    | pot.exposed |
| n.unexp    | 1100000     |
| n.low      | 120000      |
| n.medium   | 110000      |
| n.high     | 140000      |
