## examples from bottom 

# EXTRA

```{r}
#| echo: true
#| include: true
#| label: grade52
#| warning: false
#| message: false

grades <- nplot(
  net_with_no_isolates,
  vertex.color = color_nodes(net_with_no_isolates, "grade", c("gray40","red3")),
  vertex.nsides = ifelse(V(net_with_no_isolates)$grade == 7, 10, 3),
  vertex.size.range = c(0.015, 0.2),
  edge.color = ~ego(alpha = 1, col = "lightgray") + alter(alpha = 0.25, col = "lightgray"),
  vertex.label = NULL,
  edge.curvature = pi/6,
  edge.line.breaks = 10  
)  

# add radial gradient fill 
grades <- set_vertex_gpar(grades, 
                          element = "core",
                          fill = lapply(get_vertex_gpar(grades, "frame", "col")$col, \(i) {
                            radialGradient(c("white", i), cx1=.8, cy1=.8, r1=0)
                          }))

# add legend to graph
grades_general <- nplot_legend(
  grades,
  labels = c("7th", "8th"),
  pch = c(21,21),
  gp = gpar(
    fill = c("gray40","red3")),
  packgrob.args = list(side = "bottom"),
  ncol = 2  
)


grades_general
grid.text("Split According to Grade", x = .2, y = .87, just = "bottom") 
```


#### Split according to Gender
Next, the data will be split according to gender, with male being yellow and female being green. Also, the male points are circles, while the female points are diamonds. 
```{r}
#| echo: true
#| include: true
#| label: gender
#| warning: false
#| message: false

# let's get a graph for the gender data
V(net_with_no_isolates)$gender <-  as.factor(V(net_with_no_isolates)$gender)

a_colors <- color_nodes(net_with_no_isolates,"gender", c("lightgoldenrod2","forestgreen"))
attr(a_colors, "map")

## plot
set.seed(77)
gender <- nplot(
  net_with_no_isolates,
  vertex.color = color_nodes(net_with_no_isolates, "gender",c("lightgoldenrod2","forestgreen")),
  vertex.nsides = ifelse(V(net_with_no_isolates)$gender == 0, 10, 4),
  vertex.size.range = c(0.01, 0.01),
  edge.color = ~ego(alpha = 0.33, col = "gray") + alter(alpha = 0.33, col = "gray"),
  vertex.label = NULL,
  edge.line.breaks = 10
)

# add legend to graph
nplot_legend(
  gender,
  labels = c("Male", "Female"),
  pch = c(21,23),
  gp = gpar(
    fill = c("lightgoldenrod2","forestgreen")),
  packgrob.args = list(side = "bottom"),
  ncol = 2
)

grid.text("Split According to Gender", x = .2, y = .87, just = "bottom") 
```


#### Split according to Lunch Period
Here is the data split according to the different lunch periods students might be in. 
```{r}
#| echo: true
#| include: true
#| label: lunch
#| warning: false
#| message: false
#| cache: true


# now let's do the same with lunch period 
V(net_with_no_isolates)$lunch <-  as.factor(V(net_with_no_isolates)$lunch)

a_colors <- color_nodes(net_with_no_isolates,"lunch", c("purple","palegreen","steelblue"))
attr(a_colors, "map")

## plot
set.seed(77)
lunch <- nplot(
  net_with_no_isolates,
  vertex.color = color_nodes(net_with_no_isolates, "lunch",c("purple","palegreen","steelblue")),
  vertex.nsides = 
    ifelse(V(net_with_no_isolates)$gender == 0, 4,   # First Lunch
           ifelse(V(net_with_no_isolates)$gender == 1, 3,  # Second Lunch 
                  10)),                                 # Other
  vertex.size.range = c(0.01, 0.01),
  edge.color = ~ego(alpha = 0.33, col = "gray") + alter(alpha = 0.33, col = "gray"),
  vertex.label = NULL,
  edge.line.breaks = 10
)

# add legend to graph
nplot_legend(
  lunch,
  labels = c("First", "Second", "Other"),
  pch = c(23,24,21),
  gp = gpar(
    fill = c("purple","palegreen","steelblue")),
  packgrob.args = list(side = "bottom"),
  ncol = 3
)

grid.text("Split According to Lunch Period", x = .2, y = .87, just = "bottom") 
```


#### Changing Lines to Dashes 
One of the perks of `netplot` is the ability to be fully customizable, right out of the box. First, here is an example of the same dataset, but the edges are dashed instead of full and straight instead of curved. 

```{R}
#| echo: true
#| include: true
#| label: dashes
#| warning: false
#| message: false
#| cache: true

set.seed(77)

grades <- nplot(
  net_with_no_isolates,
  bg.col = "#F5F5F5",
  vertex.color = color_nodes(net_with_no_isolates, "grade", c("red","blue")),
  vertex.size.range = c(0.02, 0.02),
  edge.color = ~ego(alpha = .15, col = "black") + alter(alpha = .15, col = "black"),
  vertex.label = NULL,
  edge.width.range = c(2,2),
  edge.line.lty = 6,
  edge.line.breaks = 1  
)  



# add legend to graph
grades_dashed <- nplot_legend(
  grades,
  labels = c("7th", "8th"),
  pch = c(21,21),
  gp = gpar(
    fill = c("red","blue")),
  packgrob.args = list(side = "bottom"),
  ncol = 2  
)

grades_dashed
```


### Colored Edges and Skipped Vertices

This selection shows how to skip vertices and add colors to the edges.
```{R}
#| echo: true
#| include: true
#| label: skipped
#| warning: false
#| message: false
#| cache: true

set.seed(77)   

grades <- nplot(
  net_with_no_isolates,
  bg.col = "#F5F5F5",
  vertex.color = color_nodes(net_with_no_isolates, "grade", c("red","blue")),
  vertex.nsides = ifelse(V(net_with_no_isolates)$grade == 7, 10, 4),
  vertex.size.range = c(0.0001, 0.0001),
  edge.color = ~ego(alpha = 0.33) + alter(alpha = 0.33),
  vertex.label = NULL,
  edge.width.range = c(2,2),
  edge.line.breaks = 10
)  

# add legend to graph
grades_edge_colored <- nplot_legend(
  grades,
  labels = c("7th", "8th"),
  pch = c(21,21),
  gp = gpar(
    fill = c("red","blue")),
  packgrob.args = list(side = "bottom"),
  ncol = 2
)

grades_edge_colored
```

### Changing Background Color

We can also add a background to the plot, including a gradient.
```{R}
#| echo: true
#| include: true
#| label: background
#| warning: false
#| message: false
#| cache: true

set.seed(77)   

grades <- nplot(
  net_with_no_isolates,
  bg.col = linearGradient(c("lightpink", "lightskyblue")),
  vertex.color = color_nodes(net_with_no_isolates, "grade", c("red","blue")),
  vertex.nsides = ifelse(V(net_with_no_isolates)$grade == 7, 10, 4),
  vertex.size.range = c(0.01, 0.01),
  edge.color = ~ego(alpha = 0.15, col = "black") + alter(alpha = 0.15, col = "black"),
  vertex.label = NULL,
  edge.line.breaks = 10  
)  

# add legend to graph
grades_background <- nplot_legend(
  grades,
  labels = c("7th", "8th"),
  pch = c(21,23),
  gp = gpar(
    fill = c("red","blue")),
  packgrob.args = list(side = "bottom"),
  ncol = 2  
)

grades_background
```


### Different Colors 

We can also change vertex colors and edges to straight lines. 
```{R}
#| echo: true
#| include: true
#| label: colors
#| warning: false
#| message: false
#| cache: true

set.seed(77)

grades <- nplot(
  net_with_no_isolates,
  bg.col = "#F5F5F5",
  vertex.color = color_nodes(net_with_no_isolates, "grade", c("#FFDB58","#708090")),
  vertex.nsides = ifelse(V(net_with_no_isolates)$grade == 7, 10, 4),
  vertex.size.range = c(0.02, 0.02),
  edge.color = ~ego(alpha = .15, col = "black") + alter(alpha = .15, col = "black"),
  vertex.label = NULL,
  edge.width.range = c(2,2),
  edge.line.breaks = 1
)

# add legend to graph
grades_different_color <- nplot_legend(
  grades,
  labels = c("7th", "8th"),
  pch = c(21,23),
  gp = gpar(
    fill = c("#FFDB58","#708090")),
  packgrob.args = list(side = "bottom"),
  ncol = 2  
)

grades_different_color
```


### Example 2: LTCF data

```{r}
#| echo: true
#| include: true
#| label: packages2
#| warning: false
#| message: false
#| cache: true

# loading packages
library(network)
library(netplot)  

# loading data 
load("./data/nursing_home/network99_f1.RData")  
```

Create for-loop:
  ```{r}
#| echo: true
#| include: true
#| label: for_loop_prereqs
#| warning: false
#| message: false
#| cache: true

# Creates an empty list to store the networks
nets <- list()  

# Sets a seed for reproducibility 
set.seed(1231)  

for (i in 1:99) { 
  # Checks if the vertex "is_actor" exists in the network
  is_health_care_provider <- networks[[i]] %v% "is_actor"  
  nets[[i]] <- nplot( networks[[i]], 
                      # Colors the vertices gray if HCP exists, red otherwise
                      vertex.color     = ifelse(is_health_care_provider, "gray40", "red3"),  
                      # Makes vertices square if HCP exists, round otherwise
                      vertex.nsides    = ifelse(is_health_care_provider == TRUE, 4, 10),
                      # Makes HCP vertices larger than patient vertices
                      vertex.size      = ifelse(is_health_care_provider == TRUE, .25, .15),
                      vertex.size.range = c(.015,.065),
                      edge.width.range = c(.25,.5),
                      # Sets edge line breaks to 1 and colors edges black  
                      edge.line.breaks = 1, edge.color = ~ ego(alpha = 1, col = "lightgray") +    alter(alpha = 1, col = "lightgray"),
                      edge.curvature = pi/6,
                      # Removes vertex labels
                      vertex.label     = NULL )
}

# Combines the 99 plots into an 11x9 grid
allgraphs <- gridExtra::grid.arrange(grobs = nets, nrow=11, ncol=9) 
```


