# 1 Background of the problem

The first case we consider are maps from $S^m$ to $S^n$ when $m<n$. We first provide a quantitative argument for contractibility of a Lipschitz-map, namely that the image of any such map misses a ball in the target. We then produce a null-homotopy with a controlled Lipschitz constant.

Claim (Lemmas 1.2, 1.3).
: Let $f: S^m \rightarrow S^n$ be a Lipschitz conituous maps with a Lipschitz constant $L$. Then the image of $f$ misses a ball of radius $r$ for $r \gtrsim L^\frac{-m}{n-m}$
: For each radius r there is a Lipschitz-contraction $G: S^n \setminus B_r \times [0,1] \rightarrow S^n \setminus B_r$. G has Lipschitz constant $\lesssim 1/r$ in the $S^n$ direction and $\lesssim 1$ in the $[0,1]$ direction. 

To prove the claim we will need a few tools. For the first part we will need an upper bound for the covering number of the sphere. We will start by showing an easy upper bound for the covering number of the unit ball. For that we will briefly recall some simple results about covering and packing. Then we will attempt to show a better but a much more sophisticated bound for the sphere.

For the second part we will need the Riemannian metric on the sphere using polar coordinates. We will then demonstrate how to find a Lipschitz constant for Lipschitz maps between manifolds. 

Def (Covering, packing). \label{covering,packing}
: Let $(X,d)$ be a metric space, $K \subseteq X$. 
: A collection of points $C$ in $X$ is called an **$\rho$-covering** of $K$ 
if *K* is contained in the union of $\rho$-balls around points in $C$, i.e. $K  \subseteq \bigcup\limits_{p\in C} B_\rho(p)$. In other words, for $\forall x \in K$ there is a $p$ in $C$ such that $d(p,x)\leq\rho$. Note that we do not require the centers of $\rho$-balls to lie in K. Such a covering is also called an **external $\rho$-covering**.
The minimum $\rho$-covering cardinality is called the **(external) covering number** of $K$ denoted **$N(K,d,\rho)$** or simply **$N(\rho)$**.
: A collection *P* of points in *K* is called an **$\rho$-packing** if for $\forall p, q \in P$ $d(p,q)>\rho$ 

<!---
the set ${B_\rho(x)}$ is pairwise disjoint.
That is, $d(x,y) > 2\rho$ 
is this correct? what if the subspace is curved? 
Such as is the case with the sphere and a eukledian metric?
-->
The maximum packing cardinality is called the **packing number** of *K* and is denoted by  **$M(K,d,\rho)$** or simply **$M(\rho)$**.

\begin{observation} \label{packing-covering-relation}
Let P be an $\rho$-packing. Then the balls ${B_{1/2\rho}(p)}$ are pairwise disjoint (triangle inequality). \newline 
If P is maximal, then P is also an $\rho$-covering (by contraposition). In particular, this implies $N(\rho) \leq M(\rho)$
\end{observation}

Claim. 
: $M(2\rho) \leq  N(\rho) \leq M(\rho)$

Proof. 
: The second inequality follows from the observation above. To prove the first inequality, assume $M(2\rho)>N(\rho)$. Then by the pigeon-hole principle there are two points $x,y$ of the packaging contained in the same $\rho$-ball of the cover. By triangle inequality this yields a contradiction.

We are now going to provide an upper bound for the covering number of a sphere. Geomtrically, we will be covering a sphere by spherical caps of equal size. We are interested in exloring the relationship between the size of the caps and the covering number.

Definition (spherical cap).
: A closed **spherical cap** is the smaller portion of a unit sphere $S^m$ cut off by a plane (including the boundary). Formally, the spherical cap with angle $\rho \in [0, \pi/2]$ and center $x \in S^m$ is given by $$cap(x,\rho) = \{y \in S^m: \langle x,y \rangle \geq cos\rho\}.$$ We will call a spherical cap with a polar angle $\rho$ a **$\rho$-cap**. Since we are dealing with a unit sphere, the polar angle in radians is precisely the length of any geodesic from the center (the tip) of the cap to its edge.

INSERT PICTURE HERE

Lemma.
: The covering number of a sphere $N(S^m,d,\rho)$ $\lesssim \rho^{-m}$, where $d$ is the length-metric. That is, for any $\rho>0$, the sphere $S^m$ can be covered by at most (up to a constant) $1/\rho^m$ $\rho$-caps.

Proof.
: Let us first consider a maximal packing of our sphere with spherical caps. For any such packing the total volume of spherical caps cannot exceed the volume of the sphere. As the caps in a packing are disjoint, $M(\rho) \leq Vol(S^m) / Vol(\rho-cap)$.  
: Now, $S^m$ can be covered by exactly two $\pi$-caps. Thus, $Vol(S^m)=2Vol(\pi-cap)$. If we knew that $Vol(\rho-cap) \sim \rho^m Vol(1-cap)$ then the volumes in the fraction would reduce giving the desired result. Thus, it remains to show that the volume of an $\rho$-cap scales by a factor $\sim \rho^m$.  
$$Vol(\rho-cap) = \int\limits_0^\rho f(x) \, \mathrm{d} x$$

Lemma.
: : Let $f: S^m \rightarrow S^n$ be a Lipschitz conituous maps with a Lipschitz constant $L$. Then the image of $f$ misses a ball of radius $r$ for $r \gtrsim L^\frac{-m}{n-m}$

Proof.
: 

When (X,d) is the m+1-dimension Eukledian space $\mathbb{R}^{m+1}$, we can provide some concrete bounds:
Theorem.
: 
Example (m-sphere)
