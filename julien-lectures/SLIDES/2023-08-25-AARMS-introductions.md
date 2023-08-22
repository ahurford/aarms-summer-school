---
marp: true
title: Stochastic epidemiological models
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

--- 

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit -->Introductions

---

# <!--fit--> Introductions (according to ChatGPT, emphasis mine)

> **Biological introduction**, also known as *biological invasion* or *biological colonization*, refers to the *intentional* or *unintentional* **introduction** of a **non-native species** into an ecosystem or habitat where they did not previously occur naturally. This introduction can be facilitated by human activities such as trade, travel, and agriculture. These introduced species are often referred to as "invasive species."

---

> Invasive species can have negative ecological, economic, and social impacts on the new environment. They can outcompete native species for resources like food and habitat, disrupt natural ecological processes, and even cause extinction or significant decline of native species. In some cases, invasive species can also affect human activities, such as agriculture, by damaging crops or introducing new diseases.

--- 

> Biological introductions can **occur through various means**, such as the *release of non-native animals or plants* **intentionally** for purposes like *pest control* or ornamental gardening, or **accidentally** through activities like *shipping* or *transportation*. 

> Preventing and managing biological introductions is crucial for maintaining the balance of ecosystems and preserving biodiversity.

---

# Introductions contribute to evolution

- Introductions are often thought of negatively (see previous slide, even ChatGPT thinks so :smile:) because of their impact on human activities (and some are easy to spot for us, e.g. the emerald ash borer, the zebra mussel, the Asian carp, etc.)

- However, on the evolutionary side, introductions are a major source of genetic variation. They can lead to the extinction of native species, but also to the emergence of new species.

(We percieve our environment as being at some equilibrium. It is not! It is constantly changing, and introductions are part of this change.)

---

# Virus introductions (continuing with ChatGPT)

[..] refers to the process by which viruses are introduced into a specific environment, host organism, or population. [..] The introduction of viruses can occur through various mechanisms, including:

1. **Direct Transmission:** Viruses can be transmitted from one host organism to another through direct contact, such as physical contact, respiratory droplets, or bodily fluids. This can happen in various contexts, including person-to-person transmission, animal-to-animal transmission, or even from contaminated surfaces.

2. **Vector-Mediated Transmission:** Some viruses are transmitted by vectors, which are organisms that carry and transmit the virus from one host to another. Mosquitoes, ticks, and other insects are common vectors for transmitting viruses like dengue fever, Zika virus, and Lyme disease.

---

3. **Environmental Exposure:** Viruses can be introduced into an environment through various means, such as contaminated water, food, or surfaces. People or animals can become infected by coming into contact with these contaminated elements.

4. **Accidental or Deliberate Release:** In some cases, viruses might be accidentally released from laboratories or other controlled environments. There have been instances where viruses that were being studied or used for research purposes were unintentionally released into the environment.

---

5. **Zoonotic Transmission:** Zoonotic viruses are those that can jump from animals to humans. The introduction of zoonotic viruses can occur when humans come into close contact with infected animals or consume animal products carrying the virus.

6. **Migration and Travel:** Viruses can be introduced to new areas when infected individuals or animals migrate or travel. This can lead to the spread of viruses across geographical regions.

The introduction of viruses can have significant consequences, ranging from mild illnesses to severe diseases that can impact human health, animal health, and the environment. Efforts to control and manage the introduction of viruses often involve public health measures, vaccination programs, vector control, and biosecurity protocols.

---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit -->Introductions are part of the spatio-temporal spread process

---

# Don't be narrow minded ! :smile:

- Lots of epi work is jurisdiction-centred