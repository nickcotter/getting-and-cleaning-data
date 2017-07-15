require("knitr")

knitr::spin("run_analysis.R")
file.rename("run_analysis.md", "Codebook.md")
file.remove("run_analysis.html")