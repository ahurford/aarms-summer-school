---
marp: true
title: Stochastic epidemiological models
description: Julien Arino - 2023 AARMS Summer School - Stochastic epidemiological models
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
# Stochastic epidemiological models

24 August 2023 

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

- Why stochasticity matters
- Side note: sojourn times / residence times
- Discrete time Markov chains
- Continuous time Markov chains

---

# Remarks / Resources

This is a *user-oriented* course: I barely touch on the algorithms; instead, I focus on how to use them

Code is available in [my subfolder in the course Github repo](https://github.com/ahurford/aarms-summer-school/tree/main/julien-lectures) in the CODE directory

Some of the slides are inspired from slides given to me by Linda Allen (Texas Tech) and Frank Ball (University of Nottingham). I recommend books and articles by Linda for more detail
- [An Introduction to Stochastic Processes with Applications to Biology](https://www.routledge.com/An-Introduction-to-Stochastic-Processes-with-Applications-to-Biology/author/p/book/9781439894682)
- [A primer on stochastic epidemic models: Formulation, numerical simulation, and analysis](https://doi.org/10.1016/j.idm.2017.03.001)

--- 

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit -->Why stochasticity matters

---

# Running example - SIS model without demography

Constant total population $P^\star$

<span style="display: block; margin-left: auto; margin-right: auto; width: 25%">![width:400px](figure_SIS_base_no_demography.png)</span>

Basic reproduction number:
$$\mathcal{R}_0 = \dfrac{\beta}{\gamma}P^\star$$

---

# In the deterministic world, $\mathcal{R}_0$ rules the world

- If $\mathcal{R}_0=\beta P^\star/\gamma<1$, the disease dies out (*disease-free* equilibrium)
- If $\mathcal{R}_0>1$, it becomes established at an *endemic* equilibrium $I^\star=P^\star-\gamma/\beta=(1-1/\mathcal{R}_0)P^\star$

Next slides: $P^\star = 100$K, $\gamma=1/5$, $\mathcal{R}_0=\{0.8,1.5,2.5\}$ (and $\beta=\gamma \mathcal{R}_0/P^\star$)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/stochastic/ODE_SIS.png)

---

# <!--fit-->In stochastic world, make that ''$\mathcal{R}_0$ rules-*ish*'' ($\mathcal{R}_0=1.5$)

![height:600px center](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/stochastic/several_CTMC_sims.png)

---

# <!--fit-->When $I_0=2$, extinctions happen quite frequently

![height:600px](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/stochastic/extinctions_fct_R0.png)

---

# Types of stochastic systems discussed today

- Discrete-time Markov chains (DTMC)
- Continuous-time Markov chains (CTMC)

But there are many others. Of note: 
- Branching processes (BP)
- Stochastic differential equations (SDE)

--- 

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit -->Side note: sojourn times / residence times

# Some probability theory

Suppose that a system can be in two states, $S_1$ and $S_2$

- At time $t=0$, system is in state $S_1$
- An event happens at some time $t=\tau$, which triggers the switch from state $S_1$ to state $S_2$

A **random variable** is a variable that takes random values, that is, a mapping from random experiments to numbers

Let us call $T$ the random variable 
> time spent in state $S_1$ before switching into state $S_2$

---

States can be anything:

- $S_1$: working, $S_2$: broken;
- $S_1$: infected, $S_2$: recovered;
- $S_1$: alive, $S_2$: dead;
- $\ldots$

We take a collection of objects or individuals in state $S_1$ and want some law for the **distribution** of the times spent in $S_1$, i.e., a law for $T$

For example, we make light bulbs and would like to tell our customers that on average, our light bulbs last 200 years..

For this, we conduct an **infinite** number of experiments, and observe the time that it takes, in every experiment, to switch between $S_1$ and $S_2$

From this, deduce a *model*, which in this context is called a **probability distribution**

---

![bg contain](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/random_length_sample.png)

---

# Discrete vs continuous random variables

We assume that $T$ is a **continuous** random variable, that is, $T$ takes continuous values. Examples of continuous r.v.: 

- height or age of a person (if measured very precisely)
- distance
- time


Another type of random variables are **discrete** random variables, which take values in a denumerable set. Examples of discrete r.v.:

- heads or tails on a coin toss
- the number rolled on a dice
- height of a person, if expressed rounded without subunits, age of a person in years (without subunits)

---

# Probability

A **probability** is a function $\mathcal{P}$, from a probability space to $[0,1]$

Formally: $(\Omega,\mathcal{F},\mathcal{P})$ is a probability space, with $\Omega$ the **sample** space, $\mathcal{F}$ a $\sigma$-algebra of subsets of $\Omega$ whose elements are the **events**, and $\mathcal{P}$ a **measure** from $\mathcal{F}$ to $[0,1]$ such that $\mathcal{P}(E)\geq 0$, $\forall E\subset\Omega$, $\mathcal{P}(\Omega)=1$ and $\mathcal{P}(E_1\cup E_2\cup\cdots)=\sum_i\mathcal{P}(E_i)$

Gives the likelihood of an event occurring, among all the events that are possible, in that particular setting. For example, $\mathbb{P}(\textrm{getting heads when tossing a coin})=1/2$ and $\mathbb{P}(\textrm{getting tails when tossing a coin})=1/2$

---

# Probability density function

Assume $T$ continuous; it has a continuous **probability density function** $f$

- $f\geq 0$
- $\int_{-\infty}^{+\infty}f(s)ds=1$
- $\mathbb{P}(a\leq T\leq b)=\int_a^bf(t)dt$

![width:450px center](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/distrib_a_b.png)

---

# Cumulative distribution function

The cumulative distribution function (c.d.f.) is a function $F(t)$ that characterizes the distribution of $T$, and defined by
$$
F(s)=\mathbb{P}(T\leq s)=\int_{-\infty}^sf(x)dx
$$

![width:500px center](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/cdf_auc.png)

---

# Properties of the c.d.f.

- Since $f$ is a nonnegative function, $F$ is nondecreasing
- Since $f$ is a probability density function, $\int_{-\infty}^{+\infty}f(s)ds=1$, and thus $\lim_{t\to\infty}F(t)=1$

![width:550px center](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/cdf_plot.png)

---

# Mean value

For a continuous random variable $T$ with probability density function $f$, the **mean** value of $T$, denoted $\bar T$ or $E(T)$, is given by
$$
\tag{1}\label{eq:mean_value}
E(T)=\int_{-\infty}^{+\infty} tf(t)dt
$$

---

# Survival function

Another characterization of the distribution of the random variable $T$ is through the **survival** (or **sojourn**) function


The survival function of state $S_1$ is given by
$$
\begin{equation}\tag{2}\label{eq:survival}
  \mathcal{S}(t)=1-F(t)=\mathbb{P}(T>t)
\end{equation}
$$
This gives a description of the **sojourn time** of a system in a particular state (the time spent in the state)

$\mathcal{S}$ is a nonincreasing function (since $\mathcal{S}=1-F$ with $F$ a c.d.f.), and $\mathcal{S}(0)=1$ (since $T$ is a positive random variable)

---

The **average sojourn time** $\tau$ is
$$
\tau=E(T)=\int_0^\infty tf(t)dt
$$
Since $\lim_{t\to\infty}t\mathcal{S}(t)=0$,
$$
\tag{3}\label{eq:mean_sojourn_time}
\tau=\int_0^\infty \mathcal{S}(t)dt
$$

**Expected future lifetime**
$$
\tag{4}\label{eq:expected_future_lifetime}
\frac{1}{\mathcal{S}(t_0)} \int_0^{\infty} t\,f(t+t_0)\,dt 
$$

---

# Hazard (or failure) rate

The **hazard rate** (or **failure rate**) is
$$
\begin{align*}
h(t) &= \lim_{\Delta t\to 0}\frac{\mathcal{S}(t)-\mathcal{S}(t+\Delta t)}{\Delta t} \\
& = \lim_{\Delta t\to 0} \frac{\mathbb{P}( T<t+\Delta t | T\geq t)}{\Delta t} \\
&= \frac{f(t)}{\mathcal{S}(t)}
\end{align*}
$$

Gives probability of failure between $t$ and $\Delta t$, given survival to $t$

We have
$$
\tag{5}\label{eq:hazard_rate}
h(t)=-\frac{d}{dt}\ln\mathcal{S}(t)
$$

---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# The exponential distribution

---

# The exponential distribution

The random variable $T$ has an **exponential** distribution if its probability density function takes the form

$$
\begin{equation}\label{eq:exp_distrib}\tag{6}
f(t)=\begin{cases}0&\textrm{if }t<0,\\
\theta e^{-\theta t}&\textrm{if }t\geq 0,
\end{cases}
\end{equation}
$$
with $\theta>0$. Then the survival function for state $S_1$ is of the form $\mathcal{S}(t)=e^{-\theta t}$, for $t\geq 0$, and the average sojourn time in state $S_1$ is
$$
\tau=\int_0^\infty e^{-\theta t}dt=\frac 1\theta
$$

---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# The Dirac distribution

---

# The Dirac distribution

If on the other hand, for some constant $\omega>0$,
$$\tag{7}\label{eq:diract_distribution}
\mathcal{S}(t)=
\left\{
\begin{array}{ll}
1, & 0\leq t\leq\omega \\
0, & \omega<t
\end{array}
\right.
$$
which means that $T$ has a Dirac delta distribution $\delta_\omega(t)$, then the average sojourn time is
$$
\tau=\int_0^\omega dt=\omega
$$

---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# A cohort model

---

# A model for a cohort with one cause of death 

We consider a population consisting of individuals born at the same time (a **cohort**), for example, the same year

We suppose

- At time $t=0$, there are initially $N_0>0$ individuals
- All causes of death are compounded together
- The time until death, for a given individual, is a random variable $T$, with continuous probability density distribution $f(t)$ and survival function $P(t)$

---

# The model

Denote $N(t)$ the population at time $t\geq 0$. Then

$$
\begin{equation}\label{eq:N_general}\tag{8}
N(t)=N_0P(t)
\end{equation}
$$

$N_0P(t)$ gives the proportion of $N_0$, the initial population, that is still alive at time $t$

---

# Case where $T$ is exponentially distributed

Suppose that $T$ has an exponential distribution with mean $1/d$ (or parameter $d$), $f(t)=de^{-dt}$. Then the survival function is $P(t)=e^{-dt}$ and $\eqref{eq:N_general}$ takes the form

$$
\begin{equation}\label{eq:N}\tag{9}
N(t)=N_0e^{-dt}
\end{equation}
$$
Now note that
$$
\begin{align*}
\frac{d}{dt} N(t) &= -dN_0e^{-dt} \\
&= -dN(t),
\end{align*}
$$
with $N(0)=N_0$

$\implies$ The ODE $N'=-dN$ makes the assumption that the life expectancy at birth is exponentially distributed

---

# Case where $T$ has a Dirac delta distribution

Suppose that $T$ has a Dirac delta distribution at $t=\omega$, giving the survival function 
$$
P(t)=\begin{cases}
1, & 0\leq t\leq\omega\\
0, & t>\omega
\end{cases}
$$
Then $\eqref{eq:N_general}$ takes the form
$$
\begin{equation}\label{eq:N2}
N(t)=\begin{cases}
N_0, & 0\leq t\leq\omega\\
0, & t>\omega
\end{cases}
\end{equation}
$$
All individuals survive until time $\omega$, then they all die at time $\omega$

Here, we have $N'=0$ everywhere except at $t=\omega$, where it is undefined

---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# <!--fit-->Sojourn times in an SIS disease transmission model

---

![bg 80% right:40%](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/figure_SIS_base_no_demography_general_recovery_vertical.png)

# <!--fit-->An SIS with tweaked recovery

Traditional ODE models assume recovery from disease at *per capita* rate (often denoted $\gamma$)

Here, assume that, of the individuals who have become infective at time $t_0$, a fraction $P(t-t_0)$ remain infective at time $t\geq t_0$

Thus, considered for $t\geq 0$, the function $P(t)$ is a survival function

---

# Reducing the dimension of the problem

We have
$$
S(t)+I(t)=N, \textrm{ or equivalently, }S(t)=N-I(t)
$$

$N$ is constant (equal total population at time $t=0$), so we can deduce the value of $S(t)$, once we know $I(t)$, from the equation $S(t)=N-I(t)$

---

# Model for infectious individuals

Integral equation for the number of infective individuals:
$$
\begin{equation}
I(t) = I_0(t)+ \int_0^t\beta\frac{(N-I(u))I(u)}{N} P(t-u) du
\label{eq:SIS_I}\tag{10} 
\end{equation}
$$

- $I_0(t)$ number of individuals who were infective at time $t=0$ and still are at time $t$
  - $I_0(t)$ is nonnegative, nonincreasing, and such that $\lim_{t\to\infty}I_0(t)=0$
- $P(t-u)$ proportion of individuals who became infective at time $u$ and
who still are at time $t$
- $\beta (N-I(u))S(u)/N$ is $\beta S(u)I(u)/N$ with $S(u)=N-I(u)$, from the reduction of dimension

---

# Expression under the integral

Integral equation for the number of infective individuals: 

$$
\begin{equation}
I(t) = I_0(t)+ \int_0^t\beta\frac{(N-I(u))I(u)}{N} P(t-u) du
\tag{\ref{eq:SIS_I}} 
\end{equation}
$$
The term
$$
\beta\frac{(N-I(u))I(u)}{N} P(t-u)
$$

- $\beta (N-I(u))I(u)/N$ is the rate at which new infectives are created, at time $u$,
- multiplying by $P(t-u)$ gives the proportion of those who became infectives at time $u$ and who still are at time $t$

Summing over $[0,t]$ gives the number of infective individuals at time $t$

---

# <!--fit-->Case of an exponentially distributed time to recovery
Suppose that $P(t)$ is such that the sojourn time in the infective state has an exponential distribution with mean $1/\gamma$, i.e., $P(t)=e^{-\gamma t}$

Then the initial condition function $I_0(t)$ takes the form
$$
I_0(t)=I_0(0)e^{-\gamma t}
$$
with $I_0(0)$ the number of infective individuals at time $t=0$. This is obtained by considering the cohort of initially infectious individuals, giving a model such as $\eqref{eq:N_general}$

Equation $\eqref{eq:SIS_I}$ becomes
$$
\begin{equation}\label{eq:I_ODE}\tag{11}
I(t)=I_0(0)e^{-\gamma t}+\int_0^t \beta\frac{(N-I(u))I(u)}{N} e^{-\gamma (t-u)}du
\end{equation}
$$

---

Taking the time derivative of $\eqref{eq:I_ODE}$ yields
$$
\begin{align*}
I'(t) &= -\gamma I_0(0)e^{-\gamma t}-\gamma\int_0^t \beta\frac{(N-I(u))I(u)}{N}e^{-\gamma(t-u)}du \\
&\quad +\beta \frac{(N-I(t))I(t)}{N} \\
&= -\gamma\left(I_0(0)e^{-\gamma t}+
\int_0^t \beta\frac{(N-I(u))I(u)}{N}e^{-\gamma(t-u)}du\right) \\
&\quad +\beta \frac{(N-I(t))I(t)}{N} \\
&= \beta \frac{(N-I(t))I(t)}{N}-\gamma I(t)
\end{align*}
$$
which is the classical logistic type ordinary differential equation (ODE) for $I$ in an SIS model without vital dynamics (no birth or death)

---

# Case of a step function survival function

Consider case where the time spent infected has survival function 
$$
P(t)=\begin{cases}
1, & 0\leq t\leq\omega\\
0, & t>\omega
\end{cases}
$$
i.e., the sojourn time in the infective state is a constant $\omega>0$
 
In this case $\eqref{eq:SIS_I}$ becomes
$$
\begin{equation}\label{eq:I_DDE}\tag{12}
I(t)=I_0(t)+\int_{t-\omega}^t \beta\frac{(N-I(u))I(u)}{N} du
\end{equation}
$$
Here, it is more difficult to obtain an expression for $I_0(t)$. It is however assumed that $I_0(t)$ vanishes for $t>\omega$

---

When differentiated, $\eqref{eq:I_DDE}$ gives, for $t\geq\omega$
$$
I'(t)=I_0'(t)+\beta\frac{(N-I(t))I(t)}{N}
-\beta\frac{\left(N-I(t-\omega)\right)I(t-\omega)}{N}
$$
Since $I_0(t)$ vanishes for $t>\omega$, this gives the delay differential equation (DDE)
$$
I'(t)=\beta\frac{(N-I(t))I(t)}{N}
-\beta\frac{(N-I(t-\omega))I(t-\omega)}{N}
$$

---

# What we know this far

- The time of sojourn in compartments plays an important role in determining the type of model that we deal with
- All ODE compartmental models, when they use terms of the form $\kappa X$, make the assumption that the time of sojourn in compartments is exponentially distributed with mean $1/\kappa$
- At the other end of the spectrum, delay differential with discrete delay $\tau$ make the assumption of a constant sojourn time $\tau$, equal for all individuals
- Both can be true sometimes.. but reality is often somewhere in between

---

Survival function, $\mathcal{S}(t)=\mathbb{P}(T>t)$, for an exponential distribution with mean 80 years

![width:800px center](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/survival_exp_80years.png)

---

# The problems with the exponential distribution

- Survival drops quickly: in previous graph, 20% mortality of a cohort at age 20 years
- Survival extends way past the mean: in previous graph, almost 25% survival to age 120 years
- Acceptable if what matters is mean duration of sojourn over long time period
- Less so if interested in short term dynamics
- Exponential distribution with parameter $\theta$ has mean $1/\theta$ and variance $1/\theta^2$, i.e., one parameter controls both the mean and dispersion

---

<!-- _backgroundImage: "linear-gradient(to bottom, #156C26, 20%, white)" -->
# <!--fit-->An $SL_1L_2I_1I_2A_1A_2R$ COVID-19 model : "making Erlangs"

<div style = "position: relative; bottom: -40%; font-size:20px;">

JA & Portet. [A simple model for COVID-19](http://dx.doi.org/10.1016/j.idm.2020.04.002). *Infectious Disease Modelling* **5**:309-315 (2020)
</div>

---

# <!--fit-->Simple way to "fix" sojourn times: sums of exponential distributions

- Exponential distribution of sojourn times is acceptable if what matters is mean duration of sojourn over long time period
- For COVID-19, were trying to give "predictions" over 2-4 weeks period, so we need more than the mean

$\implies$ Use a property of exponential distributions, namely, that the sum of i.i.d. (independent and identically distributed) exponential distributions is Erlang distributed

---

# Sum of exponential distributions

$X_1$ and $X_2$ independent exponential r.v. with rate parameters $\theta_1$ and $\theta_2$. Then the p.d.f. of $Z=X_1+X_2$ is the convolution
$$
\begin{align}
 f_Z(z) &= \int_{-\infty}^\infty f_{X_1}(x_1) f_{X_2}(z - x_1)\,dx_1\\
   &= \int_0^z \theta_1 e^{-\theta_1 x_1} \theta_2 e^{-\theta_2(z - x_1)} \, dx_1 \\
   &= \theta_1 \theta_2 e^{-\theta_2 z} \int_0^z e^{(\theta_2 - \theta_1)x_1}\,dx_1 \\
   &= \begin{cases}
        \dfrac{\theta_1 \theta_2}{\theta_2-\theta_1} \left(e^{-\theta_1 z} - e^{-\theta_2 z}\right) & \text{ if } \theta_1 \neq \theta_2 \\[0.15cm]
        \theta^2 z e^{-\theta z} & \text{ if } \theta_1 = \theta_2 =: \theta
      \end{cases}
 \end{align}
 $$

---

# The Erlang distribution

P.d.f. of the Erlang distribution
$$
f(x; k,\lambda)={\lambda^k x^{k-1} e^{-\lambda x} \over (k-1)!},\quad x,\lambda \geq 0
$$
$k$ **shape parameter**, $\lambda$ **rate parameter** (sometimes use **scale parameter** $\beta = 1/\lambda$)

So, if $\theta_1=\theta_2$, $Z=X_1+X_2$ has distribution
$$
f_Z(z)=\theta^2e^{-\theta z}
$$
i.e., an Erlang distribution with shape parameter $k=2$ and rate parameter $\theta$

---

# Continuing..

$X_i$, $i=1,\ldots,N$, be exponential i.i.d. random variables with parameter $\theta$

Then $\sum_i X_i$ Erlang distributed with rate parameter $\theta$ and shape parameter $N$


---

# <!--fit-->So use multiple compartments

![width:98%](https://raw.githubusercontent.com/julien-arino/petit-cours-epidemio-mathematique/main/FIGS/figure_residence_times_expo_Erlang_fr.png)

---

# Properties of the Erlang distribution

An Erlang is a Gamma with shape parameter $k\in\mathbb{N}$. P.d.f. of the Erlang distribution
$$
f(t; k,\lambda)={\lambda^k t^{k-1} e^{-\lambda t} \over (k-1)!},\quad t,\lambda \geq 0
$$
$k$ **shape parameter**, $\lambda$ **rate parameter**

Mean $k/\lambda$, variance $k/\lambda^2$, c.d.f.
$$
F(t; k,\lambda) = 1 - \sum_{n=0}^{k-1}\frac{1}{n!}e^{-\lambda t}(\lambda t)^n
$$
and thus survival function
$$
\mathcal{S}(t; k,\lambda) = 
\sum_{n=0}^{k-1}\frac{1}{n!}e^{-\lambda t}(\lambda t)^n
$$

---

![width:1000px center](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/expo_vs_erlang.png)

---

<div style="width:100%; height:100%">
  <iframe src="https://daytah-or-dahtah.ovh:3838/Erlang_shiny/" style="position:absolute; top:0px; left:0px; 
  width:100%; height:100%; border: none; overflow: hidden;"></iframe>
</div>

---

![bg contain drop-shadow](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/flow_diagram_SLLIIAARRD.png)


--- 

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit -->Discrete time Markov chains

---

# Discrete-time Markov chains

$p(t)=(p_1(t),\ldots,p_n(t))^T$: probability vector, with $p_i(t)$ describing the probability that at time $t$, the system is in state $S_i$, $i=1,\ldots,n$

$\sum_i p_i(t)=1$ for all $t$, of course

State evolution governed by
$$
p(t+\Delta t) = A(\Delta t)p(t)
$$
where $A(\Delta t)$ is a stochastic matrix (row sums all equal 1), the *transition* matrix, with entry $a_{ij}=\mathbb{P}(X_{t+\Delta t}=s_i|X_t=s_j)$, where $X_1,\ldots$ sequence of random variables describing the state

If $A(\Delta t)=A$ constant, *homogeneous* DTMC

Time often ''recast'' so that $\Delta t=1$

---

# Important remark

The DTMC world lives at the interface between probabilists, who like to think of $p(t)$ as a row vector, $A(\Delta t)$ as a column-stochastic matrix and thus write
$$
p(t+\Delta t) = p(t)A(\Delta t)
$$
and linear algebraists, who prefer column vectors and row-stochastic matrices, 
$$
p(t+\Delta t) = A(\Delta t)p(t)
$$

So check the direction to understand whether you are using $A$ or $A^T$

---

# Advantages of DTMC

As a teacher of modelling: base theory of DTMC uses a lot of linear algebra and graph theory; usually really appreciated by students

*Regular* DTMC (with *primitive* transition matrices) allow to consider equilibrium distribution of probability of being in various states

*Absorbing* DTMC (with *reducible* transition matrices) allow the consideration of time to absorption, mean first passage time, etc.

---

# DTMC for example SIS system

Since $S=P^\star-I$, consider only the infected. To simulate as DTMC, consider a random walk on $I$ ($\simeq$ Gambler's ruin problem)

Denote $\lambda_I = \beta (P^\star-I)I\Delta t$, $\mu_I = \gamma I\Delta t$ and $\sigma_I=1-(\lambda_I+\mu_I)\Delta t$

![width:1200px](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/figure_SIS_random_walk.png)

---

#  Absorbing states, absorbing chains

<div class="definition">

A state $S_i$ in a Markov chain is **absorbing** if whenever it occurs on the $n^{th}$ generation of the experiment, it then occurs on every subsequent step. In other words, $S_i$ is absorbing if $p_{ii}=1$ and $p_{ij}=0$ for $i\neq j$
</div>

<div class="definition">

A **Markov chain is absorbing** if it has at least one absorbing state, and if from every state it is possible to go to an absorbing state
</div>

<div class="definition">

In an absorbing Markov chain, a state that is not absorbing is called **transient**
</div>

---

#  Some questions on absorbing chains

Suppose we have a chain like the following

![width:500px center](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/graphe_absorbant.png)

1. Does the process eventually reach an absorbing state?
2. Average # of times spent in a transient state, if starting in a transient state?
3. Average # of steps before entering an absorbing state?
4. Probability of being absorbed by a given absorbing state, when there are more than one, when starting in a given transient state?

---

#  Reaching an absorbing state

Answer to question 1:
<div class="theorem">

Markov chain absorbing $\implies$ probability of reaching *an* absorbing state is **1**
</div>

---

#  Standard form of the transition matrix

For an absorbing chain with $k$ absorbing states and $r-k$ transient states, the transition matrix can be written as
$$
P=\begin{pmatrix}
\mathbb{I}_k & \mathbf{0} \\
R & Q
\end{pmatrix}
$$

|     | Absorbing states | Transient states |
|:---:|:---:|:---:|
| **Absorbing states** | $\mathbb{I}_k$ | $\mathbf{0}$ |
| **Transient states** | $R$ | $Q$ |

$\mathbb{I}_k$ the $k\times k$ identity, $\mathbf{0}\in\mathbb{R}^{k\times(r-k)}$, $R\in\mathbb{R}^{(r-k)\times k}$, $Q\in\mathbb{R}^{(r-k)\times(r-k)}$

---

The matrix $\mathbb{I}_{r-k}-Q$ is invertible. Let

- $N=(\mathbb{I}_{r-k}-Q)^{-1}$ be the **fundamental matrix** of the Markov chain
- $T_i$ be the sum of the entries on row $i$ of $N$
- $B=NR$

Answers to our remaining questions:

2. $N_{ij}$ is the average number of times the process is in the $j$th transient state if it starts in the $i$th transient state
3. $T_i$ is the average number of steps before the process enters an absorbing state if it starts in the $i$th transient state
4. $B_{ij}$ is the probability of eventually entering the $j$th absorbing state if the process starts in the $i$th transient state

See for instance book of [Kemeny and Snell](https://www.amazon.com/Finite-Markov-Chains-Laurie-Kemeny/dp/B000KYES0O)

---

# Return to DTMC for example SIS system

Since $S=P^\star-I$, consider only the infected. To simulate as DTMC, consider a random walk on $I$ ($\simeq$ Gambler's ruin problem)

Denote $\lambda_I = \beta (P^\star-I)I\Delta t$, $\mu_I = \gamma I\Delta t$ and $\sigma_I=1-(\lambda_I+\mu_I)\Delta t$

![width:1200px](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/figure_SIS_random_walk.png)

---

# Transition matrix

$$
A = 
\begin{pmatrix}
1 & 0 \\
\mu_1 & \sigma_1 & \lambda_1 & 0 \\
0 & \mu_2 & \sigma_2 & \lambda_2 & 0 \\
\\
& & & & & \ddots \\
\\
& & & & &  & 0 & \mu_{P^\star-1} & \mu_{P^\star-1} & \lambda_{P^\star-1} & 0 \\
&&&&&&&& 0 & \mu_{P^\star} & \sigma_{P^\star}
\end{pmatrix}
$$

---

```R
# Make the transition matrix
T = mat.or.vec(nr = (Pop+1), nc = (Pop+1))
for (row in 2:Pop) {
  I = row-1
  mv_right = gamma*I*Delta_t # Recoveries
  mv_left = beta*I*(Pop-I)*Delta_t # Infections
  T[row,(row-1)] = mv_right
  T[row,(row+1)] = mv_left
}
# Last row only has move left
T[(Pop+1),Pop] = gamma*(Pop)*Delta_t
# Check that we don't have too large values
if (max(rowSums(T))>1) {
  T = T/max(rowSums(T))
}
diag(T) = 1-rowSums(T)
```


---

# Simulating a DTMC

```R
library(DTMCPack)
sol = MultDTMC(nchains = 20, tmat = T, io = IC, n = t_f)
```
gives 20 realisations of a DTMC with transition matrix ``T``, initial conditions ``IC`` (a vector of initial probabilities of being in the different $I$ states) and final time ``t_f``

See code on [Github](https://github.com/ahurford/aarms-summer-school/tree/main/julien-lectures/CODE)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/stochastic/several_DTMC_sims.png)

---

# Going a bit further

`DTMCPack` is great for obtaining realisations of a DTMC, but to study it in more detail, `markovchain` is much more comprehensive

```R
library(markovchain)
mcSIS <- new("markovchain", 
             states = sprintf("I_%d", 0:Pop),
             transitionMatrix = T,
             name = "SIS")
```

Note that interestingly, `markovchain` overrides the weird default "`*` is Hadamard, `%*%` is usual" `R` matrix product rule, so `mcSIS*mcSIS` does $TT$, not $T\circ T$

---

```R
> summary(mcSIS)
SIS  Markov chain that is composed by: 
Closed classes: 
I_0 
Recurrent classes: 
{I_0}
Transient classes: 
{I_1,I_2,I_3,I_4,I_5,I_6,I_7,I_8,I_9,I_10,I_11,I_12,I_13,I_14,I_15,
I_16,I_17,I_18,I_19,I_20,I_21,I_22,I_23,I_24,I_25,I_26,I_27,I_28,
I_29,I_30,I_31,I_32,I_33,I_34,I_35,I_36,I_37,I_38,I_39,I_40,I_41,
I_42,I_43,I_44,I_45,I_46,I_47,I_48,I_49,I_50,I_51,I_52,I_53,I_54,
I_55,I_56,I_57,I_58,I_59,I_60,I_61,I_62,I_63,I_64,I_65,I_66,I_67,
I_68,I_69,I_70,I_71,I_72,I_73,I_74,I_75,I_76,I_77,I_78,I_79,I_80,
I_81,I_82,I_83,I_84,I_85,I_86,I_87,I_88,I_89,I_90,I_91,I_92,I_93,
I_94,I_95,I_96,I_97,I_98,I_99,I_100}
The Markov chain is not irreducible 
The absorbing states are: I_0
```

---

<span style="font-size:25px;">

Function | Role
--- | ---
`absorbingStates` | absorbing states of the transition matrix, if any
`steadyStates` | the vector(s) of steady state(s) in matrix form
`meanFirstPassageTime` | matrix or vector of mean first passage times
`meanRecurrenceTime` | vector of mean number of steps to return to each recurrent state
`hittingProbabilities` | matrix of hitting probabilities for a Markov chain
`meanAbsorptionTime` | expected number of steps for a transient state to be absorbed by any recurrent class
`absorptionProbabilities` | $\mathbb{P}$ transient states being absorbed by each recurrent state
`canonicForm` | canonic form of transition matrix
`period` | the period of an irreducible DTMC
`summary` | DTMC summary

</span>

--- 

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit -->Continuous time Markov chains

---

# Continuous-time Markov chains

CTMC similar to DTMC except in way they handle time between events (transitions)

DTMC: transitions occur each $\Delta t$

CTMC: $\Delta t\to 0$ and transition times follow an exponential distribution parametrised by the state of the system

CTMC are roughly equivalent to ODE

---

![bg contain 95%](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/stochastic/SIS_ODE_vs_CTMC.png)

---


Weight | Transition | Effect 
--- | --- | ---
$\beta SI$ | $S\to S-1$, $I\to I+1$ | new infection of a susceptible 
$\gamma I$ | $S\to S+1$, $I\to I-1$ | recovery of an infectious 

Will use $S=N^*-I$ and omit $S$ dynamics

---

# Gillespie's algorithm (SIS model with only I eq.)

set $t\leftarrow t_0$ and $I(t)\leftarrow I(t_0)$
while {$t\leq t_f$}
- $\xi_t\leftarrow \beta (P^\star-i)i+\gamma i$
- Draw $\tau_t$ from $T\thicksim \mathcal{E}(\xi_t)$
- $v\leftarrow\left[\beta (P^\star-i)i,\xi_t\right]/\xi_t$
- Draw $\zeta_t$ from $\mathcal{U}([0,1])$
- Find $pos$ such that $v_{pos-1}\leq\zeta_t\leq v_{pos}$
- switch {$pos$}
  - 1: New infection, $I(t+\tau_t)=I(t)+1$
  - 2: End of infectious period, $I(t+\tau_t)=I(t)-1$
- $t\leftarrow t+\tau_t$

---

# You can also use a package

- You can implement Gillespie's algorithm yourself, it is a good exercise..
- But in R there also exists a few packages allowing you to do that easily
- They have the advantage of implementing tau-leaping (more on this later)

---

# Simulating a CTMC

```R
library(GillespieSSA2)
IC <- c(S = (Pop-I_0), I = I_0)
params <- c(gamma = gamma, beta = beta)
reactions <- list(
  reaction("beta*S*I", c(S=-1,I=+1), "new_infection"),
  reaction("gamma*I", c(S=+1,I=-1), "recovery")
)
set.seed(NULL)
sol <- ssa(
    initial_state = IC,
    reactions = reactions,
    params = params,
    method = ssa_exact(),
    final_time = t_f,
)
plot(sol$time, sol$state[,"I"], type = "l",
     xlab = "Time (days)", ylab = "Number infectious")
```

---

![bg contain](https://raw.githubusercontent.com/julien-arino/presentations/main/FIGS/stochastic/one_CTMC_sim.png)

---

# Sometimes in a CTMC things go bad

- Recall that the inter-event time is exponentially distributed
- Critical step of the Gillespie algorithm:
  -  $\xi_t\leftarrow$ weight of all possible events (*propensity*)
  - Draw $\tau_t$ from $T\thicksim \mathcal{E}(\xi_t)$
- So the inter-event time $\tau_t\to 0$ if $\xi_t$ becomes very large for some $t$
- This can cause the simulation to grind to a halt

---

# Example: a birth and death process

- Individuals born at *per capita* rate $b$
- Individuals die at *per capita* rate $d$
- Let's implement this using classic Gillespie

---

# Gillespie's algorithm (birth-death model)

set $t\leftarrow t_0$ and $N(t)\leftarrow N(t_0)$
while {$t\leq t_f$}
- $\xi_t\leftarrow (b+d)N(t)$
- Draw $\tau_t$ from $T\thicksim \mathcal{E}(\xi_t)$
- $v\leftarrow\left[bN(t),\xi_t\right]/\xi_t$
- Draw $\zeta_t$ from $\mathcal{U}([0,1])$
- Find $pos$ such that $v_{pos-1}\leq\zeta_t\leq v_{pos}$
- switch {$pos$}
  - 1: Birth, $N(t+\tau_t)=N(t)+1$
  - 2: Death, $N(t+\tau_t)=N(t)-1$
- $t\leftarrow t+\tau_t$

---

```R
b = 0.01   # Birth rate
d = 0.01   # Death rate
t_0 = 0    # Initial time
N_0 = 100  # Initial population

# Vectors to store time and state. Initialise with initial condition.
t = t_0
N = N_0

t_f = 1000  # Final time

# We'll track the current time and state (could also just check last entry in t
# and N, but will take more operations)
t_curr = t_0
N_curr = N_0
```

---

```R
while (t_curr<=t_f) {
  xi_t = (b+d)*N_curr
  # The exponential number generator does not like a rate of 0 (when the 
  # population crashes), so we check if we need to quit
  if (N_curr == 0) {
    break
  }
  tau_t = rexp(1, rate = xi_t)
  t_curr = t_curr+tau_t
  v = c(b*N_curr, xi_t)/xi_t
  zeta_t = runif(n = 1)
  pos = findInterval(zeta_t, v)+1
  switch(pos,
         { 
           # Birth
           N_curr = N_curr+1
         },
         {
           # Death
           N_curr = N_curr-1
         })
  N = c(N, N_curr)
  t = c(t, t_curr)
}
```

---

# <!--fit-->Drawing at random from an exponential distribution

If you do not have an exponential distribution random number generator.. We want $\tau_t$ from $T\thicksim\mathcal{E}(\xi_t)$, i.e., $T$ has probability density function
$$
f(x,\xi_t)=
\xi_te^{-\xi_t x}\mathbf{1}_{x\geq 0}
$$
Use cumulative distribution function $F(x,\xi_t)=\int_{-\infty}^x f(s,\xi_t)\,ds$
$$
F(x,\xi_t)=
(1-e^{-\xi_t x})\mathbf{1}_{x\geq 0}
$$
which has values in $[0,1]$. So draw $\zeta$ from $\mathcal{U}([0,1])$ and solve $F(x,\xi_t)=\zeta$ for $x$
$$
\begin{align*}
F(x,\xi_t)=\zeta & \Leftrightarrow 1-e^{-\xi_tx}=\zeta \\
&\Leftrightarrow e^{-\xi_tx} = 1-\zeta \\
&\Leftrightarrow \xi_tx = -\ln(1-\zeta) \\
&\Leftrightarrow \boxed{x = \frac{-\ln(1-\zeta)}{\xi_t}}
\end{align*}
$$

---

![bg contain](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS//CTMC_birth_death_sol_b=0_01__d=0_01.png)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS//CTMC_birth_death_sol_b=0_01__d=0_02.png)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS//CTMC_birth_death_sol_b=0_025__d=0_01.png)

---

# Last one did not go well

- Wanted 1000 time units (days?)
- Interrupted around 500 ($t=473.4544$) because I lost patience
- (Slide before: the sim stopped because the population went extinct, I did not stop it!)
- At stop time
  - $|N| = 241,198$ (and $|t|$ as well, of course!)
  - time was moving slowly
```R
> tail(diff(t))
[1] 1.357242e-04 1.291839e-04 5.926044e-05 7.344020e-05 1.401148e-04 4.423529e-04
```

---

![bg contain](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS//CTMC_birth_death_ie_vs_t_b=0_025__d=0_01.png)

---

# Tau-leaping to the rescue!

- Will not go into details
- *Approximation* method (compared to classic Gillespie, which is exact)
- Roughly: consider "groups" of events instead of individual events
- Good news: `GillespieSSA2` (which we saw earlier) and `adaptivetau`

---

# Parallelisation

To see multiple realisations: good idea to parallelise, then interpolate results. Write a function, e.g.,  `run_one_sim` that .. runs one simulation, then..

```R
no_cores <- detectCores()-1
cl <- makeCluster(no_cores)
clusterEvalQ(cl,{
  library(GillespieSSA2)
})
clusterExport(cl,
              c("params",
                "run_one_sim"),
              envir = .GlobalEnv)
SIMS = parLapply(cl = cl, 
                 X = 1:params$number_sims, 
                 fun =  function(x) run_one_sim(params))
stopCluster(cl)
```

See `simulate_CTMC_parallel.R` on [Github](https://github.com/julien-arino/UK-APASI)

---

![bg contain](https://raw.githubusercontent.com/julien-arino/3MC-course-epidemiological-modelling/main/FIGS/many_CTMC_sims_with_means.png)

---

# Benefit of parallelisation

Run the parallel code for 100 sims between `tictoc::tic()` and `tictoc::toc()`, giving `66.958 sec elapsed`, then the sequential version
```R
tictoc::tic()
SIMS = lapply(X = 1:params$number_sims, 
              FUN =  function(x) run_one_sim(params))
tictoc::toc()
```
which gives `318.141 sec elapsed` on a 6C/12T Intel(R) Core(TM) i9-8950HK CPU @ 2.90GHz (4.75$\times$ faster) or `12.067 sec elapsed` versus `258.985 sec elapsed` on a 32C/64T AMD Ryzen Threadripper 3970X 32-Core Processor (21.46$\times$ faster !)

---

<!-- _backgroundImage: "linear-gradient(to bottom, #F45627, 20%, #F45627)" -->

# <!-- fit --> Merci / Miigwech / Thank you
