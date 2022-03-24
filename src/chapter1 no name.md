# 1 Background of the problem

The first case we consider are maps from $S^m$ to $S^n$ when $m<n$. Throughout this paper let the unit spheres $S^m$, $S^n$ be equipped with the length metric induced by the standard Riemannian metric. That is, the distance between any two points is determined by the (Euclidean) length of the geodesics between them [^length-metric]. Note that while the topology is the same, the metric is different from the "default" metric inherited from the ambient Eukledian space.

We first provide a quantitative argument for contractibility of a Lipschitz-map, namely that the image of any such map misses a ball in the target. We then produce a null-homotopy with a controlled Lipschitz constant.

Claim (Lemmas 1.2, 1.3).
: Let $f: S^m \rightarrow S^n$ be a Lipschitz conituous maps with a Lipschitz constant $L$. Then the image of $f$ misses a ball of radius $r$ for $r \gtrsim L^\frac{-m}{n-m}$
: For each radius r there is a Lipschitz-contraction $G: S^n \setminus B_r \times [0,1] \rightarrow S^n \setminus B_r$. G has Lipschitz constant $\lesssim 1/r$ in the $S^n$ direction and $\lesssim 1$ in the $[0,1]$ direction. 

To prove the claim we will need a few tools. For the first part we will need an upper bound for the covering number of the sphere. We will start by recalling the necessary concepts, then proceed with a construction to procure the required bound. For the second part we will need the Riemannian metric on the sphere using polar coordinates. We will then demonstrate how to find a Lipschitz constant for Lipschitz maps between manifolds. 

Def (Covering, packing). \label{covering,packing}
: Let $(X,d)$ be a metric space, $K \subseteq X$. 
: A collection of points $C$ in $X$ is called an **$\boldsymbol{\rho}$-covering** of $K$ 
if *K* is contained in the union of $\rho$-balls around points in $C$, i.e. $K  \subseteq \cup_{p\in C} B_\rho(p)$. In other words, for $\forall x \in K$ there is a $p$ in $C$ such that $d(p,x)\leq\rho$. Note that we do not require the centers of $\rho$-balls to lie in K. Such a covering is also called an **external $\boldsymbol{\rho}$-covering**.
The minimum $\rho$-covering cardinality is called the **(external) covering number** of $K$ denoted $N(K,d,\rho)$ or simply $N(\rho)$.
: A collection *P* of points in *K* is called an **$\boldsymbol{\rho}$-packing** if for $\forall p, q \in P$ $d(p,q)>\rho$.
<!---
the set ${B_\rho(x)}$ is pairwise disjoint.
That is, $d(x,y) > 2\rho$ 
is this correct? what if the subspace is curved? 
Such as is the case with the sphere and a eukledian metric?
-->
The maximum packing cardinality is called the **packing number** of *K* and is denoted by  $M(K,d,\rho)$ or simply $M(\rho)$.

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
: A closed **spherical cap** is the smaller portion of a unit sphere $S^m$ cut off by a plane (including the boundary). Formally, the spherical cap with angle $\rho \in (0, \pi/2]$ and center $x \in S^m$ is given by $$cap(x,\rho) = \{y \in S^m: \langle x,y \rangle \geq cos\rho\}.$$ We will call a spherical cap with a polar angle $\rho$ a **$\boldsymbol{\rho}$-cap**. Since we are dealing with a unit sphere, the polar angle in radians is precisely the length of any geodesic from the center (the tip) of the cap to its edge.

![Spherical cap. Here $r=1$, $\theta=\rho$, $a=\sin{\theta}$, $h=1-\cos{\theta}$](figures/chapter1/Spherical_cap_diagram.tiff){#fig:cap short-caption="Spherical cap" width="30%"}

Lemma.
: The covering number of a sphere $N(S^m,d,\rho)$ $\lesssim \rho^{-m}$, where $d$ is the length-metric. That is, for any $\rho>0$, the sphere $S^m$ can be covered by at most (up to a constant) $1/\rho^m$ $\rho$-caps.

Remark: It is sufficient for us to show the upper bound up to a constant $c(m)$. The reason for that is that in later arguments we will be able to choose the radius of the cover small enough that any constant $c(m,n)$ can be "neutralized" for our purposes, so long as the quantities we omit do vary with $\rho$.

Proof.
: Let us first consider a maximal packing of our sphere with spherical caps. For any such packing the total volume of spherical caps cannot exceed the volume[^volume] of the sphere. As the caps in a packing are disjoint, 
$$ M(\rho) \leq \frac {\omega^m(S^m)} {\omega^m(\rhocap{\rho})}. $$
Now, $S^m$ can be covered by exactly two $\pi$-caps, so $\omega^m(S^m)=2\omega^m(\rhocap{\pi})$. Rewriting the previous inequality we get:
$$ M(\rho) \leq \frac {2\omega^m(\rhocap{\pi})} {\omega^m(\rhocap{\rho})}. $$ {#eq:packing}
We would like to replace the $\rho$-caps in the inequality by $\rho$-disks, as they scale easier with $\rho$, and that would allow us to reduce the fraction. Projecting the cap down onto the disk at its base will reduce the volume, i.e. 
$\omega^m(\rhocap{\rho}) \geq \omega^m(\sin{\rho} D^m)$[^cap-size]. Dividing both sides by the $m$-volume of a $\rho$-disk and simplifying we obtain the following inequality:
$$ \frac{1}{\left(\frac{\pi}{2}\right)^m} \leq \frac {\mathrm{sin}^m\rho} {\rho^m} = \frac {\omega^m(\sin{\rho} D^m)} {\omega^m(\rho D^m)} \leq \frac {\omega^m(\rhocap{\rho})} {\omega^m(\rho D^m)}, $$
where $\rho \in (0, \frac{\pi}{2}].$ Multiplying by $\left(\frac{\pi}{2}\right)^m$ we get:
$$ 1 \leq \left(\frac{\pi}{2}\right)^m \cdot \frac {\omega^m(\rhocap{\rho})} {\omega^m(\rho D^m)} $$ {#eq:multiple}
Multiplying inequal [@eq:packing] by a term [@eq:multiple] greater than 1 on the right yields:
$$ N(\rho) \leq M(\rho) \lesssim \frac {\omega^m(\rhocap{\pi})} {\omega^m(\rhocap{\rho})} \lesssim \frac{{\omega^m(\pi D^m)}}{{\omega^m(\rho D^m)}} = \frac{\pi^m}{\rho^m} \sim \frac{1}{\rho^m}. $$ 

Lemma.
: Let $f\!: S^m \rightarrow S^n$ be a Lipschitz-conituous map with a Lipschitz constant $L$. Then the image of $f$ misses a ball of radius $r$ for $r \gtrsim L^{-\frac{m}{n-m}}$

Proof.
: For any $\rho>0$, $S^m$ can be covered by $\sim \rho^{-m}$ balls of radius $\rho$. The image of each such ball is contained in a ball of radius $L\rho$. Therefore, the image of $f$ is covered by $\lesssim \rho^{-m}$ balls of radius $L\rho$. We set $r:=L\rho$. We now want to choose $\rho$ small enough so that the cover misses a ball of radius $r$. 
: Expanding the radius of the cover to $2r$ yields a cover of the $r$-neighborhood of the image. We denote this $2r$-cover by $C$. If this larger cover does not cover the full sphere $S^n$, the image of $f$ must miss a ball of radius $r$. The total volume of the cover $C$ is at most the cardinality of $C$ times the volume of a $2r$-cap of $S^n$, $|C|\omega^n(\rhocap{2r})$. We set $\rho$ so that this number is smaller than the volume of the sphere. So we get 
$$|C|\omega^n(\rhocap{2r}) \lesssim \rho^{-m}r^n = L^n\rho^{n-m} \lesssim 1,$$
$$\rho \lesssim L^{-\frac{n}{n-m}},$$
$$r = L\rho \lesssim L^{-\frac{m}{n-m}}.$$

The complement of a point in $S^n$ is contractible. If we remove a ball from $S^n$, the leftover part can be contracted in a Lipschitz way.

Lemma. 
: For each radius r there is a Lipschitz-contraction $G: S^n \setminus B_r \times [0,1] \rightarrow S^n \setminus B_r$. G has Lipschitz constant $\lesssim 1/r$ in the $S^n$ direction and $\lesssim 1$ in the $[0,1]$ direction. 

Proof.
: 

[^length-metric]: To be precise, the length of the geodesics is determined by the standard Riemmanian metric, where the metric is pulled back along the embedding of the spheres into their ambient Euclidean spaces ($\mathbb{R}^m$, $\mathbb{R}^n$, respectively). The lengths of geodesics are then precisely the respective Euclidean lengths of their embeddings. The reason to specify a metric so early on is that when we talk about Lipschitz continuity we are implicitly dealing with the metrics, not just with undelying topologies. However, since all of our results are up to a constant, suitable constant manipulation would show them to hold for the standard Eukledian metric as well. Nevertheless, we prefer to settle on a specific metric to avoid confusion or ambiguity.
[^volume]: We are referring to $m$-volumes. Think of surface areas in case $m=2$.
[^cap-size]: In fact it is easy to see that $\omega^m(\sin{\rho} D^m) \leq \omega^m(\rhocap{\rho}) \leq \omega^m(\rho D^m)$. We leave it for the appendix maybe.