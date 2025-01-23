%let pgm=utl-comparison-of-r-sql-language-vs-tidyverse-language-for-simple-statistical-operations;

Comparison of r sql language vs tidyverse language for simple statistical operations

github
https://tinyurl.com/ywbrc9zb
https://github.com/rogerjdeangelis/utl-comparison-of-r-sql-language-vs-tidyverse-language-for-simple-statistical-operations

stackoverflow
https://tinyurl.com/ymu776ft
https://stackoverflow.com/questions/79378851/mutating-to-return-the-average-of-a-column-in-each-row

    COMPUTE THE AVERAGES FOR COLUMNS

        1 r tidyverse language and r only syntax?

          mutate
          across(everything()
          summarize
          starts_with

          ~mean
          na.rm=TRUE (not needed in sqldf)

          SOAPBOX ON
            Do not use tidyverse, 'across(everything()', function in production?

            Maybe better spending time learning sql
            and the tidyverse graphics, time series .. components
            than tidyverse  data wrangling

          SOAPBOX OFF

        2 r sqldf
          (same code works in sas, r, python, excel and most databases)
          (no need for na.rm-TRUE, its the default in sqldf)

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                                |                                       |                                               */
/*        INPUT                   |            PROCESS                    |       OUTPUT (COLUMN AVERAGES)                */
/*        =====                   |            =======                    |       ========================                */
/*                                |                                       |                                               */
/* F_A    F_O    F_B              |   1 SQL R,PYTHON,SAS AND EXCEL        |   F_A    F_O    F_B                           */
/*                                |   ============================        |                                               */
/*  1      2      5               |                                       |   2.5*    4      4                            */
/*  4      6      3               |     select                            |                                               */
/*                                |        avg(F_A) as avg_f_a            |   * 2.5 = (1+4)/2                             */
/* options                        |       ,avg(F_O) as avg_f_o            |                                               */
/*  validvarname=upcase;          |       ,avg(F_B) as avg_f_b            |                                               */
/* libname sd1 "d:/sd1";          |     from                              |                                               */
/* data sd1.have;                 |       have                            |                                               */
/* input                          |                                       |                                               */
/*   F_A F_O F_B;                 |    2 r tidyverse                      |                                               */
/* cards;                         |    =============                      |                                               */
/* 1 2 5                          |                                       |                                               */
/* 4 6 3                          |     mutate(across(everything()        |                                               */
/* ;;;;                           |      ,as.numeric)) %>%                |                                               */
/* run;quit;                      |     summarize(across(starts_with("F") |                                               */
/*                                |      , ~mean(.x, na.rm = TRUE)))      |                                               */
/*                                |                                       |                                               */
/**************************************************************************************************************************/

/*          _   _     _                                _
/ |  _ __  | |_(_) __| |_   ___   _____ _ __ ___  ___ | | __ _ _ __   __ _ _   _  __ _  __ _  ___
| | | `__| | __| |/ _` | | | \ \ / / _ \ `__/ __|/ _ \| |/ _` | `_ \ / _` | | | |/ _` |/ _` |/ _ \
| | | |    | |_| | (_| | |_| |\ V /  __/ |  \__ \  __/| | (_| | | | | (_| | |_| | (_| | (_| |  __/
|_| |_|     \__|_|\__,_|\__, | \_/ \___|_|  |___/\___||_|\__,_|_| |_|\__, |\__,_|\__,_|\__, |\___|
                        |___/                                        |___/             |___/
*/

%utl_rbeginx;
parmcards4;
library(haven)
library(tidyverse)
source("c:/oto/fn_tosas9x.R")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
want<-have %>%
mutate(across(everything()
  ,as.numeric)) %>%
summarize(across(starts_with("F")
  , ~mean(.x, na.rm = TRUE)))
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
test
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/*                      |                                                                                                 */
/* R                    | SAS                                                                                             */
/*                      |                                                                                                 */
/*     F_A   F_O   F_B  |  ROWNAMES    F_A    F_O    F_B                                                                  */
/*     2.5     4     4  |      1       2.5      4      4                                                                  */                            */
/*                      |                                                                                                 */
/**************************************************************************************************************************/

/*___                     _
|___ \   _ __   ___  __ _| |
  __) | | `__| / __|/ _` | |
 / __/  | |    \__ \ (_| | |
|_____| |_|    |___/\__, |_|
                       |_|
*/

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
have<-read_sas(
 "d:/sd1/have.sas7bdat")
print(have)
want<-sqldf('
   select
      avg(F_A) as avg_f_a
     ,avg(F_O) as avg_f_o
     ,avg(F_B) as avg_f_b
  from
     have
  ');
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
test
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/*                      |                                                                                                 */
/* R                    | SAS                                                                                             */
/*                      |                                                                                                 */
/*     F_A   F_O   F_B  |  ROWNAMES    F_A    F_O    F_B                                                                  */
/*     2.5     4     4  |      1       2.5      4      4                                                                  */                            */
/*                      |                                                                                                 */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
