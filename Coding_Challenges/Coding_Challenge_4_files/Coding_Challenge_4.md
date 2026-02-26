---
title: "Coding Challenge 4"
author: "Doug Terza"
date: "2026-02-19"
output:
  html_document:
    toc: true          
    toc_depth: 3       
    toc_float: true    
  md_document:
    variant: gfm
  word_document:
  pdf_document:
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Question 1
a. The YAML header provides
b. 


# Question 2
[i.	Noel, Z.A., Roze, L.V., Breunig, M., Trail, F. 2022. Endophytic fungi as promising biocontrol agent to protect wheat from Fusarium graminearum head blight. Plant Disease.](https://doi.org/10.1094/PDIS-06-21-1253-RE)

# Question 3


```{r}
toxin.box8<-ggarrange((toxin.box4+
  geom_pwc(aes(group = Treatment), method = "t_test", label = "{p.adj.format}{p.adj.signif}")),
  toxin.box5+
  geom_pwc(aes(group = Treatment), method = "t_test", label = "{p.adj.format}{p.adj.signif}"),
  toxin.box6+
  geom_pwc(aes(group = Treatment), method = "t_test", label = "{p.adj.format}{p.adj.signif}"),
  labels = "auto",
  nrow = 1,
  ncol = 3,
  common.legend = TRUE)
toxin.box8
```

