# Delay Hybrid Systems

Lorenz Sahlmann

Ecole Polytechnique /
Carnegie-Mellon-University

In this work we extend Differential Dynamic Logic with Delay Differential Equations.

This requires an extension of the syntax, a (partially) redefinition of the semantics and the introduction of additional axioms and proof rules.

This results in a superset of \dL which we call **Delay Differential Dynamic Logic**.

## Delay Differential Equations

### Piecewise Continuous Functions
The following definition is motivated by capturing the character evolution arising from hybrid systems. We will see that we can consider such to be piecewise continuous.

##### Definition (Piecewise Continuous)
Let $D=[a,b]\subset\R$ be a closed interval (this includes the cases when $a=-\infty$ or $b=\infty$, or both). The mapping $g:D\rightarrow\R^n$ is called **piecewise continuous** if and only if there is a finite subdivision $\{x_i:i=0,\ldots,m\}$ of $D$ (\ie $a=x_0<x_1<\ldots<x_m=b$) such that $g$ is continuous on $[x_i,x_{i+1})$ for all $i=0,\ldots,m-1$ and the one sided limits

$$ \lim_{x\nearrow x_{i+1}, x\in[x_i,x_{i+1})}g(x) $$

exist. Hence $g(b)$ can be an isolated point and this right interval limit $b$ is the only spot where such is allowed.

We denote by $C^0_\text{pw}(D,\R^n)$ the set of **piecewise continuous functions** on the compact interval $D$, mapping to $\R^n$

This figure shows an admissible piecewise continuous function.
![Allowed](allowed.png)
The following function however is not allowed!
![Not allowed](not-allowed.png)

### Definition DDE
Let $f:\R^n\times\R^n\rightarrow\R^n$ and $\tau > 0$. A functional equation of the form

\[ x'(t) = f\left(x(t),x(t-\tau)\right) \]

is called **Delay Differential Equation (DDE)** with _constant, discrete delay_.
It is _autonomous_, since its right hand side $f$ is time independent.

If the right hand side only depends on $x(t-\tau)$ and not on $x(t)$, we call the DDE _pure_.

A DDE can be equipped with an **initial condition**. It specifies the values of $x$ on $[-\tau, 0]$ on which the right hand side depends.

Since we only consider autonomous DDEs, we can without loss of generality restrict to the case of initial time $t_0=0$.

The definition of a DDE can be extended to multiple constant discrete delays. For simplicity, we restrict here to a single delay.

### Definition of Solution
A piecewise continuous function $x\in C^0_\text{pw}([-\tau,T],\R^n)$ is called **local solution** of the DDE (eq ??), if and only if there exists a $T>0$ such that $x|_{(0,T)}\in C^1((0,T),\R^n)$ with

\[ x'(t) = f\left(x(t),x(t-\tau)\right) \]

for all $t\in (0,T)$ and in $t=0$, it holds for the right-hand derivative
$$
    \lim_{h\searrow 0}\frac{x(h)-x(0)}{h}=f(x(0),x(-\tau))
$$

and obeys the initial condition:

$$ x(t) = x_0(t) \quad\text{for } t\in [-\tau,0]$$

on $[-\tau,0]$.

TODO: differentiable in right rand point? need not derivative in right hand point

TODO: Fortsetzbarkeit
For example initial condition has jump, this point is limit for local solution.

If the function $x$ is solution for all $T\in\R_{>0}$, it is called **global**.

TODO:
The notion of solution for an autonomous DDE as given above can be lifted to be a trajectory in the statespace
$$
    \gamma_x:[0,T]\rightarrow\statespace,\\ t\mapsto\xbartaut
$$

The **state** at time $t$ is a function which provides a time limited history up to the current time. This is all information needed to determine (using the DDE) to determine the solution for time $\geq t$.
It is defined as $\xbartaut(s)\def x(t+s)$ for $s\in [-\tau,0]$.
In the case of $t=0$, we simplify the notation to $\xbartau \def \bar{x}_{\tau,0}$.

This notion of solution is a _dynamical systems_ point of view which later turns out to be useful.

TODO: can write DDE (??) as

$$
\begin{cases}
    x'=g(\xbartaut)\def f(\xbartaut(0),\xbartaut(-\tau)) &\text{for } t\geq 0\\
    x(t)=x_0(t) & \text{for } t\in[-\tau,0]
\end{cases}
$$

##### Lemma
TODO: solving dde equiv to solving integral equation??? (-> Lemma) and compare with ODE lecture notes

Finding a solution of the DDE (??) is equivalent to computing the integral

$$
    x(t) = x_0(0) + \int_0^t g(\bar{x}_{\tau,s})ds
$$

##### Proof
integrate from discontinuity of $\xbartaut$ to discontinuity and proof stetige fortsetzbarkeit at these points

### Method of Steps
for $t\in [0,\tau]$, $x$ must satisfy the following ordinary initial value problem obtained by plugging the initial function into equation (??).
For suitable $f$ and $x_0$, the existence (and uniqueness) of a solution on $[0,\tau]$ is guaranteed by ODE theory (... or Picard-Lindelöf theorems).

This procedure can then be applied repeatedly to extend the obtained solution by steps of length $\tau$.

### Existence and Uniqueness of Solutions

$f$ Lipschitz
with piecewise continuous initial function
have existence and uniqueness ????
smoothing

##### Theorem
Consider the Delay Differential Equation

$$
\begin{cases}
    x'=f(\xbartaut) & \text{for } t\geq 0\\
    x(t)=x_0(t)     & \text{for } t\in [-\tau,0]
\end{cases}
$$

with $f:\statespace\rightarrow\R^2$ satisfying the (global) Lipschitz condition

$$ \exists L>0\,\forall x,y\in C^0([-\tau,0],\R^n) : \abs{f(x)-f(y)} \leq L\norm{x-y} $$

where $\abs{\cdot}$ denotes the Euclidian norm on $\R^?$ (TODO) and $\norm{\cdot}$ the supremum norm of the Banach space of continuous functions on $[-\tau,0]$.

and initial condition

Then there **exists** a **unique global solution** of the DDE.

##### Proof
use Theorem 3.7 from [] or ...
need open subset of $\statespace$
need topology

just proof existence/uniqueness on each peace of continuity
proof continuity at knots with Lemma of integral equ



### Example
The basic ODE IVP

$$ \begin{cases}
  x'(t) = -x(t)\\
  x(0) = x_0
\end{cases} $$

has the solution $x(t)=x_0 e^{-t}$.
However the similiar DDE

$$ \begin{cases}
  x'(t) = -x(t-\tau) & t\geq 0\\
  x(t) = x_0(t) & -\tau\leq t\leq 0
\end{cases} $$

has a much richer dynamics, but solution (as series)
for $x_0\equiv 1$, can compute first solutions by method of steps.
...

![plot](piecewise-initial-function.png)



### Definition

## Hybrid Programs with DDEs
Extent classic hybrid programs (HP) with syntax, semantics and axiomatization and proof rules for DDEs. Is a super set, \dL is a fragment

### Example
leading and following car


### Syntax
#### Terms
We extent the grammar defining **terms** with a symbol for a **delayed variable**

$$ \theta,\eta ::= x|\xtau|c|\theta+\eta|\theta\cdot\eta $$

### Semantics
HP $\alpha$
transition semantics
define inductively

remain unchanged

The temporal character of delay differential equations (they depend on their own temporal evolution with limited horizon) suggests the introduction of trace semantics.

However, we go the way of introducing transition semantics with an augmented state space.

#### Terms
Following the remark to the solution of a DDE, we change the **state space** to $\statespace$, the set of piecewise continuous functions, as defined above.

TODO: need \xbartau

Denote by $\states$ the set of states.
A state $\omega\in\states$ is a mapping $\omega : \mathcal{V}\cup\mathcal{V'}\rightarrow\statespace$
that assigns a _history_ (function) $\xbartau$ to each variable symbol and
FIXME diff var symbol.

The semantics of the variable symbols in terms are given by
$$ [[\xtau]]_\nu=\nu(x)(-\tau)\def:\xbartau(-\tau) $$
and
$$ [[x]]_\nu=\nu(x)(0)\def:\xbartau(0) $$

When we write $\xtau$ we mean $x(t-\tau)$ and with $x$ we mean $x(t)$.

#### Hybrid Programs
The transition semantic of a hybrid program is inductively given by a binary reachability relation $\rho(\alpha)\subseteq\states\times\states$.
Since the state space has been replaced, we need to redefine the semantics:

The _discrete assignment_ does not rewrite history, but changes only the value at the current time instant:
$$
\rho(x:=\theta) = \left\{(\nu,\omega): \omega = \nu \text{ except } \omega(x)=\left(t\mapsto\begin{cases}[[\theta]]_\nu & t=0\\ \nu(t) &t\in[-\tau,0)\end{cases}\right)\qquad\right\}_.
$$
This assignment is the actual reason why we need to consider piecewise continuous evolutions.

TODO: super dense time: multiple assignments

Using the extended syntax, we can write down both a delay differential equation and an ordinary differential equation in the form $x'=\theta$, where $\theta=f(x,\xtau)$ with a polynomial $f$.

$$
    \rho(x'=\theta\,\&\,\chi) = \left\{ (\varphi(0),\varphi(s))\,:\,\varphi(t)\models x'=\theta\,\wedge\,\varphi(t)\models\chi\,\forall\,0\leq t\leq s\text{ for a solution } \varphi:[0,s]\rightarrow\states \right\}
$$
As a solution, $\varphi$ needs to fulfill
$$
    \varphi(t)(x')(0) \def \DD{\varphi(\zeta)(x)(0)}{\zeta}(t) \stackrel{!}{=} [[\theta]]_{\varphi(t)(x)}
$$

## Delay Differential Dynamic Logic



\dL terms

### Dynamic Axioms

#### History Axiom
The occurence of $\xbartau$ in expressions can be replaced by turning the (implicitely existing) time variable explicit, \ie
$$
F(\xbartau) \leftrightarrow \forall\,-\tau\leq t\leq 0\, F(x(t))
$$

#### Axiom of Steps
The _Method of Steps_ presented above translates into an axiom. It allows to partially unwind an autonomous DDE given a analytic representation of its solution.

Let $\theta_0$ and $\theta$ be TODO ...
$$
    \xbartau = \theta_0 \rightarrow [x'=\theta(\xbartau)]\phi
    \leftrightarrow
    \left(\forall 0\leq t\leq\tau [x:= y(t)]\phi
    \wedge \xbartau = y \rightarrow [x'=\theta (\xbartau)] \right)
$$
where $\forall 0\leq t\leq\tau$, $y'(t)=\theta(\theta_0)$, \ie $y$ is a local solution of the DDE.
The solution must be expressible in polynomial form so that the axiom leads to decidable arithmetic.

##### Proof
apply methods of steps

### Proof Rules

#### Rule of Steps
condition valid for initial condition
and
given condition then condition holds after dde-evolution of max time tau
and
safety follows from condition
then
condition holds after dde with mentioned initial condition

$$
\frac{F(\theta_0)\quad F\rightarrow [x'=\theta() \& t\leq\tau]F \quad F\rightarrow\phi}{\xbartau = \theta_0 \rightarrow [x'=\theta(\xbartau)]\phi}
$$


#### Delay Differential Invariant

$$
\frac{}{\xbartau}
$$

Usually, one would try not to mention $\xtau$ in the invariant, since derivation would lead to the occurrence of the symbol $x_{2\tau}$, whose properties are out of the scope of the current state.

### Example
We want to proof the safety condition $\phi\equiv(-1\leq x\wedge x\leq 1)$ for the continuous program

TODO: can replace \xbartau with forall t? but then have t occuring

$$
    -1\leq\xbartau\leq 1 \rightarrow [x'=-\xtau]\phi.
$$
Use the algebraic differential invariant $F\equiv(-1\leq x^3\wedge x^3\leq1)$,
which is valid for the initial condition. Differentiation leads to the inequalities, which needs to be shown $\forall t\in[0,\tau]$
$$
    0\leq 3\,x(t)^2 x'(t) = -3\,x(t)^2 \xtau(t)
$$
This holds since
