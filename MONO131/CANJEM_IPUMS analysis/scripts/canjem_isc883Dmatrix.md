Creation of the ISCO-3D CANJEM for Cobalt, Antimony and Tungsten
================
Jérôme Lavoué
November 16th, 2021

*This script 1. creates CANJEM ISCO88_3D for Cobalt, Antimony and
Tungsten according to various constraints and 2.evaluates each job in
the CANJEM databases as “exposed”, “unexposed” , “unknown”.*

The table below describes the state of the ISCO68 to ISCO683D crosswalk
as applied to the CANJEM population. “low resolution” was excluded
because the ISCO codes in the crosswalk were 2-digit codes.
“supervisors” was excluded because this status does not have a code in
ISCO88.EQUAL means the CAPS and GANZEBOOM codes were the same, UNEQUAL
that they were different ( CAPS preferred ), CAPS MISSING : we had only
the Ganzeboom proposal and kept it.

| Var1           |  Freq |
|:---------------|------:|
| CAPS missing   |  7776 |
| EQUAL          | 15458 |
| IPUMS Military |   802 |
| Low resolution |   778 |
| supervisors    |   580 |
| UNEQUAL        |  6279 |

The tables below describe the exposure status of the CANBJEM population
( jobs held by subjects ): potentially exposed if occupation has a
probability of exposure \>=5%, unexposed if p\<5%, and “unknown” in case
of no relevant CANJEM cell.

**COBALT**

| canjem.status.cobalt |  Freq |
|:---------------------|------:|
| pot.exposed          |  1644 |
| unexposed            | 28641 |
| unknown              |  1388 |

**ANTIMONY**

| canjem.status.antimony |  Freq |
|:-----------------------|------:|
| pot.exposed            |  1146 |
| unexposed              | 29139 |
| unknown                |  1388 |

**TUNGSTEN**

| canjem.status.tungsten |  Freq |
|:-----------------------|------:|
| pot.exposed            |   758 |
| unexposed              | 29527 |
| unknown                |  1388 |
