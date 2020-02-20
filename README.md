# compassanalytics

This package provides a specialized pipeline for the analysis and interpretation of cell-to-cell metabolic heterogeneity based on the single-cell metabolic reaction consistency matrix produced by the [COMPASS algorithm](https://github.com/YosefLab/Compass). This package also includes a suite of expressive utility functions for conducting statistical analyses building thereupon.

Since COMPASS was originally designed for analyzing single-cell RNA-seq data, the presentation of the algorithm assumes a single-cell data set. However, it can also be applied to bulk RNA data. Note only that it is best suited to applications wherein the number of observations (e.g. RNA-seq libraries or microarrays) is large.

## Installation

1. Make sure you have installed [the `devtools` package](https://github.com/r-lib/devtools) from CRAN.
1. Run `devtools::install_github("YosefLab/compassanalytics")`.

You can accomplish both of these steps by running the following R code:

```R
# Install devtools from CRAN.
install.packages("devtools")

# Install compassanalytics from YosefLab.
devtools::install_github("YosefLab/compassanalytics")
```

## Usage

The following tutorial explains how to use `compassanalytics` to explore a small data set included with the package. If you plan on following along, you should first load `compassanalytics` and `tidyverse`:

```R
library(compassanalytics)
library(tidyverse)
```

For documentation and more in-depth examples, please refer to [the wiki](https://github.com/YosefLab/compassanalytics/wiki).

### Loading your data

In order to make use of the `compassanalytics` package, you first have to specify a few settings in a `CompassSettings` object. Here's an example, tailored to a basic analysis of the included Th17 cell data:

```R
compass_settings <- CompassSettings$new(
    metabolic_model_directory = system.file("extdata", "RECON2", package = "compassanalytics"),
        gene_metadata_file = "gene_metadata.csv",
        metabolite_metadata_file = "metabolite_metadata.csv",
        reaction_metadata_file = "reaction_metadata.csv",
    user_data_directory = system.file("extdata", "Th17", package = "compassanalytics"),
        cell_metadata_file = "cell_metadata.csv", # 
        reaction_consistencies_file = "reactions.tsv", # The output of the COMPASS
        linear_gene_expression_matrix_file = "linear_gene_expression_matrix.tsv",
    cell_id_col_name = "cell_id",
    gene_id_col_name = "HGNC.symbol"
)
```

The next step is to create a `CompassData` object, like so:

```R
compass_data <- CompassData$new(compass_settings)
```

Upon instantiation, it will postprocess the results of the COMPASS algorithm and populate these tables:

* `compass_data$reaction_consistencies`: A data frame of per-cell reaction consistencies.
* `compass_data$metareaction_consistencies`: A data frame of per-cell metareaction consistencies.
* `compass_data$gene_expression_statistics`: A data frame describing the total expression, metabolic expression, and metabolic activity of each cell.
* `compass_data$cell_metadata`: A tibble containing cell metadata specific to the Th17 data set.
* `compass_data$gene_metadata`: A tibble containing gene metadata specific to the RECON2 metabolic model.
* `compass_data$metabolite_metadata`: A tibble containing metabolite metadata specific to the RECON2 metabolic model.
* `compass_data$reaction_metadata`: A tibble containing reaction metadata specific to the RECON2 metabolic model.
* `compass_data$reaction_partitions`: A tibble grouping similar reactions into metareactions.

### Exploring the statistical analysis suite

To conduct statistical analyses on the aforementioned data, make a `CompassAnalyzer` object:

```R
compass_analyzer <- CompassAnalyzer$new(compass_settings)
```

#### Making a UMAP plot

This code will generate a few UMAP plots, wherein each datum is a cell whose coordinates are a low-dimensional embedding of its consistencies with each of the metareactions in `compass_data$metareaction_consistencies`.

```R
cell_info_with_umap_components <-
    compass_analyzer$get_umap_components(
        compass_data$metareaction_consistencies
    ) %>%
    inner_join(
        compass_data$cell_metadata,
        by = "cell_id"
    ) %>%
    left_join(
        t(compass_data$gene_expression_statistics) %>% as_tibble(rownames = "cell_id"),
        by = "cell_id"
    )

ggplot(
    cell_info_with_umap_components,
    aes(x = component_1, y = component_2, color = cell_type)
) +
scale_color_discrete(guide = FALSE) +
geom_point(size = 1, alpha = 0.8) +
theme_bw()

ggplot(
    cell_info_with_umap_components,
    aes(x = component_1, y = component_2, color = metabolic_activity)
) +
scale_color_viridis_c() +
geom_point(size = 1, alpha = 0.8) +
theme_bw()
```

#### Conducting a Wilcoxon test

Meanwhile, this code will tell us whether each metareaction in `compass_data$metareaction_consistencies` is more consistent in cells with below-average overall metabolic activity or cells with above-average overall metabolic activity.

```R
cell_ids_with_gene_expression_statistics <-
    compass_data$gene_expression_statistics %>%
    t() %>%
    as_tibble(rownames = "cell_id")
group_A_cell_ids <-
    cell_ids_with_gene_expression_statistics %>%
    filter(metabolic_activity <= mean(metabolic_activity, na.rm = TRUE)) %>%
    pull(cell_id)
group_B_cell_ids <-
    cell_ids_with_gene_expression_statistics %>%
    filter(metabolic_activity > mean(metabolic_activity, na.rm = TRUE)) %>%
    pull(cell_id)
wilcoxon_results <- compass_analyzer$conduct_wilcoxon_test(
    compass_data$metareaction_consistencies,
    group_A_cell_ids,
    group_B_cell_ids
)
```
