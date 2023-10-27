# Project name: Exploring Disciplinary Differences in Software Mentions

![project-banner](images/project-banner.png?raw=true)

[Project description](https://docs.google.com/document/d/1TTeVDYmjcoCHfSzhFvliGrLMQyEB2yHYSQcjMf-OeY4/edit#heading=h.mfizjlrp1stl)

[Project slides](https://docs.google.com/presentation/d/13017RbDyiGoYOnzUuk5S4F_uG5ZE-fdi2WCbAi2ItLU/edit?usp=sharing)


## Methodology

We conduct scientometric analysis of publications mentioning software to match software mentions with papers, authors, and disciplines.

### Datasets
- CZI mentions dataset (1.7 million PubMed IDs)
- [OpenAlex] (https://openalex.org/)
- [SoftwareKG] (https://zenodo.org/records/3715147)

### Software/Tools
- Google BigQuery (InSySPo project - Brazil)
- Databricks
- VOSviewer
- R
- Python

### Data collection
Match CZI software mentions and SoftwareKG mentions with OpenAlex publications (DOI, PMCID)

## Findings

### Top softwares per discipline

![top softwares per discipline](images/top_software_per_discipline.png?raw=true)

### Software mentions per discipline across time

![software mentions across disciplines across time](images/top_software_across_time.png?raw=true)

### Software mention networks

#### Using the CZI dataset (1.7 million publications)

![software network mentions in CZI dataset](images/network1.png?raw=true)

#### Using the KG dataset

![software network mentions in KG dataset](images/network3.png?raw=true)

#### Software network differences across contrasting disciplines

![software mention networks comparison](images/network4.png?raw=true)

## Future work

![future1](images/10k_paper_software_citation_bar.png?raw=true)

![future2](images/10k_sample_paper_software_citation_scatter.png?raw=true)


## Contributers

- Alexy Khrabrov
- Fuqi Xu
- Shahan Ali Memon
- Rodrigo Costas
- Huimin Xu
- Puyu Yang
- Frank Krüger