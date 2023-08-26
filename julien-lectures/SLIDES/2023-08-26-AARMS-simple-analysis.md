---
marp: true
title: Basic steps in an analysis of an epidemiological model
description: Julien Arino - 2023 AARMS Summer School - Basic steps in an analysis of an epidemiological model
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
# <!--fit-->Basic steps in an analysis of an epidemiological model

26 August 2023 

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

<!-- _backgroundImage: "radial-gradient(white,80%,#f1c40f)" -->
# Outline

- Steps of the analysis
- The basic stuff (well-posedness, DFE)
- Epidemic models
- Endemic models

---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!--fit-->Steps of the analysis

---

# Step 0 - Well-posedness

- Do solutions exist?
- Are they unique?
- Are they bounded?
- Invariance of the nonnegative cone under the flow..?

For "classic" models, all of these properties are more or less a given, so good to bear in mind, worth mentioning in a paper, but not necessarily worth showing unless this is a MSc or PhD manuscript

When you start considering nonstandard models, or PDE/DDE, then often required

---

# Step 1 - Epidemic model or endemic model ?

- Often a source of confusion: analysis of epidemic models differs from analysis of endemic models!!
- Important to determine what you are dealing with
- Easy first test (can be wrong): is there demography?
  - Demography can lead to constant population, but if there is "flow" through the system (with, e.g., births = deaths), then there is demography
- Other (more complex) test: what is the nature of the DFE?

---

# Step 1 and a half - Computing the DFE

- If you are not yet sure whether you have an epidemic or endemic model, you need to compute the DFE (you will need it/them anyway)
- **Usually**: set all *infected* variables to 0 (I, L and I, etc.)
  - If you find a single or denumerable number of equilibria for the remaining variables, this is an endemic model
  - If you get something of the form "any value of $S$ works", this is an epidemic model

---

# Step 2 - Epidemic case

- Compute $\mathcal{R}_0$
- Usually: **do not** consider LAS properties of DFE, they are given
- Compute a final size (if feasible)

# Step 2 - Endemic case

- Compute $\mathcal{R}_0$ and deduce LAS properties of DFE
- (Optional) Determine direction of bifurcation at $\mathcal{R}_0=1$
- (Sometimes impossible) Determine GAS properties of DFE or EEP

---

# <!--fit-->Why considering LAS properties of epidemic model is wrong

Consider the IVP
$$
x'=f(x),\qquad x(t_0)=x_0
$$
and denote $x(t,x_0)$ its solution at time $t\geq t_0$ through the initial condition $(t_0,x_0)$

$x^\star$ is an **equilibrium point** if $f(x^\star)=0$

$x^\star$ is locally asymptotically stable (LAS) if $\exists\mathcal{S}\ni x^\star$ open in the domain of $f$ s.t. for all $x_0\in\mathcal{S}$, $x(t,x_0)\in\mathcal{S}$ for all $t\geq 0$ and furthermore, $\lim_{t\to\infty}x(t,x_0)=x^\star$

If there is a continuum of equilibria, then $x^\star\in\mathcal{C}$, where $\mathcal{C}$ is some curve in the domain of $f$, s.t. $f(y^\star)=0$ for all $y^\star\in\mathcal{C}$. We say $x^\star$ is **not isolated**. But then any open neighbourhood of $x^\star$ contains elements of $\mathcal{C}$ and taking $x_0\in\mathcal{C}$, $x_0\neq x^\star$, implies that $\lim_{t\to\infty}x(t,x_0)=x_0\neq x^\star$. $x^\star$ is *locally stable* but not *locally asymptotically stable*!

---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!--fit-->The basic stuff (well-posedness, DFE)

---

# Existence and uniqueness

- Is your vector field $C^1$?
  - If so, you are done
  - If not, might be worth checking. Some of the models in particular have issues if the total population is variable and $N\to 0$ under circumstances
- Probably not worth more than "solutions exist and are unique" in most instances...

---

# Invariance of the nonnegative cone under the flow

- Study of this can be warranted
- What can be important is invariance of some subsets of the nonnegative cone under the flow of the system.. this can really help in some cases

---

# Example: SIS system

$$
\begin{align}
S' &= b-dS -\beta SI +\gamma I \tag{1a}\label{sys:SIS_base_dS}\\
I' &= \beta SI-dI-\gamma I \tag{1b}\label{sys:SIS_base_dI}
\end{align}
$$

First, remark that $\eqref{sys:SIS_base_dS}$-$\eqref{sys:SIS_base_dI}$ is $C^1$, giving existence and uniqueness of solutions

---

# Invariance of $\mathbb{R}_+^2$ under the flow of $\eqref{sys:SIS_base_dS}$-$\eqref{sys:SIS_base_dI}$

If $S=0$, then $\eqref{sys:SIS_base_dS}$ becomes
$$
S' = b+\gamma I >0
$$
$\implies$ $S$ cannot ever become zero: if $S(0)>0$, then $S(t)>0$ for all $t$. If $S(0)=0$, then $S(t)>0$ for $t>0$ small and by the preceding argument, this is also true for all $t>0$

---

For $I$, remark that if $I=0$, then $I'=0$ $\implies$ $\{I=0\}$ is positively invariant: if $I(0)=0$, then $I(t)=0$ for all $t>0$

In practice, values of $S(t)$ for any solution in $\{I=0\}$ are "carried" by one of the following 3 solutions:
1. $S(0)\in[0,b/d)$: increases to $S=b/d$
2. $S(0)=b/d$: remains equal to $b/d$
3. $S(0)>b/d$: decreases to $S=b/d$

As a consequence, no solution with $I(0)>0$ can enter $\{I=0\}$. Suppose $I(0)>0$ and $\exists t_*>0$ s.t. $I(t_*)=0$; denote $S(t_*)$ the value of $S$ when $I$ becomes zero

Existence of $t_*$ contradicts uniqueness of solutions, since at $(S(t_*),I(t_*))$, there are then two solutions: that initiated in $\{I=0\}$ and that initiated with $I(0)>0$

---

# Boundedness

$\implies$ positive quadrant $\mathbb{R}_+^2$ (positively) invariant under flow of $\eqref{sys:SIS_base_dS}$-$\eqref{sys:SIS_base_dI}$

We could detail more precisely (positive IC $\implies$..) but this suffices here

From the invariance dans the boundedness of the total population $N$, we deduce that solutions to $\eqref{sys:SIS_base_dS}$-$\eqref{sys:SIS_base_dI}$ are bounded

---

# Where things can become complicated...

$$
\begin{align}
S' &= bN-dS
-\beta \frac{SI}N
+\gamma I
\tag{2a}\label{sys:SIS_bad_dS}\\
I' &= \beta\frac{SI}{N}-dI-\gamma I
\tag{2b}\label{sys:SIS_bad_dI}
\end{align}
$$

- If $N\to 0$, e.g., $d>b$, what happens to the incidence?
- If $N\to\infty$, e.g., $b>d$, solutions are unbounded

---

# Computing the DFE

- Set all infected variables to zero, see what happens...
- Personnally: I prefer to set *some* infected variables to zero and see if I recuperate the DFE that way


---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!--fit-->Epidemic models

- Computation of $\mathcal{R}_0$
- Final size relation
- Examples

<div style = "position: relative; bottom: -25%; font-size:20px;">

Arino, Brauer, PvdD, Watmough & Wu. [A final size relation for epidemic models](https://julien-arino.github.io/assets/pdf/papers/ArinoBrauerVdDWatmoughWu-2007-MBE4.pdf). *Mathematical Biosciences and Engineering* **4**(2):159-175 (2007)
</div>



---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# <!--fit-->Computation of $\mathcal{R}_0$

---

# A method for computing $\mathcal{R}_0$ in epidemic models

- This method is not universal! It works in a relatively large class of models, but not everywhere. If it doesn't work, the next generation matrix method (see later) does work, **but** should be considered only for obtaining the reproduction number, not to deduce LAS (cf. my remark earler)
- Here, I change the notation in the paper, for convenience

---

# Standard form of the system 

Suppose system can be written in the form

$$
\begin{align}
\mathbf{S}' &= \mathbf{b}(\mathbf{S},\mathbf{I},\mathbf{R})-\mathbf{D}\mathbf{S}\beta(\mathbf{S},\mathbf{I},\mathbf{R})\mathbf{h}\mathbf{I} 
\tag{3a}\label{sys:SIR_general_dS} \\
\mathbf{I}' &= \mathbf{\Pi}\mathbf{D}\mathbf{S}\beta(\mathbf{S},\mathbf{I},\mathbf{R})\mathbf{h}\mathbf{I}-\mathbf{V}\mathbf{I} 
\tag{3b}\label{sys:SIR_general_dI} \\
\mathbf{R}' &= \mathbf{f}(\mathbf{S},\mathbf{I},\mathbf{R})+\mathbf{W}\mathbf{I}
\tag{3c}\label{sys:SIR_general_dR}
\end{align}
$$

where $\mathbf{S}\in\mathbb{R}^m$, $\mathbf{I}\in\mathbb{R}^n$ and $\mathbf{R}\in\mathbb{R}^k$ are susceptible, infected and removed compartments, respectively

IC are $\geq 0$ with at least one of the components of $\mathbf{I}(0)$ positive

---

$$
\tag{3a}
\mathbf{S}' = \mathbf{b}(\mathbf{S},\mathbf{I},\mathbf{R})-\mathbf{D}\mathbf{S}\beta(\mathbf{S},\mathbf{I},\mathbf{R})\mathbf{h}\mathbf{I}
$$
- $\mathbf{b}:\mathbb{R}_+^m\times\mathbb{R}_+^n\times\mathbb{R}_+^k\to\mathbb{R}^m$ continuous function encoding recruitment and death of uninfected individuals
- $\mathbf{D}\in\mathbb{R}^{m\times m}$ diagonal with diagonal entries $\sigma_i>0$ the relative susceptibilities of susceptible compartments, with convention that $\sigma_1=1$
- Scalar valued function $\beta:\mathbb{R}_+^m\times\mathbb{R}_+^n\times\mathbb{R}_+^k\to\mathbb{R}_+$ represents infectivity, with, e.g., $\beta(\mathbf{S},\mathbf{I},\mathbf{R})=\beta$ for mass action
- $\mathbf{h}\in\mathbb{R}^{n}$ row vector of relative horizontal transmissions

---

$$
\tag{3b}
\mathbf{I}' = \mathbf{\Pi}\mathbf{D}\mathbf{S}\beta(\mathbf{S},\mathbf{I},\mathbf{R})\mathbf{h}\mathbf{I}-\mathbf{V}\mathbf{I} \\
$$

- $\mathbf{\Pi}\in\mathbb{R}^{n\times m}$ has $(i,j)$ entry the fraction of individuals in $j^{\textrm{th}}$ susceptible compartment that enter $i^{\textrm{th}}$ infected compartment upon infection
- $\mathbf{D}\in\mathbb{R}^{m\times m}$ diagonal with diagonal entries $\sigma_i>0$ the relative susceptibilities of susceptible compartments, with convention that $\sigma_1=1$
- Scalar valued function $\beta:\mathbb{R}_+^m\times\mathbb{R}_+^n\times\mathbb{R}_+^k\to\mathbb{R}_+$ represents infectivity, with, e.g., $\beta(\mathbf{S},\mathbf{I},\mathbf{R})=\beta$ for mass action
- $\mathbf{h}\in\mathbb{R}^{n}$ row vector of relative horizontal transmissions
- $\mathbf{V}\in\mathbb{R}^{n\times n}$ describes transitions between infected states and removals from these states due to recovery or death

---

$$
\tag{3c}
\mathbf{R}' = \mathbf{f}(\mathbf{S},\mathbf{I},\mathbf{R})+\mathbf{W}\mathbf{I}
$$

- $\mathbf{f}:\mathbb{R}_+^m\times\mathbb{R}_+^n\times\mathbb{R}_+^k\to \mathbb{R}^k$ continuous function encoding flows into and out of removed compartments because of immunisation or similar processes
- $\mathbf{W}\in\mathbb{R}^{k\times n}$ has $(i,j)$ entry the rate at which individuals in the $j^{\textrm{th}}$ infected compartment move into the $i^{\textrm{th}}$ removed compartment

---

Suppose $\mathbf{E}_0$ is a locally stable disease-free equilibrium (DFE) of the system without disease, i.e., an EP of
$$
\begin{align*}
\mathbf{S}' &= \mathbf{b}(\mathbf{S},\mathbf{0},\mathbf{R}) \\
\mathbf{R}' &= \mathbf{f}(\mathbf{S},\mathbf{0},\mathbf{R}) \\
\end{align*}
$$

<div class="theorem">

Let
$$
\mathcal{R}_0 = 
\beta(\mathbf{S}_0,\mathbf{0},\mathbf{R}_0)
\mathbf{h}\mathbf{V}^{-1}
\mathbf{\Pi}\mathbf{D}\mathbf{S}_0
$$
- If $\mathcal{R}_0<1$, the DFE $\mathbf{E}_0$ is a locally asymptotically stable EP of $\eqref{sys:SIR_general_dS}$-$\eqref{sys:SIR_general_dR}$
- If $\mathcal{R}_0>1$, the DFE $\mathbf{E}_0$ of $\eqref{sys:SIR_general_dS}$-$\eqref{sys:SIR_general_dR}$ is unstable
</div>

If no demopgraphy (epidemic model), then just $\mathcal{R}_0$, of course

---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# <!--fit-->Final size relations

---

# Final size relations

Assume no demography, then system should be writeable as
$$
\begin{align}
\mathbf{S}' &= -\mathbf{D}\mathbf{S}\beta(\mathbf{S},\mathbf{I},\mathbf{R})\mathbf{h}\mathbf{I} 
\tag{4a}\label{sys:SIR_epi_dS} \\
\mathbf{I}' &= \mathbf{\Pi}\mathbf{D}\mathbf{S}\beta(\mathbf{S},\mathbf{I},\mathbf{R})\mathbf{h}\mathbf{I}-\mathbf{V}\mathbf{I} 
\tag{4b}\label{sys:SIR_epi_dI} \\
\mathbf{R}' &= \mathbf{W}\mathbf{I}
\tag{4c}\label{sys:SIR_epi_dR} 
\end{align}
$$
For $w(t)\in\mathbb{R}_+^n$ continuous, define
$$
w_\infty = \lim_{t\to\infty}w(t)\quad\text{and}\quad
\hat{w}=\int_0^\infty w(t)\ dt
$$

---

Define the row vector 
$$
\mathbb{R}^m\ni\mathbf{\Gamma}
=(\Gamma_1,\ldots,\Gamma_m)=\beta(\mathbf{S}_0,\mathbf{0},\mathbf{R}_0)\mathbf{h}\mathbf{V}^{-1}\mathbf{\Pi}\mathbf{D}
$$
then 
$$
\mathcal{R}_0=\mathbf{\Gamma}\mathbf{S}(0)
$$

---

Suppose incidence is mass action, i.e., $\beta(\mathbf{S},\mathbf{I},\mathbf{R})=\beta$ and $m>1$

Then for $i=1,\ldots,m$, express $\mathbf{S}_i(\infty)$ as a function of $\mathbf{S}_1(\infty)$ using
$$
\mathbf{S}_i(\infty)  = 
\mathbf{S}_i(0) \left(
\frac{\mathbf{S}_1(\infty)}{\mathbf{S}_1(0)}
\right)^{\sigma_i/\sigma_1}
$$
then substitute into 
$$
\frac{1}{\sigma_i}
\ln\left(\frac{\mathbf{S}_i(0)}{\mathbf{S}_i(\infty)}\right)
=
\mathbf{\Gamma}\mathbf{D}^{-1}\left(\mathbf{S}(0)-\mathbf{S}(\infty)\right)
+\beta\mathbf{h}\mathbf{V}^{-1}\mathbf{I}(0)
= 
\frac{1}{\sigma_1}
\ln\left(\frac{\mathbf{S}_1(0)}{\mathbf{S}_1(\infty)}\right)

$$
which is a final size relation for the general system when $\mathbf{S}_i(0)>0$

---

If incidence is mass action and $m=1$ (only one susceptible compartment), reduces to the KMK form
$$
\tag{5}\label{eq:final_size_m1}
\ln\left(
\frac{S_0}{S_\infty}
\right)
=\frac{\mathcal{R}_0}{S_0}
(S_0-S_\infty)+\beta\mathbf{h}\mathbf{V}^{-1}\mathbf{I}_0
$$

---

In the case of more general incidence functions, the final size relations are inequalities of the form, for $i=1,\ldots,m$,
$$
\ln\left(\frac{\mathbf{S}_i(0)}{\mathbf{S}_i(\infty)}\right)
\geq
\sigma_i\mathbf{\Gamma}\mathbf{D}^{-1}\left(\mathbf{S}(0)-\mathbf{S}(\infty)\right)
+\sigma_i\beta(K)\mathbf{h}\mathbf{V}^{-1}\mathbf{I}(0)
$$
where $K$ is the initial total population

---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# <!--fit-->Examples

--- 

# The SLIAR model

- Paper we have already seen:
  - Arino, Brauer, PvdD, Watmough & Wu. [Simple models for containment of a pandemic](http://dx.doi.org/10.1098/rsif.2006.0112) (2006)
- However, suppose additionally that $L$ are also infectious

---

![width:1200px center](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/SLIAR_infectiousL.png)

---

Here, $\mathbf{S}=S$, $\mathbf{I}=(L,I,A)^T$ and $\mathbf{R}=R$, so $m=1$, $n=3$ and 
$$
\mathbf{h}=[\varepsilon\; 1\; \delta],
\quad
\mathbf{D}=1,
\quad 
\mathbf{\Pi}
=\begin{pmatrix}
1 \\ 0 \\0
\end{pmatrix}
\quad\text{and}\quad
\mathbf{V}=
\begin{pmatrix}
\kappa & 0 & 0 \\
-p\kappa & \alpha & 0 \\
-(1-p)\kappa & 0 & \eta
\end{pmatrix}
$$
Incidence is mass action so $\beta(\mathbf{E}_0)=\beta$ and thus
$$
\begin{align}
\mathcal{R}_0
&=
\beta\mathbf{h}\mathbf{V}^{-1}\mathbf{\Pi}\mathbf{D}\mathbf{S}_0 \\
&=
\beta\;
[\varepsilon\; 1\; \delta]
\begin{pmatrix}
1/\kappa & 0 & 0 \\
p/\alpha & 1/\alpha & 0 \\
(1-p)/\eta & 0 & 1/\eta
\end{pmatrix}
\begin{pmatrix}
1 \\ 0 \\0
\end{pmatrix}
S_0 \\
&=
\beta S_0\left(
\frac{\varepsilon}{\kappa}
+\frac{p}{\alpha}
+\frac{\delta(1-p)}{\eta}
\right)
\end{align}
$$

---

For final size, since $m=1$, we can use $\eqref{eq:final_size_m1}$:
$$
\ln\left(
\frac{S_0}{S_\infty}
\right)
=\frac{\mathcal{R}_0}{S_0}
(S_0-S_\infty)+\beta\mathbf{h}\mathbf{V}^{-1}\mathbf{I}_0
$$
Suppose $\mathbf{I}_0=(0,I_0,0)$, then
$$
\ln\left(
\frac{S_0}{S_\infty}
\right)
=\mathcal{R}_0\frac{S_0-S_\infty}{S_0}
+\frac{\beta}{\alpha}I_0
$$
If $\mathbf{I}_0=(L_0,I_0,A_0)$, then
$$
\ln\left(
\frac{S_0}{S_\infty}
\right)
=\mathcal{R}_0\frac{S_0-S_\infty}{S_0}
+\beta\left(
\frac{\varepsilon}{\kappa}
+\frac{p}{\alpha}
+\frac{\delta(1-p)}{\eta}
\right)L_0
+\frac{\beta\delta}{\eta}A_0
+\frac{\beta}{\alpha}I_0
$$


---

# <!--fit-->A model with vaccination

Fraction $\gamma$ of $S_0$ are vaccinated before the epidemic; vaccination reduces probability and duration of infection, infectiousness and reduces mortality

$$
\begin{align}
S_U' &= -\beta S_U[I_U+\sigma_II_V] \\
S_V' &= -\sigma_S\beta S_V[I_U+\sigma_II_V] \\
L_U' &= \beta S_U[I_U+\sigma_II_V]-\kappa_UL_U\\
L_V' &= \sigma_S\beta S_V[I_U+\sigma_II_V]-\kappa_VL_V \\
I_U' &= \kappa_UL_U-\alpha_UI_U \\
I_V' &= \kappa_VL_V-\alpha_VI_V \\
R' &= f_U\alpha_UI_I+f_V\alpha_VI_V
\end{align}
$$
with $S_U(0)=(1-\gamma)S_0$ and $S_V(0)=\gamma S_0$

---

![bg contain](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/SLIR_epidemic_with_vaccination.png)

---

Here, $m=2$, $n=4$,
$$
\mathbf{h} = [0\;0\;1\;\sigma_I],\quad
\mathbf{D}=\begin{pmatrix}
1 & 0 \\ 0 & \sigma_S
\end{pmatrix},\quad
\mathbf{\Pi}=
\begin{pmatrix}
1 & 0 \\ 0 & 1 \\ 0 & 0 \\ 0 & 0
\end{pmatrix}
\quad\text{and}\quad
\mathbf{V}=
\begin{pmatrix}
\kappa_U & 0 & 0 & 0 \\
0 & \kappa_V & 0 & 0 \\
-\kappa_U & 0 & \alpha_U & 0 \\
0 & -\kappa_V & 0 & \alpha_V
\end{pmatrix}
$$
So
$$
\mathbf{\Gamma}=\left[
\frac{\beta}{\alpha_U}\; \frac{\sigma_I\sigma_S\beta}{\alpha_V}
\right],
\quad
\mathcal{R}_c = S_0\beta\left(
\frac{1-\gamma}{\alpha_U}+\frac{\sigma_I\sigma_S\gamma}{\alpha_V}
\right)
$$
and the final size relation is
$$
\begin{align}
\ln\left(
\frac{(1-\gamma)S_U(0)}{S_U(\infty)}
\right)
&= 
\frac{\beta}{\alpha_U}[(1-\gamma)S_U(0)-S_U(\infty)]
+\frac{\sigma_I\beta}{\alpha_V}[\gamma S_V(0)-S_V(\infty)]+\frac{\beta}{\alpha_U}I_0 \\
S_V(\infty) &= \gamma S_U(0)\left(
\frac{S_U(\infty)}{(1-\gamma)S_0}
\right)^{\sigma_S}
\end{align}
$$

---

# Where things go awry, final size-wise!

- Summer 2021 work of Aaron Shalev (U of M)
- Consider the very simple 2-patch metapopulation (see [Lecture 05](https://julien-arino.github.io/3MC-course-epidemiological-modelling/2022_04_3MC_EpiModelling_L05_MetapopulationModels.html))

$$
\begin{align*}
S_1' &= -\beta_1 S_1I_1 \\
I_1' &= \beta_1 S_1I_1-\gamma_1 I_1-m_{21}I_1 \\
R_1' &= \gamma_1I_1 \\
S_2' &= -\beta_2 S_2I_2 \\
I_2' &= \beta_2 S_2I_2-\gamma_2 I_2+m_{21}I_1 \\
R_2' &= \gamma_2I_2
\end{align*}
$$

- Unidirectional movement from patch 1 to patch 2
- $\mathbf{\beta}$ **cannot** be scalar-valued here!

---

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!--fit-->Endemic models

- Computation of $\mathcal{R}_0$ using the next generation matrix method
- Examples

---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# Computation of $\mathcal{R}_0$ using the next generation matrix method

---

# Next generation matrix/operator

Diekmann and Heesterbeek, characterised in ODE case by [PvdD & Watmough (2002)](https://doi.org/10.1016/S0025-5564(02)00108-6)

Consider only compartments $x$ with infected individuals and write
$$
x'=\mathcal{F}-\mathcal{V}
$$
 
- $\mathcal{F}$ flows into infected compartments because of new infections
- $\mathcal{V}$ other flows (with $-$ sign)

Compute the (Frechet) derivatives $F=D\mathcal{F}$ and $V=D\mathcal{V}$ with respect to the infected variables $x$ and evaluate at the DFE

Then
$$
\mathcal{R}_0=\rho(FV^{-1})
$$
where $\rho$ is the spectral radius

---

# Preliminary setup

$x=(x_1,\ldots,x_n)^T$, $x_i\geq 0$, with the first $m<n$ compartments the infected ones

$X_s$ the set of all disease free states: 
$$
X_s=\{x\geq 0| x_i=0, i=1,\ldots,m\}
$$

Distinguish new infections from all other changes in population
- $F_i(x)$ rate of appearance of new infections in compartment $i$
- $V_i^+(x)$ rate of transfer of individuals into compartment $i$ by all other means
- $V_i^-(x)$ rate of transfer of individuals out of compartment $i$

Assume each function continuously differentiable at least twice in each variable

$$
x_i' = f_i(x)=F_i(x)-V_i(x),\quad i=1,\ldots,n
$$
where $V_i=V_i^--V_i^+$

---

# Some assumptions


- **(A1)** If $x\geq 0$, then $F_i,V_i^+,V_i^-\geq 0$ for $i=1,\ldots,n$

> Since each function represents a directed transfer of individuals, all are non-negative


- **(A2)** If $x_i=0$ then $V_i^-=0$. In particular, if $x\in X_s$, then $V_i^-=0$ for $i=1,\ldots,m$

> If a compartment is empty, there can be no transfer of individuals out of the compartment by death, infection, nor any other means

---

- **(A3)** $F_i=0$ if $i>m$

> The incidence of infection for uninfected compartments is zero

- **(A4)** If $x\in X_s$ then $F_i(x)=0$ and $V_i^+(x)=0$ for $i=1,\ldots,m$

> Assume that if the population is free of disease then the population will remain free of disease; i.e., there is no (density independent) immigration of infectives

---

# One last assumption for the road

Let $x_0$ be a DFE of the system, i.e., a (locally asymptotically) stable equilibrium solution of the disease free model, i.e., the system restricted to $X_s$. We need not assume that the model has a unique DFE

Let $Df(x_0)$ be the Jacobian matrix $[\partial f_i/\partial x_j]$. Some derivatives are one sided, since $x_0$ is on the domain boundary

- **(A5)** If $F(x)$ is set to zero, then all eigenvalues of $Df(x_0)$ have negative real parts

Note: if the method ever fails to work, it is usually with (A5) that lies the problem

---

# Stability of the DFE as function of $\mathcal{R}_0$ 


<div align=justify 
style="background-color:#16a085;
border-radius:20px;
padding:10px 20px 10px 20px;
box-shadow: 0px 1px 5px #999;">

Suppose the DFE exists. Let then
$$
\mathcal{R}_0=\rho(FV^{-1})
$$
with matrices $F$ and $V$ obtained as indicated. Assume conditions (A1) through (A5) hold. Then
- if $\mathcal{R}_0<1$, then the DFE is LAS
- if $\mathcal{R}_0>1$, the DFE is unstable
</div>

Important to stress *local* nature of stability that is deduced from this result. We will see later that even when $\mathcal{R}_0<1$, there can be several positive equilibria

---

# Direction of the bifurcation at $\mathcal{R}_0=1$

$\mu$ bifurcation parameter s.t. $\mathcal{R}_0<1$ for $\mu<0$ and $\mathcal{R}_0>1$ for $\mu>0$ and $x_0$ DFE for all values of $\mu$ and consider the system
$$
\tag{6}\label{eq:sys_PvdDW}
x'=f(x,\mu)
$$

Write 
$$
D_xf(x_0,0)=
\left. 
  D(\mathcal{F}(x_0)-\mathcal{V}(x_0))
\right|_{\mathcal{R}_0=1}
$$
as block matrix
$$
D\mathcal{F}(x_0)
=\begin{pmatrix}
F & 0 \\ 0 & 0
\end{pmatrix},
\quad
D\mathcal{V}(x_0)
=\begin{pmatrix}
V & 0 \\ J_3 & J_4
\end{pmatrix}
$$

---

Write $[\alpha_{\ell k}]$, $\ell=m+1,\ldots,n$, $k=1,\ldots,m$ the $(\ell-m,k)$ entry of $-J_4^{-1}J_3$ and let $v$ and $w$ be left and right eigenvectors of $D_xf(x_0,0)$ s.t. $vw=1$

Let
$$
\tag{7}\label{eq:PvdDW_a}
a =\sum_{i,j,k=1}^m
v_iw_jw_k
\left(
\frac 12 
\frac{\partial^2f_i}{\partial x_j\partial x_k}(x_0,0)
+\sum_{\ell=m+1}^n
\alpha_{\ell k}
\frac{\partial^2f_i}{\partial x_j\partial x_\ell}(x_0,0)
\right)
$$

$$
\tag{8}\label{eq:PvdDW_b}
b
=vD_{x\mu}f(x_0,0)w
=\sum_{i,j=1}^n v_iw_j
\frac{\partial^2f_i}{\partial x_j\partial\mu}
(x_0,0)
$$

---

<div class="theorem">

Consider model $\eqref{eq:sys_PvdDW}$ with $f(x,\mu)$ satisfying conditions (A1)–(A5) and $\mu$ as described above

Assume that the zero eigenvalue of $D_xf(x_0,0)$ is simple

Define $a$ and $b$ by $\eqref{eq:PvdDW_a}$ and $\eqref{eq:PvdDW_b}$; assume that $b\neq 0$. Then $\exists\delta > 0$ s.t.
- if $a < 0$, then there are LAS endemic equilibria near $x_0$ for $0 < \mu < \delta$
- if $a > 0$, then there are unstable endemic equilibria near $x_0$ for $-\delta < \mu < 0$
</div>

---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# <!--fit-->Examples

- The SLIRS model
- A tuberculosis model incorporating treatment
- An "issue" with the next generation method for $\mathcal{R}_0$
- Bistable states

---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# The SLIRS model

---

# Example of the SLIRS model

Variations of the infected variables described by
$$
\begin{align*}
L' &= f(S,I,N)-(\varepsilon+d) L \\
I' &= \varepsilon L -(d+\gamma) I
\end{align*}
$$
Thus
$$
\left(
\begin{matrix}
L \\
I
\end{matrix}
\right)'
=\left(
\begin{matrix}
f(S,I,N) \\
0
\end{matrix}
\right)
-
\left(
\begin{matrix}
(\varepsilon+d) L \\
(d+\gamma) I-\varepsilon L
\end{matrix}
\right)=\mathcal{F}-\mathcal{V}
$$

---

Then compute the Jacobian matrices of vectors $\mathcal{F}$ and $\mathcal{V}$
$$
F=\left(
\begin{matrix}
\dfrac{\partial\overline{f}}{\partial L}
& \dfrac{\partial\overline{f}}{\partial I} \\
0 & 0
\end{matrix}
\right),\quad
V=\left(
\begin{matrix}
\varepsilon+d & 0 \\
-\varepsilon & d+\gamma
\end{matrix}
\right)
$$
where
$$
\frac{\partial\overline{f}}{\partial I}:=
\frac{\partial f}{\partial I}(\bar
S,\bar I,\bar N)\quad\quad 
\frac{\partial\overline{f}}{\partial L}:=
\frac{\partial f}{\partial L}(\bar
S,\bar I,\bar N)
$$

---

We have
$$
V^{-1}=\dfrac{1}{(d+\varepsilon)(d+\gamma)}
\left(
\begin{matrix}
d+\gamma & 0 \\
\varepsilon & d+\varepsilon
\end{matrix}
\right)
$$

Also, when $N$ constant, $\partial f/\partial
L=0$, then
$$
FV^{-1}=\dfrac{{\partial\overline{f}}/{\partial I}}
{(d+\varepsilon)(d+\gamma)}
\left(
\begin{matrix}
\varepsilon 
& d+\varepsilon  \\
0 & 0
\end{matrix}
\right)
$$
and thus,
$$
\mathcal{R}_0=\varepsilon
\dfrac{{\partial\overline{f}}/{\partial I}}
{(d+\varepsilon)(d+\gamma)}
$$

---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# A tuberculosis model incorporating treatment

- While undergoing treatment, individuals can be infected

<div style = "position: relative; bottom: -40%; font-size:20px;">

C$^3$ & Feng. [To treat or not to treat: the case of tuberculosis](https://doi.org/10.1007/s002850050069). *Journal of Mathematical Biology* **35**: 629-656 (1997).
</div>

---

![bg contain](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/SLIT.png)

---

$$
\begin{align}
S' &= b(N)-dS-\beta_1\frac{SI}{N}
\tag{9a}\label{sys:SLIT_dS} \\
L' &= \beta_1\frac{SI}{N}
+\beta_2\frac{TI}{N}-(d+\nu+r_1)L+pr_2I 
\tag{9b}\label{sys:SLIT_dL} \\
I' &= \nu L-(d+r_2)I
\tag{9c}\label{sys:SLIT_dI} \\
T' &= r_1L+qr_2I-dT-\beta_2\frac{TI}{N}
\tag{9d}\label{sys:SLIT_dT} 
\end{align}
$$
with $p=1-q$

DFE is $x_0=(S^\star,0,0,0)$ with $S^\star$ solution to $b(S^\star)=dS^\star$ (so there must hold that $b'(S^\star)<d$)

Assume without loss of generality that $S^\star=1$

---

$$
\mathcal{F}=\begin{pmatrix}
0 \\
\beta_1\frac{SI}{N}+\beta_2\frac{TI}{N} \\
0 \\ 0 
\end{pmatrix}
\quad\text{and}\quad
\mathcal{V}=\begin{pmatrix}
-b(N)+dS+\beta_1\frac{SI}{N} \\
(d+\nu+r_1)L-pr_2 I \\
-\nu L+(d+r_2)I \\
dT-r_1L-qr_2I+\beta_2\frac{TI}{N}
\end{pmatrix}
$$
So
$$
F=\begin{pmatrix}
0 & \beta_1 \\
0 & 0
\end{pmatrix}
\quad\text{and}\quad
V=\begin{pmatrix}
d+\nu+r_1 & -pr_2 \\
-\nu & d+r_2
\end{pmatrix}
$$
and
$$
\mathcal{R}_0
=\frac{\beta_1\nu}
{(d+\nu+r_1)(d+r_2)-\nu pr_2}
$$

---

# Effect of another choice of $\mathcal{F}$ (1)

$$
\mathcal{F}=\begin{pmatrix}
0 \\
\beta_1\frac{SI}{N}+\beta_2\frac{TI}{N} +pr_2I \\
0 \\ 0 
\end{pmatrix}
\quad\text{and}\quad
\mathcal{V}=\begin{pmatrix}
-b(N)+dS+\beta_1\frac{SI}{N} \\
(d+\nu+r_1)L \\
-\nu L+(d+r_2)I \\
dT-r_1L-qr_2I+\beta_2\frac{TI}{N}
\end{pmatrix}
$$
So
$$
F=\begin{pmatrix}
0 & \beta_1+pr_2 \\
0 & 0
\end{pmatrix}
\quad\text{and}\quad
V=\begin{pmatrix}
d+\nu+r_1 & -pr_2 \\
-\nu & d+r_2
\end{pmatrix}
$$
and
$$
\mathcal{R}_0
=\frac{\beta_1\nu+pr_2\nu}
{(d+\nu+r_1)(d+r_2)}
$$

---

# Effect of another choice of $\mathcal{F}$ (2)

$$
\mathcal{F}=\begin{pmatrix}
0 \\
\beta_1\frac{SI}{N}+\beta_2\frac{TI}{N}+pr_2I \\
\nu L \\ 0 
\end{pmatrix}
\quad\text{and}\quad
\mathcal{V}=\begin{pmatrix}
-b(N)+dS+\beta_1\frac{SI}{N} \\
(d+\nu+r_1)L \\
(d+r_2)I \\
dT-r_1L-qr_2I+\beta_2\frac{TI}{N}
\end{pmatrix}
$$
So
$$
F=\begin{pmatrix}
0 & \beta_1+pr_2 \\
\nu & 0
\end{pmatrix}
\quad\text{and}\quad
V=\begin{pmatrix}
d+\nu+r_1 & 0 \\
0 & d+r_2
\end{pmatrix}
$$
and
$$
\mathcal{R}_0
=
\sqrt{\frac{\beta_1\nu+pr_2\nu}
{(d+\nu+r_1)(d+r_2)}}
$$

---

$J_1$ has a simple zero eigenvalue when $\mathcal{R}_0=1$. All second derivatives of $f$ are zero at the DFE except
$$
\frac{\partial^2 f_1}{\partial L\partial I}
=-\beta_1,
\quad
\frac{\partial^2 f_1}{\partial I^2}
=-2\beta_1,
\quad
\frac{\partial^2 f_1}{\partial I\partial T}
=\beta_2-\beta_1,
$$
So
$$
a=-\beta_1v_1w_2(w_1+w_2+(1-\beta_2/\beta_1)w_4)
$$
where the eigenvectors $v$ and $w$ can be chosen so that $w\gg 0$ and $v_1>0$

Typically, $\beta_2<\beta_1$ so $a<0$ $\implies$ bifurcation is forward

---

# A slight change to the model

$$
\begin{align}
S' &= b(N)-dS-\beta_1\frac{SI}{N}
\tag{10a}\label{sys:SLIT2_dS} \\
L' &= \beta_1\frac{SI}{N}
+\beta_2\frac{TI}{N}-\beta_3\frac{LI}{N}-(d+\nu+r_1)L+pr_2I 
\tag{10b}\label{sys:SLIT2_dL} \\
I' &= \beta_3\frac{LI}{N}+\nu L-(d+r_2)I
\tag{10c}\label{sys:SLIT2_dI} \\
T' &= r_1L+qr_2I-dT-\beta_2\frac{TI}{N}
\tag{10d}\label{sys:SLIT2_dT} 
\end{align}
$$

<div style = "position: relative; bottom: -40%; font-size:20px;">

Feng, C$^3$ & Capurro. [A Model for Tuberculosis with Exogenous Reinfection](https://doi-org.uml.idm.oclc.org/10.1006/tpbi.2000.1451). *Theoretical Population Biology* **57**(3): 235-247 (2000)
</div>

---

![bg contain](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/SLIT_reinfection.png)

---

With this change
$$
a=-\beta_1v_1w_2(w_1+w_2+(1-\beta_2/\beta_1)w_4)
+\beta_3w_1w_2(v_2-v_1)
$$
where it can be shown that $v_2-v_1>0$

Therefore, there are situations when $a>0$, i.e., there can be backward bifurcations

---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# <!--fit-->An "issue" with the next generation method for $\mathcal{R}_0$

# (Malaria model with transgenic vectors)

<div style = "position: relative; bottom: -40%; font-size:20px;">

JA, Bowman, Gumel & Portet. [Effect of pathogen-resistant vectors on the transmission dynamics of a vector-borne disease](http://dx.doi.org/10.1080/17513750701605614). *Journal of Biological Dynamics* **1**:320-346 (2007)
</div>

---

# Foreword

- This is not an issue with the method itself, but an illustration of the reason why it is important to check that (A1)-(A5) are satisfied when using the next generation matrix method of [PvdD & Watmough (2002)](https://doi.org/10.1016/S0025-5564(02)00108-6)

---

![bg contain 75%](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/flow_diagram_transgenic_mosquitoes.jpg)

---


# Hypotheses about mosquitoes

- **H1** Resistant vectors are completely immune to the pathogen
- **H2-a**  A proportion $p_1$ of the offspring resulting from the interbreeding of wild and resistant vectors are resistant to the pathogen
- **H2-b**  A proportion $p_2$$ of the offspring resulting from inbreeding within the resistant type are resistant to the pathogen
- **H3** In the absence of disease, wild vectors are better fitted for competition than resistant vectors
- **H4** Wild vectors are ill-fitted for competition when they carry the disease

---

# The model

$$
\begin{align}
S' &= B_W(S,I,T) - (d_W+\kappa_SV)S-f_V \\
I' &= f_V-(d_W+\delta_W+\kappa_IV)I \\
T' &= B_T(S,I,T)-(d_T+\kappa_TV)T \\
S_H' &= \Pi+\nu R_H-f_H-d_HS_H \\
I_H' &= f_H-(d_H+\delta_H+\gamma)I_H \\
R_H' &= \gamma I_H-(d_H+\nu)R_H
\end{align}
$$

- $f_V,f_H\in C^1$
- $f_V,f_H\geq 0$
- $f_V=0$ if $S=0$ or $I_H=0$
- $f_H=0$ if $S_H=0$ or $I=0$

---

# Coexistence of vectors

- Can wild type and transgenic vectors coexist?

$$
\begin{align}
S' &= \frac{\alpha_1}{2}S+(1-p_2)\frac{\alpha_3}{2}T
+(1-p_1)\alpha_5\frac{ST}{S+T}
-(d_W+\kappa_S(S+T))S \\
T' &= p_2\frac{\alpha_3}{2}T
+p_1\alpha_5\frac{ST}{S+T}
-(d_T+\kappa_T(S+T))T
\end{align}
$$

Fitness (from undetailed assumptions, $\mathbb{F}_S\geq\mathbb{F}_T$):
$$
\mathbb{F}_S=
\frac{\alpha_1-2d_W}{2\kappa_S}
\quad\textrm{and}\quad
\mathbb{F}_T=
\frac{p_2\alpha_3-2d_T}{2\kappa_T}
$$

Find 2 boundary EP $\bar E_0=(S,T)=(0,0)$ and $\bar E_W=(S,T)=(\mathbb{F}_S,0)$ and one coexistence EP $\bar E_C$. If there is no loss of resistance in offspring of two resistant parents ($p_2=1$), then there is another boundary EP $\bar E_T=(0,\mathbb{F}_T)$

---

![bg contain](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/transgenic_mosquitoes_stability_regions.jpg)

---

# Where the problem arises

There are up to 4 EPs for vectors and these are independent from the host population in the case when disease is absent

$\implies$ the whole coupled system with vectors *and* hosts has up to 4 DFE

We can use the method of [PvdD & Watmough (2002)](https://doi.org/10.1016/S0025-5564(02)00108-6) at each of these DFE to get the local stability properties of these DFE

At $\bar E_0$, we find $\mathcal{R}_0=0$, which makes no sense. What's wrong?

Problem is with (A5): compute Jacobian of $(S,T)$ system and evaluate at $\bar E_0$, we get e-values $\lambda_1=\kappa_S\mathbb{F}_S>0$ and $\lambda_2=\kappa_T\mathbb{F}_T$, so $\bar E_0$ is always unstable $\implies$ (A5) cannot be satisfied at $\bar E_0$ and the LAS condition provided by [PvdD & Watmough (2002)](https://doi.org/10.1016/S0025-5564(02)00108-6) is not usable

---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# <!--fit-->Bistable states

# Undesired effect of vaccination

<div style = "position: relative; bottom: -30%; font-size:20px;">

Arino, McCluskey & PvdD. [Global results for an epidemic model with vaccination that exhibits backward bifurcation](http://dx.doi.org/10.1137/S0036139902413829). SIAM J Applied Math (2003)

</div>

---

# Another SIRS model with vaccination

![width:1000px center](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/SIRV_newborns.png)

---

# SIRSV epidemic model

$$
\begin{align}
S' &= (1-\alpha)dN-dS-\beta\frac{SI}{N}-\phi S+\theta
V+\nu R \qquad\qquad\\
I' &= \beta\frac{SI}{N}
+\sigma\beta\frac{VI}{N} -(d+\gamma)I \\
R' &= \gamma I-(d+\nu)R \\
V' &= \alpha dN+\phi S-(d+\theta)V
-\sigma\beta\frac{VI}{N} 
\end{align}
$$

- $\alpha$ proportion of newborns vaccinated
- $\phi$ vaccination rate of susceptibles
- $\theta$ rate of vaccine efficacy loss
- $1-\sigma$ vaccine efficacy


---

Since the total population is constant, the system in proportions takes the form
$$
\begin{align}
S' &= (1-\alpha)d-dS-\beta SI-\phi S+\theta
(1-S-I-R)+\nu R \\
I' &= \beta SI
+\sigma\beta(1-S-I-R)I -(d+\gamma)I \\
R' &= \gamma I-(d+\nu)R \\
V &= 1-(S+I+R)
\end{align}
$$
where $S$, $I$, $R$, $V$ are the proportions of individuals who are in the susceptible, infectious, recovered and vaccinated, respectively

---

# Equilibrium and bifurcations

The system always has the DFE
$$
(S,I,R,V)=\left(
\frac{\theta+d(1-\alpha)}{d+\theta+\phi},0,0,
\frac{\phi+d\alpha}{d+\theta+\phi}
\right)
$$

We now consider endemic equilibria with $I=I^\star >0$

When $\sigma=0$ (vaccine 100% efficacious), there is at most one endemic equilibrium. From now on, assume (realistic) that $0<\sigma<1$, i.e., vaccine is not 100% efficacious

---

# Existence of endemic equilbria

The existence of endemic equilibria is determined by the number of positive roots of the polynomial
$$
P(I)=AI^2+BI+C
$$
where
$$
A=-\sigma\beta^2\frac{d+\nu+\gamma}{d+\nu}<0
$$
$$
B=\sigma\beta^2-\beta(d+\theta+\sigma(d+\gamma+\phi))
-\frac{\beta\gamma}{d+\nu}(d+\theta+\sigma\phi)
$$
$$
C=(d+\theta+\sigma\phi-d\alpha(1-\sigma))\beta
-(d+\gamma)(d+\theta+\phi)
$$

---

# Case of a forward bifurcation

![width:550px](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/PI_vs_I_forward.png)  ![width:550px](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/SIRV_bif_forward.png)


---

# Case of a backward bifurcation

![width:550px](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/PI_vs_I_backward.png)  ![width:550px](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/SIRV_bif_backward.png)

---

# Bistable region
 
- Concavity of the curve is fixed (since $A<0$), so a necessary condition for existence of two endemic equilibria is: 
  - $P'(0)=B>0$ and $P(0)=C<0$
  - The roots of $P(I)$ must be real

$\implies$ region of bistability is $\Delta=B^2-4AC\geq 0$, $B>0$ and $C<0$

---

# Bifurcation in the $(\sigma,\phi)$ plane

![width:800px center](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/bif_sigma_vs_phi.png)

---

# EEP

If there are such solutions $I^\star$ to $P(I)=0$ (potentielly a double root), EEP  are $(S,I,R,V)=$

$$
\left(
\frac{(1-\alpha)d+\frac{(\nu-\theta)\gamma
    I^\star }{d+\nu}+(1-I^\star )\theta}{d+\beta
  I^\star +\phi+\theta},I^\star ,\frac{\gamma
  I^\star }{d+\nu},1-S^\star -I^\star -R^\star  
\right)
$$

---

# $\mathcal{R}_0$

Using the next generation method, the reproduction number (with vaccination) is

$$
\mathcal{R}_\phi=\mathcal{R}_0
\frac{d+\theta+\sigma\phi-d\alpha(1-\sigma)}{d+\theta+\phi}
$$
where
$$
\mathcal{R}_0=\frac{\beta}{d+\gamma}
$$
and as a consequence
$$
\mathcal{R}
(\alpha,\phi,1,\theta)=\mathcal{R}_0
$$

---

# Stability - DFE
 
- Using a theorem of PvdD & Watmough (2002), the DFE is
  - locally asymptotically stable for $\mathcal{R}_\phi<1$
  - unstable for $\mathcal{R}_\phi>1$
- Furthermore, when $\mathcal{R}_0<1$, using $I$ as a Lyapunov function, it is easily shown the the DFE is globally asymptotically stable

---

# Local stability - EEP

Linearising  at the EEP
 
- at the smaller $I$, Jacobian matrix has negative trace and positive determinant $\implies$ one of the eigenvalues is positive and the lower bifurcating branch is unstable
- On the upper branch, conclude from linearisation that there is either one or three eigenvalues with nonpositive real part $\implies$ stability is undetermined. From numerical investigations, the upper branch seems locally stable

---

# Spectral abscissa at the EP

Spectral abscissa $s(J)$ (maximum of real parts of eigenvalues) of the linearisation at the DFE and the 2 EEP, when $\theta$ varies

![width:600px center](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/evalues_SIRbif.png)



---

# Global behaviour

<div class="theorem">

Suppose that in the system, parameters satisfy
$$
\begin{aligned}
  \theta &< d + 2 \nu                   \\
2 \gamma &< d + \phi + \theta + \nu     \\
  \gamma &< d + \phi + \nu
\end{aligned}
$$
Then all positive semi-trajectories in $\bar D$, where
$$
D=\{(S,I,R): S,R\geq 0, I>0, S+I+R\leq 1\}
$$
limit to a unique equilibrium point
</div>

