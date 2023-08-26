---
marp: true
title: Introductions
description: Julien Arino - 2023 AARMS Summer School - Introductions
theme: default
paginate: false
math: mathjax
size: 4K
---

<style>
  .theorem {
    text-align:justify;
    background-color:#16a085;
    border-radius:20px;
    padding:10px 20px 10px 20px;
    box-shadow: 0px 1px 5px #999;
  }
  .definition {
    text-align:justify;
    background-color:#ededde;
    border-radius:20px;
    padding:10px 20px 10px 20px;
    box-shadow: 0px 1px 5px #999;
  }
  img[alt~="center"] {
    display: block;
    margin: 0 auto;
  }
</style>

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, white)" -->
# Introductions

25 August 2023 

Julien Arino [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/email-round.png)](mailto:Julien.Arino@umanitoba.ca) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/world-wide-web.png)](https://julien-arino.github.io/) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/github-icon.png)](https://github.com/julien-arino)

Department of Mathematics & Data Science Nexus
University of Manitoba*

<div style = "font-size:18px; margin-top:-10px; padding-bottom:30px;"></div>

Canadian Centre for Disease Modelling
PHAC-EMNID / REMMI-ASPC
NSERC-PHAC EID Modelling Consortium (CANMOD, MfPH, OMNI/RÉUNIS)

<div style = "text-align: justify; position: relative; bottom: -3%; font-size:23px; margin-left:-50px; margin-right:-50px">

![bg width:800px opacity:0.2](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/various/inuit-metis-firstnation.png)

[*](https://umanitoba.ca/indigenous/sites/indigenous/files/2020-09/traditional-territories-acknowledgement-2020.pdf)The University of Manitoba campuses are located on original lands of Anishinaabeg, Cree, Oji-Cree, Dakota and Dene peoples, and on the homeland of the Métis Nation. We respect the Treaties that were made on these territories, we acknowledge the harms and mistakes of the past, and we dedicate ourselves to move forward in partnership with Indigenous communities in a spirit of reconciliation and collaboration.</div>

---

# Foreword

- I have used ChatGPT and GitHub Copilot to generate some of this text
- These tools are *potential* time savers, but they are not perfect (*Copilot* just suggested "but they are not perfect" :smile:), so use them wisely: read the results carefully, and don't be afraid to edit them (again, this was suggested by *Copilot* :smile:)

--- 

<!-- _backgroundImage: "radial-gradient(white,80%,#f1c40f)" -->
# Outline

- Introductions
- Introductions are part of the spatio-temporal spread process
- Modelling introductions

--- 

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit -->Introductions

---

# <!--fit--> Introductions (according to ChatGPT, emphasis and "British-ation" mine)

**Biological introduction**, also known as *biological invasion* or *biological colonisation*, refers to the *intentional* or *unintentional* **introduction** of a **non-native species** into an ecosystem or habitat where they did not previously occur naturally. This introduction can be facilitated by human activities such as trade, travel, and agriculture. These introduced species are often referred to as "invasive species."

---

Invasive species can have negative ecological, economic, and social impacts on the new environment. They can outcompete native species for resources like food and habitat, disrupt natural ecological processes, and even cause extinction or significant decline of native species. In some cases, invasive species can also affect human activities, such as agriculture, by damaging crops or introducing new diseases.

--- 

Biological introductions can **occur through various means**, such as the *release of non-native animals or plants* **intentionally** for purposes like *pest control* or ornamental gardening, or **accidentally** through activities like *shipping* or *transportation*. 

Preventing and managing biological introductions is crucial for maintaining the balance of ecosystems and preserving biodiversity.

---

# Introductions contribute to evolution

- Introductions are often thought of negatively (see previous slide, even ChatGPT thinks so :smile:) because of their impact on human activities (and some are easy to spot for us, e.g. the emerald ash borer, the zebra mussel, the Asian carp, etc.)

- However, from an evolutionary perspective, introductions are a major source of genetic variation. They can lead to the extinction of native species, but also to the emergence of new species.

(We percieve our environment as being at some equilibrium. It is not! It is constantly changing, and introductions are part of this change.)

---

# <!--fit-->Pathogen introductions (continuing with ChatGPT)

Pathogen introduction refers to the process by which a foreign or previously absent microorganism, such as a virus, bacteria, fungus, or other infectious agent, is brought into a new environment or population. This can occur naturally or as a result of human activity. When a pathogen is introduced to a new area or population, it may encounter individuals without immunity to it, potentially leading to outbreaks of disease.

Pathogen introduction can have significant implications for public health, agriculture, and ecosystems. 

---

It can occur through various means, including:

1. **Travel and Trade:** Pathogens can be introduced to new regions through the movement of people, animals, and goods. International travel and trade can facilitate the spread of diseases across geographical boundaries.

2. **Invasive Species:** Pathogens can be carried by invasive species that are introduced to new ecosystems. These pathogens may not have natural predators or controls in the new environment, leading to rapid population growth and disease transmission.

3. **Environmental Changes:** Human activities such as deforestation, urbanization, and climate change can alter ecosystems and create opportunities for pathogens to enter new niches or hosts.

---

4. **Contaminated Goods:** Food, water, and other products that are contaminated with pathogens can introduce diseases to new areas or populations.

5. **Medical Procedures:** Healthcare-associated infections can occur when pathogens are introduced to patients during medical procedures or hospital stays.

6. **Natural Disasters:** Natural disasters like earthquakes, floods, and hurricanes can displace populations, leading to increased vulnerability to disease outbreaks due to overcrowding and unsanitary conditions.

---

7. **Biological Warfare or Bioterrorism:** Deliberate introduction of pathogens by individuals or groups for harmful purposes can also lead to pathogen introduction.

Efforts to prevent and manage pathogen introduction include surveillance, quarantine measures, vaccination campaigns, public health interventions, and policies aimed at regulating the movement of people, animals, and goods. Understanding the factors that contribute to pathogen introduction and its potential consequences is essential for maintaining the health and stability of populations, ecosystems, and economies.

---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit -->Introductions are part of the spatio-temporal spread process

---

# Don't be narrow minded ! Think global !

- Lots of epi work is jurisdiction-centred
- However, except for the site of initial emergence/recombination/whatever made your bug happen, jurisdictions receive pathogens from other jurisdictions where spread is occurring
- E.g., COVID-19 is just one massive realisation of a stochastic process that started somewhere in China (or elsewhere, but let's not go there :smile:) and has been ongoing since then

---

# ODE metapopulations somewhat miss the point

- Pathogen introductions are not automatic
- Introductions are stochastic events
- Like for infection of a person with a pathogen, there can be successful and unsuccessful introductions
- A location where the pathogen is absent is subject to repeated challenges as individuals from infected locations arrive

---

# <!--fit-->Heterogeneity in "lived epidemics" increases <br>at the micro-scale

![center](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/introductions-in-care-homes.png)

<div style = "position: relative; bottom: -13%; font-size:20px; text-align: justify; margin-left:-70px; margin-right:-50px;">

- T. Delory, <ins>JA</ins>, P.-E. Haÿ, V. Klotz & P.-Y. Boëlle. [SARS-CoV-2 in Nursing Homes: Analysis of Routine Surveillance Data in Four European Countries](https://doi.org/10.14336/AD.2022.0820). *Aging and Disease* (2022)
</div>

---

# Why consider introductions?

### ("why did *I* consider introductions?")

<br>

- Canada is a very tolerant society *with* a massive blindspot, that is very obvious when, as I do, you live for instance in downtown Winnipeg
<br>
- City of Winnipeg population, 2021 census: 749,607. Indigenous identity: 90,995 (12.1%)
<br>
- Manitoba population, 2021 census: 1,307,190. Indigenous identity: 237,185 (18.1%)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/transportation/FRA_and_MB_to_scale.png)

---

<!--![bg 85%](cities_roads_FRA.png)-->
![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/transportation/cities_roads_CAN-MB_detail.png)

---

# Isolated communities

- Winnipeg: 749,607, median age 38.8, average household size 2.5

- Red Sucker Lake: 1,000, median age 19, average household size 5.2

---

# Geographies greatly influence reasoning
	
- Country level: importations quickly become less relevant
- Consider an isolated location of 500 people.. disease may become extinct then be reimported

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/sars-cov-2/CT_extent_2020-07-30.png)

---

# <!-- fit -->Transmission within national jurisdictions was heterogeneous

Moving from ISO-3166-3 (nation or territory) level to smaller sub-national jurisdictions, the picture is more contrasted

Next slide: Example of activation of North American health regions/municipios/counties

---

![bg contain 90%](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/sars-cov-2/pct_active_21days_with_pct_activations.png)

---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit --> Modelling introductions

<div style = "position: relative; bottom: -34%; font-size:20px; text-align: justify; margin-left:-70px; margin-right:-50px;">

- <ins>JA</ins>, P.-Y. Boëlle, E.M. Milliken & S. Portet. [Risk of COVID-19 variant importation - How useful are travel control measures?](https://doi.org/10.1016/j.idm.2021.06.006) *Infectious Disease Modelling* (2021)
- S.P Otto, T. Day, <ins>JA</ins>, C. Colijn *et al*. [The origins and potential future of SARS-CoV-2 variants of concern in the evolving COVID-19 pandemic](https://doi.org/10.1016/j.cub.2021.06.049). *Current Biology* (2021)
- Delory, <ins>JA</ins>, Haÿ, Klotz & Boëlle. SARS-CoV-2 in nursing homes: analysis of routine surveillance data in four European countries. *Aging and Infection* (2022)
</div>

---
<div style = "position: relative; top: -55%; padding-bottom:60px; font-size:40px">
The spread process in a jurisdiction-based world
</div>

![bg 95%](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/importation_process3.png)

---

![bg contain 95%](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/flow-diagrams/figure_SLDURM_base_model_with_different_epsilon_and_infectious_compartments.png)

<div style = "position: relative; bottom: -60%; font-size:20px; text-align: justify; margin-left:-60px; margin-right:-50px;">

- JA & Portet. [A simple model for COVID-19](http://dx.doi.org/10.1016/j.idm.2020.04.002). *Infectious Disease Modelling* **5**:309-315 (2020)
</div>

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/figure_variant_importation_base_model_with_stimulations_noQ.png)

<div style = "position: relative; bottom: -60%; font-size:20px; text-align: justify; margin-left:-60px; margin-right:-50px;">

- <ins>JA</ins>, N. Bajeux, S. Portet & J. Watmough. [Quarantine and the risk of COVID-19 importation](http://dx.doi.org/10.1017/S0950268820002988). *Epidemiology & Infection* (2020)
</div>

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/successful_attack_rate.png)

---

# <!--fit-->Investigating outbreak types using a simple CTMC SIS

$$
\mathbf{X}(t)=\left(S^A(t),I^A(t)\right)
$$

CTMC $\mathbf{X}(t)$ characterized by transitions

| Description | Transition | Rate |
|-------------|------------|------|
Infection | $\left(S^A,I^A\right)\to \left(S^A-1,I^A+1\right)$ | $\beta^AS^AI^A$ |
| Recovery | $\left(S^A,I^A\right)\to \left(S^A+1,I^A-1\right)$ | $\gamma^AI^A$ | 

<div style = "position: relative; bottom: -25%; font-size:20px; text-align: justify; margin-left:-60px; margin-right:-50px;">

- <ins>JA</ins> & E. Milliken. [Effect of movement on the early phase of an epidemic](https://doi.org/10.1007/s11538-022-01077-5). *Bulletin of Mathematical Biology* (2022)
</div>

---

# <!--fit-->A simple CTMC SIS *with a twist*

Regular chain of this type has $I^A=0$ as sole absorbing state

We add another absorbing state: if $I^A=\hat I$, then the chain has *left* the stochastic phase and is in a quasi-deterministic phase with exponential growth

Doing this, time to absorption measures become usable additionally to first passage time ones

And the question becomes: how long does the chain "linger on" before it is absorbed? We define the inter-absorption trajectory as the stochastic phase

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/stochastic/illustration_stochastic_phase.png)

---

# <!--fit-->One obvious problem: what should $\hat I$ be ?

- Choose $\hat I$ too small and the stochastic phase will not last long
- Choose $\hat I$ too large and absorption will only be at the DFE
- So, how does one choose $\hat I$ ?
  - A formula of Whittle (1955)
  - Multitype branching process (MTBP)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/stochastic/duration_stochastic_phase_1patch_pop1M_I0eq1.png)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/SLDUR_metapop_introductions.png)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/sim_2023_07_11-11_06_41_ID_9_run86.png)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/sim_2023_07_11-11_06_41_ID_9_run2.png)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/sim_2023_07_11-11_06_41_ID_9_run3.png)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/sim_2023_07_11-11_06_41_ID_25_run5.png)

---

<div style = "position: relative; top: -55%; font-size:40px">
Introduction vs community generated transmissions
</div>

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/exporter_importer_panel_zoom.png)

<div style = "position: relative; bottom: -45%; font-size:20px">
Left: low movement rate. Right: higher movement rate
</div>

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/sars-cov-2/VOC_countries_reporting_since_first_case_2022_04_07.png)

---

<div style="width:100%; height:100%">
  <iframe src="https://ourworldindata.org/grapher/covid-variants-area?country=~CAN" loading="lazy" style="width: 100%; height: 610px; border: 0px none;"></iframe>
</div>

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/flow-diagrams/figure_variant_no_importation_1patch.png)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/new_variant_vs_resident_variant.jpg)

--- 

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!--fit-->Measures to control introductions

Almost exclusively attacked from the perspective of would-be importer

In practice:
- Travel restrictions/interruptions
- Quarantine

---

<!-- _backgroundImage: "linear-gradient(to bottom, #7ff4, 20%, white)" -->
# <!-- fit --> Effect of quarantine

<div style = "position: relative; bottom: -40%; font-size:20px; text-align: justify; margin-left:-70px; margin-right:-50px;">

- <ins>JA</ins>, N. Bajeux, S. Portet & J. Watmough. [Quarantine and the risk of COVID-19 importation](http://dx.doi.org/10.1017/S0950268820002988). *Epidemiology & Infection* (2020)
- <ins>JA</ins>, P.-Y. Boëlle, E.M. Milliken & S. Portet. [Risk of COVID-19 variant importation - How useful are travel control measures?](http://dx.doi.org/10.1016/j.idm.2021.06.006) *Infectious Disease Modelling* (2021)
</div>

---

<div style = "position: relative; bottom: -50%; left: 5%; font-size:38px; color: black;">Lazzaretto vecchio</div>

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/epidemio/Lazzaretto_Vecchio-good_view.jpg)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/flow-diagrams/figure_SLDURM_importation_base_withQcompartments.png)

---

<div style="width:80%; height:100%">
  <iframe src="https://daytah-or-dahtah.ovh:3838/Q_calculator_start0/" style="position:absolute; top:0px; left:0px; 
  width:100%; height:100%; border: none; overflow: hidden;"></iframe>
</div>

--- 

# <!--fit-->Effect of quarantine on introduction rates

$1/\lambda$ the mean time between case introductions, $1/\lambda_q$ the mean quarantine-regulated time between case introductions, $c$ the efficacy of quarantine (in \%). Then
$$
\lambda_q = 
(100-c)\times
\lambda
$$
Suppose $1/\lambda=$ 5 days and efficacy of quarantine is 90\% at 7 days and 98\% at 14 days, respectively

Then $1/\lambda_q=$ 50 and 250 days, respectively

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/successful_attack_rate_withQ.png)

---

<!-- _backgroundImage: "linear-gradient(to bottom, #7ff4, 20%, white)" -->
# <!-- fit -->Role of travel restrictions

<div style = "position: relative; bottom: -40%; font-size:20px; text-align: justify; margin-left:-70px; margin-right:-50px;">

- <ins>JA</ins>, P.-Y. Boëlle, E.M. Milliken & S. Portet. [Risk of COVID-19 variant importation - How useful are travel control measures?](https://doi.org/10.1016/j.idm.2021.06.006) *Infectious Disease Modelling* (2021)
- A. Hurford, M.M. Martignoni, J.C. Loredo-Osti, F. Anokye, <ins>JA</ins>, B.S. Husain, B. Gaas, J. Watmough. [Pandemic modelling for regions implementing an elimination strategy](https://doi.org/10.1016/j.jtbi.2022.111378). *Journal of Theoretical Biology* (2022)
</div>

---

<div style = "position: relative; bottom: -59.75%; left: 15%; font-size:38px; color: black;">Mur de la Peste in Cabrières-d’Avignon</div>

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/epidemio/Cabrières-d'Avignon_902.jpg)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/epidemio/peste_Provence.png)

---

# <!--fit-->Untangling the contribution <br>of introduced cases

Time and time again, top jurisdictional level PH authorities take travel interruption measures

What is really the contribution of introductions to overall spread within a jurisdiction?

$\Rightarrow$ Use an **importation layer** separating introduced (imported) cases from locally generated ones

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/SLLDDUURRM_importation_layer.png)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/SLLDDUURRM_importation_layer_metapop.jpg)

---

<div style = "position: relative; top: -55%; font-size:40px">
Introductions in a metapopulation model
</div>

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/exporter_importer_panel_zoom.png)

<div style = "position: relative; bottom: -45%; font-size:20px">
Left: low movement rate. Right: higher movement rate
</div>

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/flow-diagrams/figure_variant_importation_1patch_simplified.png)

---

![bg 98%](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/importations/importation_vs_community_new_variant_means_withInset.png)

---

# <!--fit-->Interruption of travel for COVID-19

<style scoped>
table {
    height: 100%;
    width: 100%;
    font-size: 21px;
}
</style>

|Country          |Date travel suspension |Date first case |
|:----------------|:-----------------|:----------|
|Seychelles       |2020-03-03        |2020-03-14 |
|El Salvador      |2020-03-17        |2020-03-18 |
|Cape Verde       |2020-03-17        |2020-03-20 |
|Sudan            |2020-03-17        |2020-04-05 |
|Marshall Islands |2020-04-22        |2020-10-29 |
|Vanuatu          |2020-03-20        |2020-11-11 |
|North Korea      |2020-01-21        |Unreported |
|Turkmenistan     |2020-03-20        |Unreported |
|Tuvalu           |2020-03-26        |2022-05-20 (2021-11-02?) |

---

# To conclude

> [..] a powerful expression of state's sovereignty, immigration control provides a typical avenue for governments to reassure their citizens and bolster a national sense of belonging, while providing an ideal scapegoat for their own failure or negligence.

V. Chetail. [Crisis without borders: What does international law say about border closure in the context of Covid-19?](https://doi.org/10.3389/fpos.2020.606307) Frontiers in Political Science, 2 (12) (2020)

---

<!-- _backgroundImage: "linear-gradient(to bottom, #F45627, 20%, #F45627)" -->

# <!-- fit --> Merci / Miigwech / Thank you
