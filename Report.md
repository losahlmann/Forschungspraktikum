# Delay Hybrid Systems

## Delay Differential Equations

### Definition
autonomous (time independent)
constant, discrete delay(s)
In general, one could also consider equations with distributed delay
If the right hand side only depends on $x(t-\tau)$ and not on $x(t)$, we call the DDE _pure_.

### Definition of Solution
global,
partly

### Method of Steps

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

[plot]

## Piecewise Continuous Functions

### Definition

## Hybrid Programs with DDEs
Extent classic hybrid programs (HP) with syntax, semantics and axiomatization and proof rules for DDEs. Is a super set, \dL is a fragment

### Example
leading and following car


### Syntax
#### Terms
We extent the definitions of terms with a symbol for a **delayed variable**

$$ \theta,\eta ::= x|\xtau|c|\theta+\eta|\theta\cdot\eta $$

### Semantics
HP $\alpha$
binary reachability relation $\rho(\alpha)\subseteq\states\times\states$
transition semantics
define inductively

remain unchanged

### Terms
New **state space** $\statespace$, the set of piecewise continuous functions.

Denote by $\states$ the set of states.
A state $\omega\in\states$ is a mapping $\omega : \mathcal{V}\cup\mathcal{V'}\rightarrow\statespace$
that assigns a _history_ (function) $\xbartau$ to each variable symbol and diff var symbol.

$$ [\xtau]_\nu=\nu(x)(-\tau)=:\xbartau(-\tau) $$

and update the semantics of

$$ [x]_\nu=\nu(x)(0)=:\xbartau(0) $$

So when we write $\xtau$ we mean $x(t-\tau)$ and with $x$ we mean $x(t)$.

### Continuous Programs
Using that, we can write down a delay differential equation or an ordinary differential equation in the form $x'=\theta$, where $\theta=f(x,\xtau)$ with a polynomial $f$.

### Discrete Programs
discrete assignment
does not rewrite history
hence piecewise continuous functions
super dense time: multiple assignments



## Delay Differential Dynamic Logic

\dL terms

### Axiomatization

#### Method of Steps

### Proof Rules

#### Rule of Steps

### Example
We want to proof the safety condition $\phi\equiv(-1\leq x\wedge x\leq 1)$.
Use the algebraic differential invariant
$F\equiv(-1\leq x^3\wedge x^3\leq1)$.
