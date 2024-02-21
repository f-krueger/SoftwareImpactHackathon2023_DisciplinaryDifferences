# Project name: Exploring Disciplinary Differences in Software Mentions

![project-banner](images/project-banner.png?raw=true)

[Project description](https://docs.google.com/document/d/1TTeVDYmjcoCHfSzhFvliGrLMQyEB2yHYSQcjMf-OeY4/edit#heading=h.mfizjlrp1stl)

[Project slides](https://docs.google.com/presentation/d/13017RbDyiGoYOnzUuk5S4F_uG5ZE-fdi2WCbAi2ItLU/edit?usp=sharing)

This project was part of the Chan Zuckerberg Initiative on "Mapping the Impact of Research Software in Science". In this project, we are interested in studying the following questions:

- What is the distribution of publications mentioning (or not) software across disciplines?
- How is different software used by researchers across their publications?
- What is the ‘proximity’ of scientific publications to the use of software? (ongoing)


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

### Software name disambiguation in CZI dataset
There were software names in the CZI dataset that were not disambiguated. We used fuzzy matching to identify the "similar" software names to merge them before plotting our networks.

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

#### Software dependency per domain

![future1](images/10k_paper_software_citation_bar.png?raw=true)

#### Software dependency domain comparison

![future2](images/10k_sample_paper_software_citation_scatter.png?raw=true)


## Contributers

- Alexy Khrabrov
- Frank Krüger
- Fuqi Xu
- Huimin Xu
- Puyu Yang
- Rodrigo Costas
- Shahan Ali Memon

## About this project

This repository was developed as part of the [Mapping the Impact of Research Software in Science](https://github.com/chanzuckerberg/software-impact-hackathon-2023) hackathon hosted by the Chan Zuckerberg Initiative (CZI). By participating in this hackathon, owners of this repository acknowledge the following:
1. The code for this project is hosted by the project contributors in a repository created from a template generated by CZI. The purpose of this template is to help ensure that repositories adhere to the hackathon’s project naming conventions and licensing recommendations.  CZI does not claim any ownership or intellectual property on the outputs of the hackathon. This repository allows the contributing teams to maintain ownership of code after the project, and indicates that the code produced is not a CZI product, and CZI does not assume responsibility for assuring the legality, usability, safety, or security of the code produced.
2. This project is published under a MIT license.

## Code of Conduct

Contributions to this project are subject to CZI’s Contributor Covenant [code of conduct](https://github.com/chanzuckerberg/.github/blob/master/CODE_OF_CONDUCT.md). By participating, contributors are expected to uphold this code of conduct. 

## Reporting Security Issues

If you believe you have found a security issue, please responsibly disclose by contacting the repository owner via the ‘security’ tab above.

