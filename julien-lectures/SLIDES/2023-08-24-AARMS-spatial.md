---
marp: true
title: Epidemics spreading in space and time
description: Julien Arino - AARMS 2023 Summer School - Epidemics spreading in space and time
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
    box-shadow: 0px 1px 5px #999;  margin-bottom: 10px;
  }
  .definition {
    text-align:justify;
    background-color:#ededde;
    border-radius:20px;
    padding:10px 20px 10px 20px;
    box-shadow: 0px 1px 5px #999;
    margin-bottom: 10px;
  }
  img[alt~="center"] {
    display: block;
    margin: 0 auto;
  }
</style>

<!-- _backgroundImage: "linear-gradient(to top, #85110d, 1%, white)" -->
# Epidemics spreading in space and time

24 August 2023 

Julien Arino [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/email-round.png)](mailto:Julien.Arino@umanitoba.ca) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/world-wide-web.png)](https://julien-arino.github.io/) [![width:32px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/icons/github-icon.png)](https://github.com/julien-arino)

Department of Mathematics & Data Science Nexus
University of Manitoba*

<div style = "font-size:18px; margin-top:-10px; padding-bottom:30px;"></div>

Canadian Centre for Disease Modelling
Canadian COVID-19 Mathematical Modelling Task Force
NSERC-PHAC EID Modelling Consortium (CANMOD, MfPH, OMNI/RÉUNIS)

<div style = "text-align: justify; position: relative; bottom: -5%; font-size:18px;">
* The University of Manitoba campuses are located on original lands of Anishinaabeg, Cree, Oji-Cree, Dakota and Dene peoples, and on the homeland of the Métis Nation.</div>

---

# <!-- fit --> Pathogens have been mobile for a while

<!--<div style = "text-align: justify">-->
It first began, it is said, in the parts of **Ethiopia** above Egypt, and thence descended into **Egypt** and **Libya** and into most of the King's country [**Persia**]. Suddenly falling upon Athens, it first attacked the population in **Piraeus**—which was the occasion of their saying that the Peloponnesians had poisoned the reservoirs, there being as yet no wells there—and afterwards appeared in the **upper city**, when the deaths became much more frequent.
<!--</div>-->

<div style = "text-align: right; position: relative; bottom: -10%; ">
Thucydides (c. 460 BCE - c. 395 BCE)

[History of the Peloponnesian War](https://www.gutenberg.org/files/7142/7142-h/7142-h.htm#link2HCH0007)
</div>

![bg 90% right:30%](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/various/Thucydides-bust-noBG.png)

--- 

<!-- _backgroundImage: "radial-gradient(white,80%,#f1c40f)" -->
# Outline
- Mobility and the spread of infectious diseases
- Formulating metapopulation models
- Basic mathematical analysis
- $\mathcal{R}_0$ is not the panacea - An urban centre and satellite cities
- Problems specific to metapopulations
- Numerical investigations of large-scale systems
---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# Mobility and the spread of infectious diseases

---

# <!-- fit -->Mobility is complicated and drives disease spatialisation

**Mobility is complicated**:

- Multiple modalities: foot, bicycle, personal vehicle, bus, train, boat, airplane
- Various durations: trip to the corner shop $\neq$ commuting $\neq$ multi-day trip for work or leisure $\neq$ relocation, immigration or refuge seeking
- Volumes are hard to fathom

And yet **mobility drives spatio-temporal spread**:
- Black Death 1347-1353 arrived in Europe and spread following trade routes
- SARS-CoV-1 spread out of HKG along the GATN
- Khan, Arino, Hu *et al*, [Spread of a novel influenza A (H1N1) virus via global airline transportation](https://www.nejm.org/doi/pdf/10.1056/NEJMc0904559), *New England Journal of Medicine* (2009)
</div>

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/transportation/trade_routes_1212AD.png)

---

![bg contain](https://www.usu.edu/markdamen/1320hist&civ/slides/06plague/map.jpg)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/epidemio/Peste-Delumeau.jpg)

---

# The Black Death: quick facts

- First of the middle ages plagues to hit Europe
- Affected Afro-Eurasia from 1346 to 1353
- Europe 1347-1351
- Killed 75–200M in Eurasia & North Africa
- Killed 30-60% of European population

![bg right:35%](https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Yersinia_pestis_fluorescent.jpeg/1036px-Yersinia_pestis_fluorescent.jpeg)

---

# Plague control measures

- Lazzarettos of Dubrovnik 1377 (30 days)
- Quarantena of Venice 1448 (40 days)
- Isolation of known or suspected cases as well as persons who had been in contact with them, at first for 14 days and gradually increased to 40 days
- Improvement of sanitation: development of pure water supplies, garbage and sewage disposal, food inspection
- .. Find and kill a snake, chop it into pieces and rub the various parts over swollen buboes. (Snake, synonymous with Satan, was thought to draw the disease out of the body as evil would be drawn to evil)

![bg left:24%](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Nuremberg_chronicles_-_Dance_of_Death_%28CCLXIIIIv%29.jpg/1201px-Nuremberg_chronicles_-_Dance_of_Death_%28CCLXIIIIv%29.jpg)

---

# Pathogen spread has evolved with mobility

- Pathogens travel along trade routes

- In ancient times, trade routes were relatively easy to comprehend

- With acceleration and globalization of mobility, things change

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/transportation/duration_Paris_Bordeaux.png)

---

![bg 100%](https://upload.wikimedia.org/wikipedia/commons/b/bf/High_Speed_Railroad_Map_of_Europe.svg)
![bg 100%](https://upload.wikimedia.org/wikipedia/commons/thumb/8/86/Rail_map_of_China_%28high_speed_highlighted%29_WP.svg/1280px-Rail_map_of_China_%28high_speed_highlighted%29_WP.svg.png)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/transportation/world_graph-degree.png)

---

![bg contain](https://www.cmaj.ca/content/cmaj/182/6/579/F2.large.jpg)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/transportation/passengers_transported_worldwide.png)

---

# <!--fit-->Fragmented jurisdictional landscape

- Political divisions (jurisdictions): nation groups (e.g., EU), nations, provinces/states, regions, counties, cities..
- Travel between jurisdictions can be complicated or impossible
- Data is integrated at the jurisdicional level
- Policy is decided at the jurisdictional level
- Long range mobility is a bottom $\to$ top $\to$ top $\to$ bottom process

![bg right:40%](https://compote.slate.com/images/af3c1e4a-9ca9-4caa-8cbb-7f4f34c9ac88.jpeg?width=1440&rect=1560x1040&offset=0x0)

---

# Why mobility is important in the context of health

```
All migrants/travellers carry with them their "health history"
```

- latent and/or active infections (TB, H1N1, polio)
- immunizations (schedules vary by country)
- health/nutrition practices (KJv)
- treatment methods (antivirals)

```
Pathogens ignore borders and politics
```

- antiviral treatment policies for Canada and USA
- SARS-CoV-2 anyone?

---

# SARS-CoV-1 (2002-2003)

## Overall impact

- Index case for international spread arrives HKG 21 February 2003

- Last country with local transmission (Taiwan) removed from list 5 July 2003

- 8273 cases in 28 countries	

- (Of these cases, 1706 were HCW)

- 775 deaths (CFR 9.4%)

![bg right:45%](https://www.cdc.gov/sars/lab/images/coronavirus2.gif)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/sars-cov-1/SARS_countries_with_time.png)


---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/polio/polio_vaccine_coverage_Africa_2003.png)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/polio/West_Central_Africa_Polio_2000_2006_noNGA.png)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/polio/West_Central_Africa_Polio_2000_2006.png)

---

![bg contain](https://www.nejm.org/na101/home/literatum/publisher/mms/journals/content/nejm/2006/nejm_2006.355.issue-24/nejmp068200/production/images/img_medium/nejmp068200_f1.jpeg)

<div style = "position: relative; bottom: -57%; padding-bottom:0px; font-size:25px; text-align: right;">
Polio spread 2002-2006. Pallansch & Sandhu, N Engl J Med 2006; 355:2508-2511
</div>

---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit -->Formulating metapopulation models

<div style = "position: relative; bottom: -40%; font-size:20px;">

- JA & PvdD. [Disease spread in metapopulations](https://server.math.umanitoba.ca/~jarino/publications/ArinoVdD-2006-FIC48.pdf). *Fields Institute Communications* **48**:1-13 (2006)
- JA. [Diseases in metapopulations](https://server.math.umanitoba.ca/~jarino/papers/Arino_metapopulations.pdf). In *Modeling and Dynamics of Infectious Diseases*, World Scientific (2009)
- JA. [Spatio-temporal spread of infectious pathogens of humans](https://doi.org/10.1016/j.idm.2017.05.001). *Infectious Disease Modelling* **2**(2):218-228 (2017)
</div>

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/spatial/J_WeightedVoronoi_zoom.png)

---

# General principles (1)

- $|\mathcal{P}|$ geographical locations (*patches*) in a set $\mathcal{P}$  (city, region, country..)
- Patches are vertices in a graph
- Each patch $p\in\mathcal{P}$ contains **compartments** $\mathcal{C}_p\subseteq\mathcal{C}$
  - individuals susceptible to the disease
	- individuals infected by the disease
	- different species affected by the disease
	- etc.

![bg right:32%](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/metapopulations/simple_graph.svg)

---

# General principles (2)

- Compartments *may* move between patches, with $m_{cqp}$ rate of movement of individuals from compartment $c\in\mathcal{C}$ from patch $p\in\mathcal{P}$ to patch $q\in\mathcal{P}\setminus\{p\}$
- Movement instantaneous and no death during movement
- $\forall c\in\mathcal{C}$, defines a digraph $\mathcal{G}^c$ with arcs $\mathcal{A}^c$
- Arc from $p$ to $q$ if $m_{cqp}>0$, absent otherwise
- $|\mathcal{C}|$ compartments, so each $(p,q)$ can have at most $|\mathcal{C}|$ arrows $\rightarrow$ multi-digraph


---

# The underlying mobility model

$N_{cp}$ population of compartment $c\in\mathcal{C}$ in patch $p\in\mathcal{P}$

Assume no birth or death. Balance inflow and outflow

$$
\begin{align}
N_{cp}' &= \left(\sum_{q\in\mathcal{P}\setminus\{p\}} m_{cpq}N_{cq}\right)-\left(\sum_{q\in\mathcal{P}\setminus\{p\}} m_{cqp}\right)N_{cp} \\
&\\
\text{or} & \\
&\\
N_{cp}' &=  \sum_{q\in\mathcal{P}} m_{cpq}N_{cq} 
\qquad \tag{1}\label{eq:dNcp}
\end{align}
$$
when we write
$$
m_{cpp}=-\sum_{q\in\mathcal{P}\setminus\{p\}} m_{cqp}
$$

---

# The toy SLIRS model in patches

![width:800px center](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/flow-diagrams/SLIRS.svg)

$B(N)$ is the birth rate (typically $b$ or $bN$)

$L$ = latently infected ($\simeq E$ exposed, although the latter term is ambiguous)

---

# $|\mathcal{P}|$-SLIRS model

$$
\begin{align}
S_{p}' &=\mathcal{B}_p\left(N_p\right)+\nu_pR_p-\Phi_p-d_pS_p 
\color{red}{+\textstyle{\sum_{q\in\mathcal{P}}} m_{Spq}S_{q}} \tag{2a}\label{sys:pSLIRS_dS} \\
L_{p}' &=\Phi_p-\left( \varepsilon_{p}+d_{p}\right)L_{p}
\color{red}{+\textstyle{\sum_{q\in\mathcal{P}}} m_{Lpq}L_{q}} \tag{2b}\label{sys:pSLIRS_dL} \\
I_{p}' &=\varepsilon_pL_p-(\gamma_p+d_p)I_p
\color{red}{+\textstyle{\sum_{q\in\mathcal{P}}} m_{Ipq}I_{q}} \tag{2c}\label{sys:pSLIRS_dI} \\
R_{p}' &=\gamma _{p}I_{p}-\left(\nu_{p}+d_{p}\right)R_{p}
\color{red}{+\textstyle{\sum_{q\in\mathcal{P}}} m_{Rpq}R_{q}} \tag{2d}\label{sys:pSLIRS_dR} 
\end{align}
$$

with incidence 
$$
\Phi_p=\beta_p\frac{S_pI_p}{N_p^{q_p}},\qquad q_p\in\{0,1\}
\tag{2e}\label{sys:pSLIRS_incidence} 
$$


<div style = "position: relative; bottom: -15%; font-size:20px;">

- JA & PvdD. [Disease spread in metapopulations](https://server.math.umanitoba.ca/~jarino/publications/ArinoVdD-2006-FIC48.pdf). *Fields Institute Communications* **48**:1-13 (2006)
- JA. [Diseases in metapopulations](https://server.math.umanitoba.ca/~jarino/papers/Arino_metapopulations.pdf). In *Modeling and Dynamics of Infectious Diseases*, World Scientific (2009)
</div>

---

# $|\mathcal{S}|\;|\mathcal{P}|$-SLIRS (multiple species)

$\mathcal{S}$ a set of species
$$
\begin{align}
S_{sp}' &= \mathcal{B}_{sp}(N_{sp})+\nu_{sp}R_{sp}-\Phi_{sp}-d_{sp}S_{sp}
\color{red}{+\textstyle{\sum_{q\in\mathcal{P}}} m_{Sspq}S_{sq}} \tag{3a}\label{sys:spSLIRS_dS} \\
L_{sp}' &= \Phi_{sp}-(\varepsilon_{sp}+d_{sp})L_{sp}
\color{red}{+\textstyle{\sum_{q\in\mathcal{P}}}m_{Lspq}L_{sq}} \tag{3b}\label{sys:spSLIRS_dL} \\
I_{sp}' &= \varepsilon_{sp}L_{sp}-(\gamma_{sp}+d_{sp})I_{sp}
\color{red}{+\textstyle{\sum_{q\in\mathcal{P}}} m_{Ispq}I_{sq}} \tag{3c}\label{sys:spSLIRS_dI} \\
R_{sp} &= \gamma _{sp}I_{sp}-(\nu_{sp}+d_{sp})R_{sp}
\color{red}{+\textstyle{\sum_{q\in\mathcal{P}}} m_{Rspq}R_{sq}} \tag{3d}\label{sys:spSLIRS_dR} 
\end{align}
$$

with incidence
$$
\Phi_{sp}=\sum_{k\in\mathcal{S}}\beta_{skp}\frac{S_{sp}I_{kp}}{N_p^{q_p}},\qquad q_p\in\{0,1\}
\tag{3e}\label{sys:spSLIRS_incidence} 
$$

<div style = "position: relative; bottom: -6%; font-size:20px;">

- JA, Davis, Hartley, Jordan, Miller \& PvdD. [A multi-species epidemic model with spatial dynamics](https://server.math.umanitoba.ca/~jarino/papers/ArinoDavisHartleyJordanMillerVdD-2005-MMB22.pdf). *Mathematical Medicine and Biology* **22**(2):129-142 (2005) 
- JA, Jordan \& PvdD. [Quarantine in a multi-species epidemic model with spatial dynamics](https://server.math.umanitoba.ca/~jarino/publications/ArinoJordanVdD-2007-MBS206.pdf). *Mathematical Biosciences* **206**(1):46-60 (2007)
</div>

---

# $|\mathcal{P}|^2$-SLIRS (residency patch/movers-stayers)

$$
\begin{align}
S_{pq}' =& 
\mathcal{B}_{pq}\left(N_p^r\right)+\nu_{pq} R_{pq}-\Phi_{pq}-d_{pq}S_{pq} \color{red}{+\textstyle{\sum_{k\in\mathcal{P}}} m_{Spqk}S_{pk}} 
\tag{4a}\label{sys:ppSLIRS_dS} \\
L_{pq}' =& \Phi_{pq}
-(\varepsilon_{pq}+d_{pq})L_{pq}
\color{red}{+\textstyle{\sum_{k\in\mathcal{P}}} m_{Lpqk}L_{pk}} 
\tag{4b}\label{sys:ppSLIRS_dL} \\
I_{pq}' =& \varepsilon_{pq} L_{pq}
-(\gamma_{pq}+d_{pq})I_{pq}
\color{red}{+\textstyle{\sum_{k\in\mathcal{P}}} m_{Ipqk}I_{pk}} 
\tag{4c}\label{sys:ppSLIRS_dI} \\
R_{pq}' =& \gamma_{pq} I_{pq}
-(\nu_{pq}+d_{pq})R_{pq}
\color{red}{+\textstyle{\sum_{k\in\mathcal{P}}} m_{Rpqk}R_{pk}}
\tag{4d}\label{sys:ppSLIRS_dR} 
\end{align}
$$

with incidence
$$
\Phi_{pq}=\sum_{k\in\mathcal{P}}\beta_{pqk}\frac{S_{pq}I_{kq}}{N_p^{q_q}},\qquad q_q=\{0,1\}
\tag{4e}\label{sys:ppSLIRS_incidence} 
$$

<div style = "position: relative; bottom: -10%; font-size:20px;">

- Sattenspiel & Dietz. [A structured epidemic model incorporating geographic mobility among regions](https://doi.org/10.1016/0025-5564(94)00068-B) (1995)
- JA \& PvdD. [A multi-city epidemic model](https://server.math.umanitoba.ca/~jarino/publications/ArinoVdD-2003-MPS10.correct.pdf). *Mathematical Population Studies* **10**(3):175-193 (2003)
- JA \& PvdD. [The basic reproduction number in a multi-city compartmental epidemic model](https://server.math.umanitoba.ca/~jarino/papers/ArinoVdD-2003-LNCIS294.pdf). In *Positive Systems* (2003)
</div>

---

# General metapopulation epidemic models

$\mathcal{U}\subsetneq\mathcal{C}$ **uninfected** and $\mathcal{I}\subsetneq\mathcal{C}$ **infected** compartments, $\mathcal{U}\cup\mathcal{I}=\mathcal{C}$ and $\mathcal{U}\cap\mathcal{I}=\emptyset$

For $k\in\mathcal{U}$, $\ell\in\mathcal{I}$ and $p\in\mathcal{P}$,
$$
\begin{align}
s_{kp}' &= f_{kp}(S_p,I_p)+\sum_{q\in\mathcal{P}} m_{kpq}s_{kq} 
\tag{5a}\label{sys:general_metapop_ds} \\
i_{\ell p}' &= g_{\ell p}(S_p,I_p)+\sum_{q\in\mathcal{P}} m_{\ell pq}i_{\ell q}
\tag{5b}\label{sys:general_metapop_di} 
\end{align}
$$
where $S_p=(s_{1p},\ldots,s_{|\mathcal{U}|p})$ and $I_p=(i_{1p},\ldots,i_{|\mathcal{I}|p})$

---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!--- fit --->Basic mathematical analysis

---

# Analysis - Toy system

For simplicity, consider $|\mathcal{P}|$-SLIRS with $\mathcal{B}_p(N_p)=\mathcal{B}_p$
$$
\begin{align}
S_{p}' &=\mathcal{B}_p-\Phi_p-d_pS_p+\nu_pR_p
+\textstyle{\sum_{q\in\mathcal{P}}} m_{Spq}S_{q} 
\tag{6a}\label{sys:pSLIRS_toy_dS} \\
L_{p}' &=\Phi_p-\left( \varepsilon_{p}+d_{p}\right)L_{p}
+\textstyle{\sum_{q\in\mathcal{P}}} m_{Lpq}L_{q} 
\tag{6b}\label{sys:pSLIRS_toy_dL} \\
I_{p}' &=\varepsilon_pL_p-(\gamma_p+d_p)I_p
+\textstyle{\sum_{q\in\mathcal{P}}} m_{Ipq}I_{q} 
\tag{6c}\label{sys:pSLIRS_toy_dI} \\
R_{p}' &=\gamma _{p}I_{p}-\left(\nu_{p}+d_{p}\right)R_{p}
+\textstyle{\sum_{q\in\mathcal{P}}} m_{Rpq}R_{q}
\tag{6d}\label{sys:pSLIRS_toy_dR} 
\end{align}
$$

with incidence
$$
\Phi_p=\beta_p\frac{S_pI_p}{N_p^{q_p}},\qquad q_p\in\{0,1\}
\tag{6e}\label{sys:pSLIRS_toy_incidence} 
$$

System of $4|\mathcal{P}|$ equations

---

# Size is not that bad..

System of $4|\mathcal{P}|$ equations !!!

However, a lot of structure: 
- $|\mathcal{P}|$ *copies* of individual units, each comprising 4 equations
- Dynamics of individual units well understood
- Coupling is linear

$\implies$ Good case of large-scale system (matrix analysis is your friend)

---

# Notation in what follows

- $M\in\mathcal{M}_n(\mathbb{R})=\mathbb{R}^{n\times n}$ a square matrix with entries denoted $m_{ij}$

- $M\geq\mathbf{0}$ if $m_{ij}\geq 0$ for all $i,j$ (could be the zero matrix); $M>\mathbf{0}$ if $M\geq\mathbf{0}$ and $\exists i,j$ with $m_{ij}>0$; $M\gg\mathbf{0}$ if $m_{ij}>0$ $\forall i,j=1,\ldots,n$. Same notation for vectors

- $\sigma(M)=\{\lambda\in\mathbf{C}; M\lambda=\lambda\mathbf{v}, \mathbf{v}\neq\mathbf{0}\}$ **spectrum** of $M$

- $\rho(M)=\max_{\lambda\in\sigma(M)}\{|\lambda|\}$ **spectral radius**

- $s(M)=\max_{\lambda\in\sigma(M)}\{\Re(\lambda)\}$ **spectral abscissa** (or **stability modulus**)

- $M$ is an **M-matrix** if it is a **Z-matrix** ($m_{ij}\leq 0$ for $i\neq j$) and $M = s\mathbb{I}-A$, with $A\geq 0$ and $s\geq \rho(A)$

---

# Behaviour of the total population

Consider behaviour of $N_p=S_p+L_p+I_p+R_p$. We have
$$
\begin{aligned}
N_p' &=\mathcal{B}_p\cancel{-\Phi_p}-d_pS_p\cancel{+\nu_pR_p}
+\textstyle{\sum_{q\in\mathcal{P}}} m_{Spq}S_{q} \\
&\quad \cancel{+\Phi_p}-\left(\cancel{\varepsilon_{p}}
+d_{p}\right)L_{p}
+\textstyle{\sum_{q\in\mathcal{P}}} m_{Lpq}L_{q} \\
&\quad \cancel{+\varepsilon_pL_p}-(\cancel{\gamma_p}+d_p)I_p
+\textstyle{\sum_{q\in\mathcal{P}}} m_{Ipq}I_{q} \\
&\quad \cancel{+\gamma _{p}I_{p}}
-\left(\cancel{\nu_{p}}+d_{p}\right)R_{p}
+\textstyle{\sum_{q\in\mathcal{P}}} m_{Rpq}R_{q}
\end{aligned}
$$

So
$$
N_p'=\mathcal{B}_p-d_pN_p
+\sum_{X\in\{S,L,I,R\}}\sum_{q\in\mathcal{P}} m_{Xpq}X_{q}
$$

---

# Vector / matrix form of the equation

We have
$$
N_p'=\mathcal{B}_p-d_pN_p
+\sum_{X\in\{S,L,I,R\}}\sum_{q\in\mathcal{P}} m_{Xpq}X_{q}
$$
Write this in vector form
$$
\tag{7}\label{sys:pSLIRS_dN_general} 
\mathbf{N}'=\mathbf{b}-\mathbf{d}\mathbf{N}+\sum_{X\in\{S,L,I,R\}}\mathcal{M}^X\mathbf{X}
$$
where $\mathbf{b}=(\mathcal{B}_1,\ldots,\mathcal{B}_{|\mathcal{P}|})^T,\mathbf{N}=(N_1,\ldots,N_{|\mathcal{P}|})^T,\mathbf{X}=(X_1,\ldots,X_{|\mathcal{P}|})^T\in\mathbb{R}^{|\mathcal{P}|},$ $\mathbf{d},\mathcal{M}^X$ $|\mathcal{P}|\times|\mathcal{P}|$-matrices with 
$$
\mathbf{d}=\mathsf{diag}\left(d_1,\ldots,d_{|\mathcal{P}|}\right)
$$

---

# The movement matrix

$$
\mathcal{M}^c=
\begin{pmatrix}
-\sum_{q\in\mathcal{P}} m_{cq1} & m_{c12} & & m_{c1|\mathcal{P}|} \\
m_{c21} & -\sum_{q\in\mathcal{P}} m_{cq2} & & m_{c2|\mathcal{P}|} \\
& & & \\
m_{c|\mathcal{P}|1} & m_{c|\mathcal{P}|2} & & -\sum_{q\in\mathcal{P}} m_{cq|\mathcal{P}|}
\end{pmatrix}
$$

<div class="theorem">

Consider a compartment $c\in\mathcal{C}$. Then the following hold true:
1. $0\in\sigma(\mathcal{M}^c)$ and corresponds to left eigenvector $\mathbf{1}^T_{|\mathcal{P}|}=(1,\ldots,1)$
2. $−\mathcal{M}^c$ singular M-matrix
3. $0 = s(\mathcal{M}^c)\in\sigma(\mathcal{M}^c)$
4. $\mathcal{M}^c$ irreducible $\implies$ $s(\mathcal{M}^c)$ has multiplicity 1
</div>

<div style = "position: relative; bottom: -6%; font-size:20px;">

- JA, Bajeux \& Kirkland. [Number of source patches required for population persistence in a source-sink metapopulation with explicit movement](https://link.springer.com/epdf/10.1007/s11538-019-00593-1?author_access_token=EExdAOC94_0nwG8LMCIoG_e4RwlQNchNByi7wbcMAY6UprpSQ2NEwJhyTjNQrHljtlg8X5E8XM5_iLMsJpxIq750BJ9YXGT6yuMgh65TUuKDb_Z-g1pn0m6w5XILLO0RRY0pzrazec5gcY_GZHE85Q%3D%3D). *Bulletin of Mathematical Biology* **81**(6):1916-1942 (2019)
</div>

---

# The nice case

Recall that
$$
\tag{7}
\mathbf{N}'=\mathbf{b}-\mathbf{d}\mathbf{N}+\sum_{X\in\{S,L,I,R\}}\mathcal{M}^X\mathbf{X}
$$

Suppose movement rates **equal for all compartments**, i.e.,
$$
\mathcal{M}^S=\mathcal{M}^L=\mathcal{M}^I=\mathcal{M}^R=:\mathcal{M}
$$
Then
$$
\begin{align}
\mathbf{N}' &= \mathbf{b}-\mathbf{d}\mathbf{N}+\mathcal{M}\sum_{X\in\{S,L,I,R\}}\mathbf{X}\\
&= \mathbf{b}-\mathbf{d}\mathbf{N}+\mathcal{M}\mathbf{N} \tag{8}\label{sys:pSLIRS_toy_dN}
\end{align}
$$

--- 

$$
\tag{8}
\mathbf{N}'=\mathbf{b}-\mathbf{d}\mathbf{N}+\mathcal{M}\mathbf{N}
$$

Equilibria
$$
\begin{aligned}
\mathbf{N}'=\mathbf{0} &\Leftrightarrow \mathbf{b}-\mathbf{d}\mathbf{N}+\mathcal{M}\mathbf{N}=\mathbf{0} \\
&\Leftrightarrow (\mathbf{d}-\mathcal{M})\mathbf{N}=\mathbf{b} \\
&\Leftrightarrow \mathbf{N}^\star=(\mathbf{d}-\mathcal{M})^{-1}\mathbf{b}
\end{aligned}
$$
given, of course, that $\mathbf{d}-\mathcal{M}$ (or, equivalently, $\mathcal{M}-\mathbf{d}$) is invertible.. Is it?


---

# Perturbations of movement matrices

<div class="theorem">

$\mathcal{M}$ a movement matrix  and $D$ a diagonal matrix. The following hold true:
1. $s(\mathcal{M}+d\mathbb{I})=d$ for all $d\in\mathbb{R}$
2. $s(\mathcal{M}+D)\in\sigma(\mathcal{M}+D)$ and is associated with an eigenvector $\mathbf{v}>\mathbf{0}$. If, additionally, $\mathcal{M}$ irreducible, then $s(\mathcal{M}+D)$ has multiplicity 1 and is associated with $\mathbf{v}\gg\mathbf{0}$
3. $\mathsf{diag}(D)\gg\mathbf{0}$ $\implies$ $D-\mathcal{M}$ nonsingular M-matrix and $(D-\mathcal{M})^{-1}>\mathbf{0}$
4. $\mathcal{M}$ irreducible and $\mathsf{diag}(D)>\mathbf{0}$ $\implies$ $D-\mathcal{M}$ irreducible nonsingular M-matrix and $(D-\mathcal{M})^{-1}\gg\mathbf{0}$
</div>

<div style = "position: relative; bottom: -10%; font-size:20px;">

- JA, Bajeux \& Kirkland. [Number of source patches required for population persistence in a source-sink metapopulation with explicit movement](https://link.springer.com/epdf/10.1007/s11538-019-00593-1?author_access_token=EExdAOC94_0nwG8LMCIoG_e4RwlQNchNByi7wbcMAY6UprpSQ2NEwJhyTjNQrHljtlg8X5E8XM5_iLMsJpxIq750BJ9YXGT6yuMgh65TUuKDb_Z-g1pn0m6w5XILLO0RRY0pzrazec5gcY_GZHE85Q%3D%3D). *Bulletin of Mathematical Biology* **81**(6):1916-1942 (2019)
</div>



---

# Nonsingularity of $\mathcal{M}-\mathbf{d}$

Using a spectrum shift,
$$
s(\mathcal{M}-\mathbf{d})=-\min_{p\in\mathcal{P}}d_p
$$
This gives a constraint: for total population to behave well (in general, we want this), we must assume all death rates are positive

Assume they are (in other words, assume $\mathbf{d}$ nonsingular). Then $\mathcal{M}-\mathbf{d}$ is nonsingular and $\mathbf{N}^\star=(\mathbf{d}-\mathcal{M})^{-1}\mathbf{b}$ unique

---

# Behaviour of the total population
<p style="margin-bottom:-1.5cm;"></p> 

# Equal movement case

$\mathbf{N}^\star=(\mathbf{d}-\mathcal{M})^{-1}\mathbf{b}$ attracts solutions of
$$
\mathbf{N}'=\mathbf{b}-\mathbf{d}\mathbf{N}+\mathcal{M}\mathbf{N}=:f(\mathbf{N})
$$

Indeed, we have
$$
Df=\mathcal{M}-\mathbf{d}
$$

Since we now assume that $\mathbf{d}$ is nonsingular, we have (spectral shift \& properties of $\mathcal{M}$) $s(\mathcal{M}-\mathbf{d})=-\min_{p\in\mathcal{P}}d_p<0$

$\mathcal{M}$ irreducible $\rightarrow$ $\mathbf{N}^\star\gg 0$ (provided $\mathbf{b}>\mathbf{0}$, of course)

---

# <!--fit-->Behaviour of total population with reducible movement

<div class="theorem">

Assume $\mathcal{M}$ reducible. Let $a$ be the number of minimal absorbing sets in the corresponding connection graph $\mathcal{G}(\mathcal{M})$. Then
1. The spectral abscissa $s(\mathcal{M})=0$ has multiplicity $a$
2. Associated to $s(\mathcal{M})$ is a nonnegative eigenvector $\mathbf{v}$ s.t.
	- $v_i>0$ if $i$ is a vertex in a minimal absorbing set
	- $v_i=0$ if $i$ is a transient vertex
</div>

<div style = "position: relative; bottom: -8%; font-size:20px;">

From Foster and Jacquez, [Multiple zeros for eigenvalues and the multiplicity of traps of a linear compartmental system](https://doi.org/10.1016/0025-5564(75)90096-6), *Mathematical Biosciences* (1975)
</div>


---

# The not-so-nice case

Recall that
$$
\mathbf{N}'=\mathbf{b}-\mathbf{d}\mathbf{N}+\sum_{X\in\{S,L,I,R\}}\mathcal{M}^X\mathbf{X}
$$

Suppose movement rates **similar for all compartments**, i.e., the zero/nonzero patterns in all matrices are the same but not the entries

Let
$$
\underline{\mathcal{M}}=\left[\min_{X\in\{S,L,I,R\}}m_{Xpq}\right]_{pq,p\neq q}\qquad 
\underline{\mathcal{M}}=\left[\max_{X\in\{S,L,I,R\}}m_{Xpq}\right]_{pq,p=q}
$$
and
$$
\overline{\mathcal{M}}=\left[\max_{X\in\{S,L,I,R\}}m_{Xpq}\right]_{pq,p\neq q}\qquad
\overline{\mathcal{M}}=\left[\min_{X\in\{S,L,I,R\}}m_{Xpq}\right]_{pq,p=q}
$$

--- 

# Cool, no? No!

Then we have
$$
\mathbf{b}-\mathbf{d}\mathbf{N}+\underline{\mathcal{M}}\mathbf{N}\leq\mathbf{N}'\leq\mathbf{b}-\mathbf{d}\mathbf{N}+\overline{\mathcal{M}}\mathbf{N}
$$

Me, roughly every 6 months: *Oooh, coooool, a linear differential inclusion!*

Me, roughly 10 minutes after that previous statement: *Quel con!* 

Indeed $\underline{\mathcal{M}}$ and $\overline{\mathcal{M}}$ are **are not** movement matrices  (in particular, their column sums are not all zero)

So no luck there.. 

However, *non lasciate ogne speranza*, we can still do stuff!

---

# Disease free equilibrium (DFE)

Assume system at equilibrium and $L_p=I_p=0$ for $p\in\mathcal{P}$. Then $\Phi_p=0$ and 

$$
\begin{aligned}
0 &=\mathcal{B}_p-d_pS_p+\nu_pR_p
+\textstyle{\sum_{q\in\mathcal{P}}} m_{Spq}S_{q} \\
0 &=-\left(\nu_{p}+d_{p}\right)R_{p}
+\textstyle{\sum_{q\in\mathcal{P}}} m_{Rpq}R_{q}
\end{aligned}
$$
Want to solve for $S_p,R_p$. Here, it is best (crucial in fact) to remember some linear algebra. Write system in vector form:
$$
\begin{aligned}
\mathbf{0} &=\mathbf{b}-\mathbf{d}\mathbf{S}+\mathbf{\nu}\mathbf{R}+\mathcal{M}^S\mathbf{S} \\
\mathbf{0} &=-\left(\mathbf{\nu}+\mathbf{d}\right)\mathbf{R}+\mathcal{M}^R\mathbf{R}
\end{aligned}
$$
where $\mathbf{S},\mathbf{R},\mathbf{b}\in\mathbb{R}^{|\mathcal{P}|}$, $\mathbf{d},\mathbf{\nu},\mathcal{M}^S,\mathcal{M}^R$ $|\mathcal{P}|\times|\mathcal{P}|$-matrices ($\mathbf{d},\mathbf{\nu}$ diagonal)


---

# $\mathbf{R}$ at DFE

Recall second equation:
$$
\mathbf{0} =-\left(\mathbf{\nu}+\mathbf{d}\right)\mathbf{R}+\mathcal{M}^R\mathbf{R} \Leftrightarrow (\mathcal{M}^R-\mathbf{\nu}-\mathbf{d})\mathbf{R}=\mathbf{0}
$$

So unique solution $\mathbf{R}=\mathbf{0}$ if $\mathcal{M}^R-\mathbf{\nu}-\mathbf{d}$ invertible.
Is it?

We have been here before! 

From spectrum shift, $s(\mathcal{M}^R-\mathbf{\nu}-\mathbf{d})=-\min_{p\in\mathcal{P}}(\nu_p+d_p)<0$

So, given $\mathbf{L}=\mathbf{I}=\mathbf{0}$, $\mathbf{R}=\mathbf{0}$ is the unique equilibrium and
$$
\lim_{t\to\infty}\mathbf{R}(t)=\mathbf{0}
$$

$\implies$ DFE has $\mathbf{L}=\mathbf{I}=\mathbf{R}=\mathbf{0}$

---

# $\mathbf{S}$ at the DFE

DFE has $\mathbf{L}=\mathbf{I}=\mathbf{R}=\mathbf{0}$ and $\mathbf{b}-\mathbf{d}\mathbf{S}+\mathcal{M}^S\mathbf{S}=\mathbf{0}$, i.e.,
$$
\mathbf{S}=(\mathbf{d}-\mathcal{M}^S)^{-1}\mathbf{b}
$$
Recall: $-\mathcal{M}^S$ singular M-matrix. From previous reasoning, $\mathbf{d}-\mathcal{M}^S$ has **instability modulus** shifted right by $\min_{p\in\mathcal{P}}d_p$. So:
- $\mathbf{d}-\mathcal{M}^S$ invertible
- $\mathbf{d}-\mathcal{M}^S$ nonsingular M-matrix

Second point $\implies (\mathbf{d}-\mathcal{M}^S)^{-1}>\mathbf{0}\implies (\mathbf{d}-\mathcal{M}^S)^{-1}\mathbf{b}> \mathbf{0}$  (would have $\gg\mathbf{0}$ if $\mathcal{M}^S$ irreducible)

So DFE makes sense with
$$
(\mathbf{S},\mathbf{L},\mathbf{I},\mathbf{R})=\left((\mathbf{d}-\mathcal{M}^S)^{-1}\mathbf{b},\mathbf{0},\mathbf{0},\mathbf{0}\right)
$$

---

# Computing the basic reproduction number $\mathcal{R}_0$

Use next generation method with $\Xi=\{L_1,\ldots,L_{|\mathcal{P}|},I_1,\ldots,I_{|\mathcal{P}|}\}$, $\Xi'=\mathcal{F}-\mathcal{V}$
$$
\mathcal{F}=\left(\Phi_1,\ldots,\Phi_{|\mathcal{P}|},0,\ldots,0\right)^T
$$
$$
\mathcal{V}=
\begin{pmatrix}
\left( \varepsilon_{1}+d_{1}\right)L_{1}
-\sum\limits_{q\in\mathcal{P}} m_{L1q}L_{q} \\
\vdots \\
\left( \varepsilon_{|\mathcal{P}|}+d_{|\mathcal{P}|}\right)L_{|\mathcal{P}|}
-\sum\limits_{q\in\mathcal{P}} m_{L|\mathcal{P}|q}L_{q} \\
-\varepsilon_1L_1+(\gamma_1+d_1)I_1
-\sum\limits_{q\in\mathcal{P}} m_{I1q}I_{q} \\
\vdots \\
-\varepsilon_{|\mathcal{P}|}L_{|\mathcal{P}|}
+(\gamma_{|\mathcal{P}|}+d_{|\mathcal{P}|})I_{|\mathcal{P}|}
-\sum\limits_{q\in\mathcal{P}} m_{I|\mathcal{P}|q}I_{q}
\end{pmatrix}
$$

---

Differentiate w.r.t. $\Xi$:
$$
D\mathcal{F}
=
\begin{pmatrix}
\dfrac{\partial\Phi_1}{\partial L_1} & \cdots &
\dfrac{\partial\Phi_1}{\partial L_{|\mathcal{P}|}} & 
\dfrac{\partial\Phi_1}{\partial I_1} & \cdots &
\dfrac{\partial\Phi_1}{\partial I_{|\mathcal{P}|}} \\
\vdots & & \vdots & \vdots & & \vdots \\
\dfrac{\partial\Phi_{|\mathcal{P}|}}{\partial L_1} & \cdots &
\dfrac{\partial\Phi_{|\mathcal{P}|}}{\partial L_{|\mathcal{P}|}} & 
\dfrac{\partial\Phi_{|\mathcal{P}|}}{\partial I_1} & \cdots &
\dfrac{\partial\Phi_{|\mathcal{P}|}}{\partial I_{|\mathcal{P}|}} \\
0 & \cdots & 0 & 0 & \cdots & 0 \\
\vdots & & \vdots & \vdots & & \vdots \\
0 & \cdots & 0 & 0 & \cdots & 0
\end{pmatrix}
$$

---

Note that
$$
\frac{\partial\Phi_p}{\partial L_k}=\frac{\partial\Phi_p}{\partial I_k}=0
$$
whenever $k\neq p$, so
$$
D\mathcal{F}
=
\begin{pmatrix}
\mathsf{diag}\left(
\frac{\partial\Phi_1}{\partial L_1},\ldots,\frac{\partial\Phi_{|\mathcal{P}|}}{\partial L_{|\mathcal{P}|}}\right) &
\mathsf{diag}\left(
\frac{\partial\Phi_1}{\partial I_1},\ldots,\frac{\partial\Phi_{|\mathcal{P}|}}{\partial I_{|\mathcal{P}|}}\right) \\
\mathbf{0} & \mathbf{0} 
\end{pmatrix}
$$

---

# Evaluate $D\mathcal{F}$ at DFE

<style scoped>
@import url('https://unpkg.com/tailwindcss@^2/dist/utilities.min.css');
</style>

<div class="grid grid-cols-2 gap-4">
<div>

If $\Phi_p=\beta_pS_pI_p$, then
- $\dfrac{\partial\Phi_p}{\partial L_p}=0$
- $\dfrac{\partial\Phi_p}{\partial I_p}=\beta_pS_p$
</div>

<div>

If $\Phi_p=\beta_p\dfrac{S_pI_p}{N_p}$, then
- $\dfrac{\partial\Phi_p}{\partial L_p}=\beta_p\dfrac{S_pI_p}{N_p^2}=0$ at DFE
- $\dfrac{\partial\Phi_p}{\partial I_p}=\beta_p\dfrac{S_p}{N_p}$ at DFE
</div>
</div>

In both cases, $\partial/\partial L$ block is zero so
$$
F=D\mathcal{F}(DFE)=
\begin{pmatrix}
\mathbf{0} & \mathsf{diag}\left(
\frac{\partial\Phi_1}{\partial I_1},\ldots,\frac{\partial\Phi_{|\mathcal{P}|}}{\partial I_{|\mathcal{P}|}}\right) \\
\mathbf{0} & \mathbf{0}
\end{pmatrix}
$$

---

# Compute $D\mathcal{V}$ and evaluate at DFE

$$
V=
\begin{pmatrix}
\mathsf{diag}_p(\varepsilon_p+d_p)-\mathcal{M}^L & \mathbf{0} \\
-\mathsf{diag}_p(\varepsilon_p) & \mathsf{diag}_p(\gamma_p+d_p)-\mathcal{M}^I
\end{pmatrix}
$$
where $\mathsf{diag}_p(z_p)=\mathsf{diag}(z_1,\ldots,z_{|\mathcal{P}|})$. Inverse of $V$ easy ($2\times 2$ block lower triangular):
$$
V^{-1}
=
\begin{pmatrix}
\left(\mathsf{diag}_p(\varepsilon_p+d_p)-\mathcal{M}^L\right)^{-1} & \mathbf{0} \\
\tilde V_{21}^{-1} & \left(\mathsf{diag}_p(\gamma_p+d_p)-\mathcal{M}^I\right)^{-1}
\end{pmatrix}
$$
where
$$
\tilde V_{21}^{-1}=
\left(\mathsf{diag}_p(\varepsilon_p+d_p)-\mathcal{M}^L\right)^{-1} 
\mathsf{diag}_p(\varepsilon_p)
\left(\mathsf{diag}_p(\gamma_p+d_p)-\mathcal{M}^I\right)^{-1}
$$


---
# $\mathcal{R}_0$ as $\rho(FV^{-1})$

Next generation matrix
$$
FV^{-1}=
\begin{pmatrix}
\mathbf{0} & F_{12} \\
\mathbf{0} & \mathbf{0}
\end{pmatrix}
\begin{pmatrix}
\tilde V_{11}^{-1} & \mathbf{0} \\
\tilde V_{21}^{-1} & \tilde V_{22}^{-1}
\end{pmatrix}
=
\begin{pmatrix}
F_{12}\tilde V_{21}^{-1} & F_{12}\tilde V_{22}^{-1} \\
\mathbf{0} & \mathbf{0}
\end{pmatrix}
$$
where $\tilde V_{ij}^{-1}$ is block $ij$ in $V^{-1}$. So
$$
\mathcal{R}_0=\rho\left(F_{12}\tilde{V}_{21}^{-1}\right)
$$
i.e.,
$$
\mathcal{R}_0=\rho\Biggl(
\mathsf{diag}\left(
\frac{\partial\Phi_1}{\partial I_1},\ldots,\frac{\partial\Phi_{|\mathcal{P}|}}{\partial I_{|\mathcal{P}|}}\right)
\left(\mathsf{diag}_p(\varepsilon_p+d_p)-\mathcal{M}^L\right)^{-1} 
\mathsf{diag}_p(\varepsilon_p)
\left(\mathsf{diag}_p(\gamma_p+d_p)-\mathcal{M}^I\right)^{-1}
\Biggr)
$$


--- 

# Local asymptotic stability of the DFE

<div class="theorem">

Define $\mathcal{R}_0$ for the $|\mathcal{P}|$-SLIRS as 
$$
\mathcal{R}_0=\rho\Biggl(
\mathsf{diag}\left(
\frac{\partial\Phi_1}{\partial I_1},\ldots,\frac{\partial\Phi_{|\mathcal{P}|}}{\partial I_{|\mathcal{P}|}}\right)
\left(\mathsf{diag}_p(\varepsilon_p+d_p)-\mathcal{M}^L\right)^{-1}  
\mathsf{diag}_p(\varepsilon_p)
\left(\mathsf{diag}_p(\gamma_p+d_p)-\mathcal{M}^I\right)^{-1}
\Biggr)
$$
Then the DFE
$$
(\mathbf{S},\mathbf{L},\mathbf{I},\mathbf{R})=\left((\mathbf{d}-\mathcal{M}^S)^{-1}\mathbf{b},\mathbf{0},\mathbf{0},\mathbf{0}\right)
$$
is locally asymptotically stable if $\mathcal{R}_0<1$ and unstable if $\mathcal{R}_0>1$
</div>

<div style = "position: relative; bottom: -9%; font-size:20px;">

From PvdD & Watmough, [Reproduction numbers and sub-threshold endemic equilibria for compartmental models of disease transmission](https://doi.org/10.1016/S0025-5564(02)00108-6), *Bulletin of Mathematical Biology* **180**(1-2): 29-48 (2002)
</div>

---

# Global stability considerations

- GAS is much harder 
- It has been done many times (look at my papers, but also those of Li, Shuai, Thieme, van den Driessche, Wang, Zhao..)
- I am not aware of a way to do this *generically*

---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!--- fit ---> $\mathcal{R}_0$ is not the panacea 

# An urban centre and satellite cities

<div style = "position: relative; bottom: -30%; font-size:20px;">

JA & S Portet. [Epidemiological implications of mobility between a large urban centre and smaller satellite cities](https://server.math.umanitoba.ca/~jarino/papers/ArinoPortet-2015-JMB71.pdf). *Journal of Mathematical Biology* **71**(5):1243-1265 (2015)
</div>

---

# <!--fit-->Context of the study

Winnipeg as urban centre and 3 smaller satellite cities: Portage la Prairie, Selkirk and Steinbach

- population density low to very low outside of Winnipeg
- MB road network well studied by MB Infrastructure Traffic Engineering Branch

![bg right:57%](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/spatial/MB_highways.png)

---

# Known and estimated quantities

| City | Pop. (2014) | Pop. (now) | Dist. | Avg. trips/day |
|:------:|:------|:-------|:------|:------|
| Winnipeg (W) | 663,617 | 749,607 | - | - |
| Portage la Prairie (1) | 12,996 | 13,270 | 88 | 4,115 |
| Selkirk (2) | 9,834 | 10,504 | 34 | 7,983 |
| Steinbach (3) | 13,524 | 17,806 | 66 | 7,505 |

---

![bg contain 75%](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/satellite_cities/SIR_flow_diagram_UrbanCentre_Satellite.png)

---

# Estimating movement rates

Assume $m_{yx}$ movement rate from city $x$ to city $y$. *Ceteris paribus*, $N_x'=-m_{yx}N_x$, so $N_x(t)=N_x(0)e^{-m_{yx}t}$. Therefore, after one day, $N_x(1)=N_x(0)e^{-m_{yx}}$, i.e.,
$$
m_{yx}=-\ln\left(\frac{N_x(1)}{N_x(0)}\right)
$$
Now, $N_x(1)=N_x(0)-T_{yx}$, where $T_{yx}$ number of individuals going from $x$ to $y$ / day. So
$$
m_{yx}=-\ln\left(1-\frac{T_{yx}}{N_x(0)}\right)
$$
Computed for all pairs $(W,i)$ and $(i,W)$ of cities


---

# Sensitivity of $\mathcal{R}_0$ to variations of $\mathcal{R}_0^x\in[0.5,3]$

![width:800px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/satellite_cities/sensitivity_4cities.png)
*with disease*: $\mathcal{R}_0^x=1.5$; *without disease*: $\mathcal{R}_0^x=0.5$. Each box and corresponding whiskers are 10,000 simulations


---

# Lower connectivity can drive $\mathcal{R}_0$

PLP and Steinbach have comparable populations but with parameters used, only PLP can cause the general $\mathcal{R}_0$ to take values larger than 1 when $\mathcal{R}_0^W<1$

This is due to the movement rate: if $\mathcal{M}=0$, then
$$
\mathcal{R}_0=\max\{\mathcal{R}_0^W,\mathcal{R}_0^1,\mathcal{R}_0^2,\mathcal{R}_0^3\},
$$
since $FV^{-1}$ is then block diagonal

Movement rates to and from PLP are lower $\rightarrow$ situation closer to uncoupled case and $\mathcal{R}_0^1$ has more impact on the general $\mathcal{R}_0$

---

# $\mathcal{R}_0$ does not tell the whole story!

![width:550px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/satellite_cities/invasion_WPG_from_satellites_R01_m_caseR0W05_R0.png) ![width:550px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/satellite_cities/invasion_WPG_from_satellites_R01_m_caseR0W05_attackRate.png)
Plots as functions of $\mathcal{R}_0^1$ in PLP and the reduction of movement between Winnipeg and PLP. Left: general $\mathcal{R}_0$. Right: Attack rate in Winnipeg


---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!--- fit --->Problems specific to metapopulations

---

# Inherited dynamical properties (a.k.a. I am lazy)

Given
$$
\begin{align}
s_{kp}' &= f_{kp}(S_p,I_p) \tag{9a} \label{sys:generic_intra_ds} \\
i_{\ell p}' &= g_{\ell p}(S_p,I_p) \tag{9b} \label{sys:generic_intra_di}
\end{align}
$$
with known properties, what is known of
$$
\begin{align}
s_{kp}' &= f_{kp}(S_p,I_p)+\textstyle{\sum_{q\in\mathcal{P}}} m_{kpq}s_{kq} 
\tag{10a} \label{sys:generic_inter_ds} \\
i_{\ell p}' &= g_{\ell p}(S_p,I_p)+\textstyle{\sum_{q\in\mathcal{P}}} m_{\ell pq}i_{\ell q}
\tag{10b} \label{sys:generic_inter_di}
\end{align}
$$

- Existence and uniqueness $\checkmark$
- Invariance of $\mathbb{R}_+^\bullet$ under the flow $\checkmark$
- Boundedness $\checkmark$
- Location of individual $\mathcal{R}_{0i}$ and general $\mathcal{R}_0$?
- GAS?

---

# <!--fit-->An inheritance problem - Backward bifurcations

- Suppose a model that, isolated in a single patch, undergoes so-called backward bifurcations
- This means the model admits subthreshold endemic equilibria
- What happens when you couple many such consistuting units?


*YES*, coupling together backward bifurcating units can lead to a system-level backward bifurcation

JA, Ducrot & Zongo. [A metapopulation model for malaria with transmission-blocking partial immunity in hosts](https://server.math.umanitoba.ca/~jarino/papers/ArinoDucrotZongo-2011-JMB.pdf). *Journal of Mathematical Biology* **64**(3):423-448 (2012) 

---

# Metapopulation-induced behaviours ?

"Converse" problem to inheritance problem. Given
$$
\begin{align}
s_{kp}' &= f_{kp}(S_p,I_p)  \tag{9a} \\
i_{\ell p}' &= g_{\ell p}(S_p,I_p) \tag{9b}
\end{align}
$$
with known properties, does
$$
\begin{align}
s_{kp}' &= f_{kp}(S_p,I_p)+\textstyle{\sum_{q\in\mathcal{P}}} m_{kpq}s_{kq}  \tag{10a} \\
i_{\ell p}' &= g_{\ell p}(S_p,I_p)+\textstyle{\sum_{q\in\mathcal{P}}} m_{\ell pq}i_{\ell q}  \tag{10b}
\end{align}
$$
exhibit some behaviours not observed in the uncoupled system?

E.g.: units have $\{\mathcal{R}_0<1\implies$ DFE GAS, $\mathcal{R}_0>1\implies$ 1 GAS EEP$\}$ behaviour, metapopulation has periodic solutions


---

# Mixed equilibria

Can there be situations where some patches are at the DFE and others at an EEP?

This is the problem of **mixed equilibria**

This is a metapopulation-specific problem, not one of inheritance of dynamical properties!

---

# Types of equilibria

<div class="definition">

**[Patch level]** Patch $p\in\mathcal{P}$ at equilibrium is **empty** if $X_p^\star=0$, at the **disease-free equilibrium** if $X_p^\star=(s_{k_1p}^\star,\ldots,s_{k_up}^\star,0,\ldots,0)$, where $k_1,\ldots,k_u$ are some indices with $1\leq u\leq|\mathcal{U}|$ and $s_{k_1p}^\star,\ldots,s_{k_up}^\star$ are positive, and at an **endemic equilibrium** if $X_p\gg 0$
</div>

<p style="margin-bottom:1cm;"></p> 

<div class="definition">

**[Metapopulation level]** A **population-free equilibrium** has all patches empty. A **metapopulation disease-free equilibrium** has all patches at the disease-free equilibrium for the same compartments. A **metapopulation endemic equilibrium** has all patches at an endemic equilibrium
</div>

--- 

# Mixed equilibria

<div class="definition">

A **mixed equilibrium** is an equilibrium such that
- all patches are at a disease-free equilibrium but the system is not at a metapopulation disease-free equilibrium
- or, there are at least two patches that have different types of patch-level equilibrium (empty, disease-free or endemic)
</div>

<p style="margin-bottom:1cm;"></p> 

E.g., 
$$
((S_1,I_1,R_1),(S_2,I_2,R_2))=((+,0,0),(+,+,+))
$$
is mixed, so is
$$
((S_1,I_1,R_1),(S_2,I_2,R_2))=((+,0,0),(+,0,+))
$$


---

<div class="theorem">

Suppose that movement is similar for all compartments (MSAC) and that the system is at equilibrium

- If patch $p\in\mathcal{P}$ is empty, then all patches in $\mathcal{A}(p)$ are empty 
- If patch $p\in\mathcal{P}$ is at a disease free equilibrium, then the subsystem consisting of all patches in $\{p,\mathcal{A}(p)\}$ is at a metapopulation disease free equilibrium 
- If patch $p\in\mathcal{P}$ is at an endemic equilibrium, then all patches in $\mathcal{D}(p)$ are also at an endemic equilibrium
- If $\mathcal{G}^c$ is strongly connected for some compartment $c\in\mathcal{C}$, then there does not exist mixed equilibria
</div>

<p style="margin-bottom:1cm;"></p> 

Note that MSAC $\implies$ $\mathcal{A}^c=\mathcal{A}$ and $\mathcal{D}^c=\mathcal{D}$ for all $c\in\mathcal{C}$

---

# Interesting (IMHO) problems

More is needed on inheritance problem, in particular GAS part (Li, Shuai, Kamgang, Sallet, and older stuff: Michel & Miller, Šiljak)

Incorporate travel time (delay) and events (infection, recovery, death ..) during travel

What is the minimum complexity of the movement functions $m$ below
$$
\begin{aligned}
s_{kp}' &= f_{kp}(S_p,I_p)+\textstyle{\sum_{q\in\mathcal{P}}} m_{kpq}(S,I)s_{kq} \\
i_{\ell p}' &= g_{\ell p}(S_p,I_p)+\textstyle{\sum_{q\in\mathcal{P}}} m_{\ell pq}(S,I)i_{\ell q}
\end{aligned}
$$
required to observe a metapopulation-induced behaviour?

---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit -->Numerical investigations of large-scale systems

<div style = "position: relative; bottom: -40%; font-size:20px;">

- JA. [Spatio-temporal spread of infectious pathogens of humans](https://doi.org/10.1016/j.idm.2017.05.001). *Infectious Disease Modelling* **2**(2):218-228 (2017)
- JA. [Mathematical epidemiology in a data-rich world](https://doi.org/10.1016/j.idm.2019.12.008). *Infectious Disease Modelling* **5**:161-188 (2020)
- github repo [modelling-with-data](https://github.com/julien-arino/modelling-with-data)
</div>

---

# Not very difficult

- As for the mathematical analysis: if you do things carefully and think about things a bit, numerics are not hard. Well: not harder than numerics in low-D
- Exploit vector structure

---

# Set up parameters

```R
pop = c(34.017, 1348.932, 1224.614, 173.593, 93.261) * 1e+06
countries = c("Canada", "China", "India", "Pakistan", "Philippines")
T = matrix(data = 
             c(0, 1268, 900, 489, 200, 
               1274, 0, 678, 859, 150, 
               985, 703, 0, 148, 58, 
               515, 893, 144, 0, 9, 
               209, 174, 90, 2, 0), 
           nrow = 5, ncol = 5, byrow = TRUE)
```

---

# Work out movement matrix

```R
p = list()
# Use the approximation explained in Arino & Portet (JMB 2015)
p$M = mat.or.vec(nr = dim(T)[1], nc = dim(T)[2])
for (from in 1:5) {
  for (to in 1:5) {
    p$M[to, from] = -log(1 - T[from, to]/pop[from])
  }
  p$M[from, from] = 0
}
p$M = p$M - diag(colSums(p$M))
```

---

```R
p$P = dim(p$M)[1]
p$eta = rep(0.3, p$P)
p$epsilon = rep((1/1.5), p$P)
p$pi = rep(0.7, p$P)
p$gammaI = rep((1/5), p$P)
p$gammaA = rep((1/3), p$P)
# The desired values for R_0
R_0 = rep(1.5, p$P)
```

---

# <!--fit-->Write down indices of the different state variable types

Save index of state variable types in state variables vector (we have to use a vector and thus, for instance, the name "S" needs to be defined)

```R
p$idx_S = 1:p$P
p$idx_L = (p$P+1):(2*p$P)
p$idx_I = (2*p$P+1):(3*p$P)
p$idx_A = (3*p$P+1):(4*p$P)
p$idx_R = (4*p$P+1):(5*p$P)
```

---

# Set up IC and time

```R
# Set initial conditions. For example, we start with 2
# infectious individuals in Canada.
L0 = mat.or.vec(p$P, 1)
I0 = mat.or.vec(p$P, 1)
A0 = mat.or.vec(p$P, 1)
R0 = mat.or.vec(p$P, 1)
I0[1] = 2
S0 = pop - (L0 + I0 + A0 + R0)
# Vector of initial conditions to be passed to ODE solver.
IC = c(S = S0, L = L0, I = I0, A = A0, R = R0)
# Time span of the simulation (5 years here)
tspan = seq(from = 0, to = 5 * 365.25, by = 0.1)
```

---

# Set up $\beta$ to avoid blow up

Let us take $\mathcal{R}_0=1.5$ for patches in isolation. Solve $\mathcal{R}_0$ for $\beta$ 
$$
\beta=\frac{\mathcal{R}_0}{S(0)}
\left(
\frac{1-\pi_p}{\gamma_{Ip}}
+\frac{\pi_p\eta_p}{\gamma_{Ap}}
\right)^{-1}
$$ 

<p style="margin-bottom:2cm;"></p> 

```R
for (i in 1:p$P) {
  p$beta[i] = 
    R_0[i] / S0[i] * 1/((1 - p$pi[i])/p$gammaI[i] + p$pi[i] * p$eta[i]/p$gammaA[i])
}
```

---

# Define the vector field

```R
SLIAR_metapop_rhs <- function(t, x, p) {
  with(as.list(p), {
    S = x[idx_S]
    L = x[idx_L]
    I = x[idx_I]
    A = x[idx_A]
    R = x[idx_R]
    N = S + L + I + A + R
    Phi = beta * S * (I + eta * A) / N
    dS = - Phi + MS %*% S
    dL = Phi - epsilon * L + p$ML %*% L
    dI = (1 - pi) * epsilon * L - gammaI * I + MI %*% I
    dA = pi * epsilon * L - gammaA * A + MA %*% A
    dR = gammaI * I + gammaA * A + MR %*% R
    dx = list(c(dS, dL, dI, dA, dR))
    return(dx)
  })
}
```

---

# And now call the solver

```R
# Call the ODE solver
sol <- ode(y = IC, 
           times = tspan, 
           func = SLIAR_metapop_rhs, 
           parms = p,
           method = "ode45")
```

---

# One little trick (case with demography)

Suppose demographic EP is $\mathbf{N}^\star=(\mathbf{d}-\mathcal{M})^{-1}\mathbf{b}$

Want to maintain $\mathbf{N}(t)=\mathbf{N}^\star$ for all $t$ to ignore convergence to demographic EP. Think in terms of $\mathbf{b}$:

$$
\mathbf{N}'=0\iff \mathbf{b}-\mathbf{d}\mathbf{N}+\mathcal{M}\mathbf{N}=0 \iff \mathbf{b} = (\mathbf{d}-\mathcal{M})\mathbf{N}
$$

So take $\mathbf{b}=(\mathbf{d}-\mathcal{M})\mathbf{N}^\star$

Then
$$
\mathbf{N}' = (\mathbf{d}-\mathcal{M})\mathbf{N}^\star
-\mathbf{d}\mathbf{N}+\mathcal{M}\mathbf{N}
$$
and thus if $\mathbf{N}(0)=\mathbf{N}^\star$, then $\mathbf{N}'(0)=0$ and thus $\mathbf{N}'=0$ for all $t\geq 0$, i.e., $\mathbf{N}(t)=\mathbf{N}^\star$ for all $t\geq 0$

---

# Word of warning about that trick, though..

$$
\mathbf{b}=(\mathbf{d}-\mathcal{M})\mathbf{N}^\star
$$

$\mathbf{d}-\mathcal{M}$ has nonnegative (typically positive) diagonal entries and nonpositive off-diagonal entries

Easy to think of situations where the diagonal will be dominated by the off-diagonal, so $\mathbf{b}$ could have negative entries

$\implies$ use this for numerics, not for the mathematical analysis

---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!--- fit --->Epilogue / Postlude

---

# In conclusion

- Space is a fundamental component of the epidemic spread process and **cannot** be ignored, both in modelling **and** in public health decision making

- One way to model space is to use metapopulation models

- Metapopulation models are easy to analyse locally, give interesting problems at the global level


- We will see in [Practicum 02](https://julien-arino.github.io/3MC-course-epidemiological-modelling/2022_04_3MC_EpiModelling_P02_Analysis_LargeScaleModels.html) that simulation (deterministic and stochastic) can be costly in RAM and cycles but is easy

- Metapopulation models are not the only solution!

---

<!-- _backgroundImage: "linear-gradient(to bottom, #F45627, 20%, #F45627)" -->

# <!-- fit --> Merci / Miigwech / Thank you
