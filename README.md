STAT 545A Homework #6
By Amanda Yuen

How to replicate my analysis.

* Start with an empty directory.
* Download the following files.
  - Input data: [`gapminderDataFiveYear.txt`](https://raw.github.com/amandammor/STAT545A-Homework-6/master/gapminderDataFiveYear.txt)
  - R scripts: [`01_reordersortorigdata.R`](https://raw.github.com/amandammor/STAT545A-Homework-6/master/01_reordersortorigdata.R) and [`02_linregressnewdata.R`](https://raw.github.com/amandammor/STAT545A-Homework-6/master/02_linregressnewdata.R)
  - Master script: [`makefile.R`](https://raw.github.com/amandammor/STAT545A-Homework-6/master/makefile.R)
* Start a new RStudio session and open makefile.R.
* After successfully running the pipeline, the following files should be created:
  - [`gapminderDataBestWorst.txt`](https://raw.github.com/amandammor/STAT545A-Homework-6/master/gapminderDataBestWorst.txt)
  - [`gapminderDataBestWorstCoefs.txt`](https://raw.github.com/amandammor/STAT545A-Homework-6/master/gapminderDataBestWorstCoefs.txt)
  - [`gapminderDataReorderedCont.txt`](https://raw.github.com/amandammor/STAT545A-Homework-6/master/gapminderDataReorderedCont.txt)
  - [`gapminderDataReorderedContCoefs.txt`](https://raw.github.com/amandammor/STAT545A-Homework-6/master/gapminderDataReorderedContCoefs.txt)
  - [`barplot_meanGDPpercap.png`](https://raw.github.com/amandammor/STAT545A-Homework-6/master/Figures/barplot_meanGDPpercap.png)
  - [`barplot_meanlifeExp.png`](https://raw.github.com/amandammor/STAT545A-Homework-6/master/Figures/barplot_meanlifeExp.png)
  - BestWorstInterceptsAfrica.png
  - BestWorstInterceptsAmericas.png
  - BestWorstInterceptsAsia.png
  - BestWorstInterceptsEurope.png
  - lineplot_meanGDPpercapOverTime.png
  - lineplot_meanlifeExpOverTime.png
  - scatterplot_lifeExpGDPpercap.png
