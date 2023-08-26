---
marp: true
title: Data assimilation
description: Julien Arino - 2023 AARMS Summer School - Data assimilation
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
# Data assimilation

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

# Foreword

- I have used ChatGPT and GitHub Copilot to generate some of this text
- These tools are *potential* time savers, but they are not perfect (*Copilot* just suggested "but they are not perfect" :smile:), so use them wisely: read the results carefully, and don't be afraid to edit them (again, this was suggested by *Copilot* :smile:)

--- 

<!-- _backgroundImage: "radial-gradient(white,80%,#f1c40f)" -->
# Outline

- Data assimilation
- Using a Kalman filter
- Side note : observers

--- 

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit -->Data assimilation

---

# Definition

Data assimilation is a process used in various scientific and engineering fields, such as meteorology, oceanography, geophysics, and hydrology, to combine observations with numerical models in order to produce more accurate and reliable predictions or estimates of a system's state or behaviour. 

**The goal of data assimilation is to merge real-world observations with model simulations to improve the overall understanding and prediction of complex systems.**

---

In essence, data assimilation involves integrating observational data into a computational model to adjust and refine the model's predictions or estimations. This is *particularly important in situations where the model's initial conditions or parameters are uncertain or incomplete*. By incorporating actual observed data, the assimilation process helps correct any discrepancies between the model's predictions and the real-world observations.

---

The process of data assimilation typically involves the following steps:

1. **Model Prediction:** The numerical model is used to simulate the behaviour of the system over a certain period of time, generating a prediction based on the current model state.

2. **Observations:** Real-world observations, obtained from various sources such as satellites, sensors, and measurements, are collected and prepared for assimilation.

3. **Data-Matching:** The observed data are compared to the model's predictions to identify differences or discrepancies between the two.

---

4. **Update:** Based on the differences identified, adjustments are made to the model's state or parameters in a way that reduces the mismatch between observations and predictions. This update can be done through various mathematical techniques, such as Kalman filters, variational methods, or ensemble methods.

5. **Recalculation:** The model is rerun using the updated state or parameters, providing a new prediction that incorporates both the model's dynamics and the assimilated data.

6. **Iterative Process:** The process is often repeated iteratively, with subsequent observations being assimilated to continuously refine the model's predictions as new data becomes available.

--- 

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit -->Using a Kalman filter

(From [Wikipedia](https://en.wikipedia.org/wiki/Kalman_filter))

--- 

![bg contain](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Basic_concept_of_Kalman_filtering.svg/1280px-Basic_concept_of_Kalman_filtering.svg.png)

---

To use the Kalman filter to estimate the internal state of a process given only a sequence of noisy observations, model the process in accordance with the following framework. Specify matrices, for each time-step $k$:
- $\mathbf{F}_k$, the state-transition model
- $\mathbf{H}_k$, the observation model
- $\mathbf{Q}_k$, the covariance of the process noise
- $\mathbf{R}_k$, the covariance of the observation noise
- and sometimes $\mathbf{B}_k$, the control-input model as described below; if $\mathbf{B}_k$ is included, then there is also
- $\mathbf{u}_k$, the control vector, representing the controlling input into control-input model

---

![bg contain](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Kalman_filter_model_2.svg/1280px-Kalman_filter_model_2.svg.png)

---

The Kalman filter model assumes the true state at time $k$ is evolved from the state at $k-1$ according to

$$
    \mathbf{x}_k = \mathbf{F}_k \mathbf{x}_{k-1} +\mathbf{B}_k \mathbf{u}_{k} + \mathbf{w}_k
$$

where
* $\mathbf{F}_k$ is the state transition model which is applied to the previous state $\mathbf{x}_{k−1}$
* $\mathbf{B}_k$ is the control-input model which is applied to the control vector $\mathbf{u}_k$
* $\mathbf{w}_k$ is the process noise, which is assumed to be drawn from a zero mean multivariate normal distribution, $\mathcal{N}$, with covariance matrix, $\mathbf{Q}_k$: $\mathbf{w}_k \sim \mathcal{N}\left(0, \mathbf{Q}_k\right)$.

---

At time $k$ an observation (or measurement) $z_k$ of the true state $x_k$ is made according to

$$
\mathbf{z}_k = \mathbf{H}_k \mathbf{x}_k + \mathbf{v}_k
$$

where
* $\mathbf{H}_k$ is the observation model, which maps the true state space into the observed space and
* $\mathbf{v}_k$ is the observation noise, which is assumed to be zero mean Gaussian white noise with covariance $\mathbf{R}_k$: $\mathbf{v}_k \sim \mathcal{N}\left(0, \mathbf{R}_k\right)$.

The initial state, and the noise vectors at each step $\{\mathbf{x}_0, \mathbf{w}_1, \ldots, \mathbf{w}_k,  \mathbf{v}_1, \ldots ,\mathbf{v}_k\}$ are all assumed to be mutually independent.

---

The Kalman filter is a recursive estimator. Only the estimated state from the previous time step and the current measurement are needed to compute the estimate for the current state

The notation $\hat{\mathbf{x}}_{n\mid m}$ represents the estimate of $\mathbf{x}$ at time $n$ given observations up to and including at time $m\leq n$

The state of the filter is represented by two variables:
- $\mathbf{x}_{k\mid k}$, the *a posteriori* state estimate mean at time $k$ given observations up to and including at time $k$
- $\mathbf{P}_{k\mid k}$, the *a posteriori* estimate covariance matrix (a measure of the estimated accuracy of the state estimate)

---

The Kalman filter can be written as a single equation; however, it is most often conceptualized as two distinct phases:

- The *predict* phase uses the state estimate from the previous timestep to produce an estimate of the state at the current timestep. This predicted state estimate is also known as the *a priori state estimate* because, although it is an estimate of the state at the current timestep, it does not include observation information from the current timestep

- In the *update* phase, the innovation (the pre-fit residual), i.e. the difference between the current a priori prediction and the current observation information, is multiplied by the optimal Kalman gain and combined with the previous state estimate to refine the state estimate. This improved estimate based on the current observation is termed the *a posteriori state estimate*.

---

Typically, the two phases alternate, with the prediction advancing the state until the next scheduled observation, and the update incorporating the observation. However, this is not necessary; 
- if an observation is unavailable for some reason, the update may be skipped and multiple prediction procedures performed
- if multiple independent observations are available at the same time, multiple update procedures may be performed (typically with different observation matrices $\mathbf{H}_k$)

---

# Predict phase

Predicted (*a priori*) state estimate
$$
\hat{\mathbf{x}}_{k\mid k-1} = \mathbf{F}_k \mathbf{x}_{k-1\mid k-1} + \mathbf{B}_k \mathbf{u}_{k}
$$

Predicted (*a priori*) estimate covariance
$$\hat{\mathbf{P}}_{k\mid k-1} = \mathbf{F}_k \mathbf{P}_{k-1 \mid k-1} \mathbf{F}_k^\textsf{T} + \mathbf{Q}_k
$$

---

# Update phase

Innovation or measurement pre-fit residual
$$
\tilde{\mathbf{y}}_k = \mathbf{z}_k - \mathbf{H}_k\hat{\mathbf{x}}_{k\mid k-1}
$$
Innovation (or pre-fit residual) covariance
$$
\mathbf{S}_k = \mathbf{H}_k \hat{\mathbf{P}}_{k\mid k-1} \mathbf{H}_k^\textsf{T} + \mathbf{R}_k
$$
*Optimal* Kalman gain
$$
\mathbf{K}_k = \hat{\mathbf{P}}_{k\mid k-1}\mathbf{H}_k^\textsf{T} \mathbf{S}_k^{-1}
$$
Updated (*a posteriori*) state estimate
$$
\mathbf{x}_{k\mid k} = \hat{\mathbf{x}}_{k\mid k-1} + \mathbf{K}_k\tilde{\mathbf{y}}_k
= (\mathbf{I} - \mathbf{K}_k \mathbf{H}_k) \hat{\mathbf{x}}_{k\mid k-1} + \mathbf{K}_k \mathbf{z}_k
$$

---

# Update phase (cont'd)

Updated (*a posteriori*) estimate covariance
$$
\mathbf{P}_{k|k} = \left(\mathbf{I} - \mathbf{K}_k \mathbf{H}_k\right) \hat{\mathbf{P}}_{k|k-1} 
$$
Measurement post-fit residual
$$
\tilde{\mathbf{y}}_{k\mid k} = \mathbf{z}_k - \mathbf{H}_k\mathbf{x}_{k\mid k}
$$

The formula for the updated (*a posteriori*) estimate covariance above is valid for the optimal $K_k$ gain that minimizes the residual error, in which form it is most widely used in applications

--- 

<!-- _backgroundImage: "linear-gradient(to bottom, #f1c40f, 20%, white)" -->
# <!-- fit -->Side note : state observers

---

A **state observer** or  **state estimator** is a system that provides an estimate of the internal state of a given real system, from measurements of the input and output of the real system

It is typically computer-implemented, and provides the basis of many practical applications

---

# Observable linear control system

A continuous-time linear system
$$
\begin{align*}
x' &= A x + B u \\
y &= C x + D u
\end{align*}
$$
where $x \in \mathbb{R}^n, u \in \mathbb{R}^m ,y \in \mathbb{R}^r$ is **observable** if and only if the **observability matrix**
$$
\begin{pmatrix}
C \\ CA \\ CA^2 \\ \vdots \\ CA^{n-1}
\end{pmatrix}
$$
has rank $n$

---

For a continuous-time linear system

$$
\begin{align*}
x' &= A x + B u \\
y &= C x + D u
\end{align*}
$$

where $x \in \mathbb{R}^n, u \in \mathbb{R}^m ,y \in \mathbb{R}^r$, the **observer** is

$$
\begin{align*}
\hat{x}' &= A \hat{x}+ B u + L \left(y - \hat{y}\right) \\
\hat{y} &= C \hat{x} + D u
\end{align*}
$$

The observer error $e=x-\hat{x}$ satisfies the equation
$$
e' = (A - LC) e
$$

Eigenvalues of matrix $A-LC$ can be chosen arbitrarily by appropriate choice of the observer gain $L$ when the pair $[A,C]$ is observable, i.e. the observability condition holds. In particular, it can be made Hurwitz (i.e., s.t. $s(A-LC)<0$), so the observer error $e(t) \to 0$ when $t \to \infty$.

---

See [this paper](https://doi.org/10.1007/s00285-018-1273-3) for state observers in epidemiological models

---

<!-- _backgroundImage: "linear-gradient(to bottom, #F45627, 20%, #F45627)" -->

# <!-- fit --> Merci / Miigwech / Thank you
