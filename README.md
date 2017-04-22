# SubReddit Mapping

Notebooks and data associated to constructing and exploring a map of subreddits.

To acquire the base data either run the queries from ``BigQuery_queries.sql`` in Google BigQuery, or extract the data from ``subreddit-overlap.archive.bz2``.

Once you have the data you can run any of the jupyter notebooks here, although several libraries may be required.

**The primary notebook is ``Subreddit Mapping and Analysis.ipynb``.** Other notebooks provide supplementary material on alternative approaches that were tried.

### Required libraries and binaries

You will likely need:

* jupyter
* numpy
* scipy
* pandas
* scikit-learn
* hdbscan
* bokeh
* matplotlib
* adjustText
* LargeVis

most of these can be acquired by using the [Anaconda python distribution](https://www.continuum.io/downloads). The ``hdbscan`` library can be conda installed from the conda-forge channel. The ``adjustText`` library can be pip installed from PyPI. The ``LargeVis`` binary needs to be [collected from github](https://github.com/lferry007/LargeVis) and compiled.
