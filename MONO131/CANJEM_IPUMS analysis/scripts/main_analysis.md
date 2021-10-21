Merging CANJEM with the IPUMS international census data : Cobalt,
Antimony and Tungsten
================
Jérôme Lavoué
October 20, 2021

**Having a look at CANJEM**

The three files presented below are publicly available from the [CANJEM
public app](https://lavoue.shinyapps.io/Shiny_canjem_v3/).

The summary information for cobalt on the CANJEM website has a [perment
address](http://canjem.ca/?ag=cobalt)

The table below shows all 3-Digit ISCO68 occupations which had at least
10 jobs and at least one of them exposed.

| Activity.code | Activity.title                                                                                                     | ntot | nsub | nexp |     p | Confidence | Intensity | Frequency  |   FWI |
|:--------------|:-------------------------------------------------------------------------------------------------------------------|-----:|-----:|-----:|------:|:-----------|:----------|:-----------|------:|
| 8-32          | Toolmakers, Metal Pattern Makers and Metal Markers                                                                 |   65 |   42 |   42 | 65.00 | Probable   | High      | \[2-12h\[  | 5.000 |
| 8-42          | Watch, Clock and Precision-Instrument Makers                                                                       |   64 |   43 |   14 | 22.00 | Probable   | Medium    | \[0-2h\[   | 0.120 |
| 9-69          | Stationary Engine and Related Equipment Operators Not Elsewhere Classified                                         |  114 |   74 |   17 | 15.00 | Probable   | Low       | \[2-12h\[  | 0.200 |
| 8-33          | Machine-Tool Setter-Operators                                                                                      |  152 |  108 |   17 | 11.00 | Probable   | Low       | \[2-12h\[  | 0.200 |
| 8-35          | Metal Grinders, Polishers and Tool Sharpeners                                                                      |   73 |   56 |    8 | 11.00 | Probable   | Medium    | \[2-12h\[  | 1.000 |
| 7-41          | Crushers, Grinders and Mixers                                                                                      |   57 |   48 |    6 | 11.00 | Probable   | Low       | \[2-12h\[  | 0.300 |
| 8-34          | Machine-Tool Operators                                                                                             |  209 |  152 |   21 | 10.00 | Probable   | Medium    | \[2-12h\[  | 0.200 |
| 9-22          | Printing Pressmen                                                                                                  |  108 |   74 |   10 |  9.30 | Probable   | Low       | \[2-12h\[  | 0.250 |
| 0-63          | Dentists                                                                                                           |   13 |   11 |    1 |  7.70 | Possible   | Medium    | \[0-2h\[   | 0.120 |
| 7-13          | Well Drillers, Borers and Related Workers                                                                          |   20 |   15 |    1 |  5.00 | Probable   | Low       | \[40h+\]   | 1.000 |
| 9-83          | Railway Engine-Drivers and Firemen                                                                                 |   41 |   34 |    2 |  4.90 | Probable   | Low       | \[2-12h\[  | 0.230 |
| 9-29          | Printers and Related Workers Not Elsewhere Classified                                                              |   42 |   40 |    2 |  4.80 | Definite   | Low       | \[2-12h\[  | 0.200 |
| 7-45          | Petroleum-Refining Workers                                                                                         |   22 |   20 |    1 |  4.50 | Probable   | Low       | \[2-12h\[  | 0.150 |
| 8-39          | Blacksmiths, Toolmakers and Machine-Tool Operators Not Elsewhere Classified                                        |  122 |  106 |    2 |  1.60 | Probable   | Low       | \[2-12h\[  | 0.200 |
| 9-01          | Rubber and Plastics Product Makers (except Tire Makers and Tire Vulcanizers)                                       |   88 |   82 |    1 |  1.10 | Possible   | Low       | \[40h+\]   | 1.800 |
| 5-70          | Hairdressers, Barbers, Beauticians and Related Workers                                                             |  108 |   76 |    1 |  0.93 | Possible   | Low       | \[12-40h\[ | 0.300 |
| 0-32          | Draughtsmen                                                                                                        |  183 |   90 |    1 |  0.55 | Possible   | Low       | \[12-40h\[ | 0.560 |
| 7-00          | Production Supervisors and General Foremen                                                                         |  580 |  494 |    3 |  0.52 | Probable   | Medium    | \[2-12h\[  | 1.000 |
| 8-73          | Sheet-Metal Workers                                                                                                |  208 |  153 |    1 |  0.48 | Possible   | Medium    | \[40h+\]   | 5.000 |
| 1-31          | University and Higher Education Teachers                                                                           |  224 |  169 |    1 |  0.45 | Probable   | Low       | \[2-12h\[  | 0.200 |
| 1-32          | Secondary Education Teachers                                                                                       |  297 |  205 |    1 |  0.34 | Possible   | Medium    | \[0-2h\[   | 0.120 |
| 9-99          | Labourers Not Elsewhere Classified                                                                                 |  674 |  582 |    2 |  0.30 | Probable   | Medium    | \[2-12h\[  | 0.600 |
| 5-82          | Policemen and Detectives                                                                                           |  402 |  319 |    1 |  0.25 | Probable   | Low       | \[2-12h\[  | 0.062 |
| 8-49          | Machinery Fitters, Machine Assemblers and Precision-Instrument Makers (except Electrical) Not Elsewhere Classified |  422 |  318 |    1 |  0.24 | Probable   | Low       | \[2-12h\[  | 0.200 |
| 9-71          | Dockers and Freight Handlers                                                                                       |  902 |  746 |    2 |  0.22 | Probable   | Low       | \[2-12h\[  | 0.210 |
| 5-52          | Charworkers, Cleaners and Related Workers                                                                          |  486 |  423 |    1 |  0.21 | Possible   | Low       | \[2-12h\[  | 0.200 |

Apply a function to each element of a vector

@description The map function transform the input, returning a vector
the same length as the input.

-   `map()` returns a list or a data frame
-   `map_lgl()`, `map_int()`, `map_dbl()` and `map_chr()` return vectors
    of the corresponding type (or die trying);
-   `map_dfr()` and `map_dfc()` return data frames created by
    row-binding and column-binding respectively. They require dplyr to
    be installed.
