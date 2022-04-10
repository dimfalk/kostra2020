## Contributing to kostra2010R

The goal of this guide is to help you contribute to kostra2010R as quickly and as easily possible. 
Moreover, this also remains a reminder and collection of useful hints when contributing myself. 

The guide is divided into two main parts:

1. Filing a bug report or feature request in an issue.
1. Suggesting a change via a pull request.

For more information about contributing, please check the following ressources

* Egghead: [**How to Contribute to an Open Source Project on GitHub**](https://app.egghead.io/playlists/how-to-contribute-to-an-open-source-project-on-github)
* Tidyverse: [**Contribute to the tidyverse**](https://rstd.io/tidy-contrib)
* Tidyverse: [**Contribute code to the tidyverse**](https://www.tidyverse.org/blog/2017/08/contributing/)

## Issues

Before you file an issue:

1.  Check that you're using the latest version of kostra2010R. It's quite possible that the problem you're experiencing has already been fixed.

1.  Spend a few minutes looking at the existing issues. It's possible that your issue has already been filed.
    It's generally a bad idea to comment on a closed issue or a commit. 
    Those comments don't show up in the issue tracker and are easily misplaced.

When filing an issue, the most important thing is to include a minimal reproducible example so that the problem can be quickly verified in order to figure out how to fix it.
There are three things you need to include to make your example reproducible: required packages, data, code.

1.  **Packages** should be loaded at the top of the script, so it's easy to see which ones the example needs. 
    Unless you've been specifically asked for it, please don't include the output of `sessionInfo()` or `devtools::session_info()`.

1.  The easiest way to include **data** is to use `dput()` to generate the R code to recreate it. 
    But even better is if you can create a `data.frame()` with just a handful of rows and columns that still illustrates the problem.

1.  Spend a little bit of time ensuring that your **code** is easy for others to read:
  
    * Make sure you've used spaces and your variable names are concise, but informative
  
    * Use comments to indicate where your problem lies
  
    * Do your best to remove everything that is not related to the problem. The shorter your code is, the easier it is to understand.
     
    Learn a little [markdown](https://help.github.com/articles/basic-writing-and-formatting-syntax/) so you can correctly format your issue.
    
1.  Check that you've actually made a reproducible example by using [reprex](https://www.tidyverse.org/help/#reprex).

## Pull requests

*   Fork the package and clone it onto your computer. If you haven't done this before, we recommend using `usethis::create_from_github("falk-env/kostra2010R", fork = TRUE)`.

*   Install all development dependences with `devtools::install_dev_deps()`, and then make sure the package passes R CMD check by running `devtools::check()`. 
    If R CMD check doesn't pass cleanly, it's a good idea to ask for help before continuing. 

*   Create a Git branch for your pull request (PR). We recommend using `usethis::pr_init("brief-description-of-change")`.

*   Make your changes, commit to git, and then create a PR by running `usethis::pr_push()`, following the prompts in your browser.
    The title of your PR should briefly describe the change.
    The body of your PR should contain `fixes #issue-number`.

*   You should always add a bullet point to `NEWS.md` motivating the change just below the first header.
    It should look like "This is what changed (@yourusername, #issuenumber)".
    Follow the style described in <https://style.tidyverse.org/news.html>.

*   Your pull request will be easiest to read if you use a common style, c.f. tidyverse [style guide](https://style.tidyverse.org).
    You can use the [styler](https://CRAN.R-project.org/package=styler) package to apply these styles, but please don't restyle code that is not connected to your PR.

*   If you're adding new parameters or a new function, you'll also need to document them with [roxygen2](https://cran.r-project.org/package=roxygen2).
    Make sure to re-run `devtools::document()` on the code before submitting.

*   If you can, also write a unit test using [testthat](https://cran.r-project.org/package=testthat).
    Contributions with test cases included are easier to accept.

