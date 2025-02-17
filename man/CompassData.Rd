% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CompassData.R
\name{CompassData}
\alias{CompassData}
\title{CompassData}
\description{
An object through which you can access several useful tables for your COMPASS analysis.
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{settings}}{The CompassSettings instance specifying the settings for this CompassData instance.}

\item{\code{reaction_consistencies}}{Each row is a reaction and each column is a cell. reaction_consistencies[i, j] is the consitency (or "compatibility") between reaction i and cell j.}

\item{\code{metareaction_consistencies}}{Each row is a metareaction and each column is a cell. metareaction_consistencies[i, j] is the consistency (or "compatibility") between metareaction i and cell j.}

\item{\code{metabolic_genes}}{Each row describes a gene in terms of its ID and whether it's a metabolic gene.}

\item{\code{gene_expression_statistics}}{Each row describes a cell in terms of its ID, total expression, metabolic expression, and metabolic activity.}

\item{\code{cell_metadata}}{The cell metadata from cell_metadata.csv. In this example it's the Th17 cell data from the papers linked above.}

\item{\code{gene_metadata}}{The gene metadata from the metabolic model (RECON2, by default).}

\item{\code{metabolite_metadata}}{The metabolite metadata from the metabolic model (RECON2, by default).}

\item{\code{reaction_metadata}}{The reaction metadata from the metabolic model (RECON2, by default).}

\item{\code{reaction_partitions}}{Each row describes a reaction in terms of its ID, undirected ID, direction, and metareaction ID.}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-new}{\code{CompassData$new()}}
\item \href{#method-print}{\code{CompassData$print()}}
\item \href{#method-repr}{\code{CompassData$repr()}}
\item \href{#method-clone}{\code{CompassData$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\subsection{Method \code{new()}}{
Initialize the CompassSettings instance. Postprocess COMPASS data and populate tables.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{CompassData$new(settings)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{settings}}{The CompassSettings instance specifying the settings for this CompassData instance.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
NULL.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-print"></a>}}
\subsection{Method \code{print()}}{
Prints a human-readable representation of this CompassData instance.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{CompassData$print(...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{Unused.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
NULL.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-repr"></a>}}
\subsection{Method \code{repr()}}{
Returns a human-readable representation of this CompassData instance.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{CompassData$repr(...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{...}}{Unused.}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
An output.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{CompassData$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
