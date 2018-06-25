Installing R and RStudio
------------------------

First, install R and RStudio:

1.  Download and install the [R](http://www.r-project.org) statistical
    computing and graphing environment. This works cross-platform on
    Windows, OS X and Linux operating systems.

2.  Download and install the free, open source edition of the [RStudio
    Desktop](https://www.rstudio.com/products/rstudio/download/)
    integrated development environment (IDE), which we recommend. This
    is basically a point-and-click interface for R that includes a text
    editor, file browser, and some other conveniences.

Installing the required packages
--------------------------------

The following packages are used in this primer:

1.  [rmarkdown](http://cran.r-project.org/web/packages/rmarkdown/index.html)
    (creating reports)
2.  [agricolae](http://cran.r-project.org/web/packages/agricolae/index.html)
    (agricultural disease data analysis)
3.  [ggplot2](http://cran.r-project.org/web/packages/ggplot2/index.html)
    (graphs)
4.  [poppr](http://cran.r-project.org/web/packages/poppr/index.html)
    (genetic data analysis)
5.  [dplyr](http://cran.r-project.org/web/packages/dplyr/index.html)
    (data manipulation)
6.  [tidyr](http://cran.r-project.org/web/packages/tidyr/index.html)
    (data manipulation)

To install these packages, open RStudio and copy and paste the following
code into the console:

    my_packages <- c("rmarkdown","poppr", "agricolae", "dplyr", "tidyr", "ggplot2")
    install.packages(my_packages, repos = "http://cran.rstudio.com", dependencies = TRUE)

Congratulations! You should now be all set for using R.

### Optional software: PDFs with LaTeX

If you want to create PDF documents, you will need a
[$\\LaTeX$](https://latex-project.org/) installation. For OSX and Ubuntu
users, this can be a large download and you will want to ensure you have
a good connection:

-   [LaTeX for OSX](https://tug.org/mactex/)
-   [LaTeX for Windows](http://miktex.org/)
-   [LaTeX for Ubuntu](https://help.ubuntu.com/community/LaTeX)

To those that know of and fear LaTeX: don't worry, you don't need to
write any LaTeX code to produce PDFs from Markdown.

### Git

Git is a version control program that we will cover, but since
installation requirements can vary between operating systems, we are not
requiring it for the workshop. However, if you would like to install it,
[Here's a website that covers installation for the major operating
systems](http://happygitwithr.com/install-git.html).

A quick introduction to R using RStudio
---------------------------------------

Let's review some of the basic features and functions of R. To start R,
open the RStudio application from your programs folder or start menu.
This will initialize your R session. To exit R, simply close the RStudio
application.

> Note that R is a case-sensitive language!

Let's get comfortable with R by submitting the following command on the
console (where R prompts you with a `>` in the lower left RStudio window
pane) that will tell you something about your version of R and the
packages you have, which is useful for reporting reproducible research.

    sessionInfo() # This command will tell you information about your current R session

    ## R version 3.3.2 (2016-10-31)
    ## Platform: x86_64-apple-darwin13.4.0 (64-bit)
    ## Running under: OS X Yosemite 10.10.5
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] rmarkdown_1.5   knitr_1.17      leaflet_1.1.0   ggmap_2.6.1    
    ## [5] ggplot2_2.2.1   googleVis_0.6.2
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.14      highr_0.6         plyr_1.8.4       
    ##  [4] tools_3.3.2       digest_0.6.12     jsonlite_1.5     
    ##  [7] evaluate_0.10.1   tibble_1.3.3      gtable_0.2.0     
    ## [10] lattice_0.20-34   png_0.1-7         rlang_0.2.0      
    ## [13] shiny_1.0.3       mapproj_1.2-4     crosstalk_1.0.0  
    ## [16] yaml_2.1.14       proto_1.0.0       stringr_1.2.0    
    ## [19] htmlwidgets_0.8   RgoogleMaps_1.4.1 maps_3.1.1       
    ## [22] rprojroot_1.2     grid_3.3.2        R6_2.2.2         
    ## [25] jpeg_0.1-8        sp_1.2-4          reshape2_1.4.2   
    ## [28] magrittr_1.5      backports_1.0.5   scales_0.4.1     
    ## [31] codetools_0.2-15  htmltools_0.3.6   rsconnect_0.7    
    ## [34] xtable_1.8-2      mime_0.5          colorspace_1.3-2 
    ## [37] geosphere_1.5-5   httpuv_1.3.3      stringi_1.1.5    
    ## [40] lazyeval_0.2.0    munsell_0.4.3     rjson_0.2.15

> Note that any text after a '\#' symbol is a comment and does not
> affect the code execution; you can just type `getwd()` after the
> "&gt;".

Packages and getting help
-------------------------

One way that R shines above other languages is that R packages in CRAN
are all documented and easy to install. Help files are written in HTML
and give the user a brief overview of:

-   the purpose of a function
-   the parameters it takes
-   the output it yields
-   examples demonstrating its usage

To get help on any R function, type a question mark before the empty
function. Here's an example of how to get help about the `gather()`
function from the *tidyr* package:

    library('tidyr') # The package with the gather() function.
    ?gather          # open the R documentation of the function gather()

If you want to run the examples, you can either copy and paste the
commands to your R console, or you can run them all with:

    example("gather", package = "tidyr")

Other ways of getting help:

    help(package = "tidyr")  # Get help for a package.
    help("gather")           # Get help for the gather function
    ?gather                  # same as above
    ??multilocus             # Search for help that has the keyword 'multilocus' in all packages

Some packages include vignettes that can have different formats such as
being introductions, tutorials, or reference cards in PDF format. You
can look at a list of vignettes in all packages by typing:

    browseVignettes()                     # see vignettes from all packages
    browseVignettes(package = 'poppr')    # see vignettes from a specific package.

and to look at a specific vignette you can type:

    vignette('mlg')
