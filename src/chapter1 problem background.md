# 1 Background of the problem

some introduction.

## Some backgound assumptions

This paper deals with Lipschitz constants of maps between spheres. Most of the time we will only estimate the Lipschitz constants up to a constant C, that only depends on the dimensions of the spheres. We denote equality/inequality up to a constant by $~, lessim$ respectively.
Throughout this paper let the unit spheres $S^m$, $S^n$ be equipped with the length metric induced by the standard Riemannian metric (unless stated otherwise). That is, the distance between any two points is determined by the (Euclidean) length of the geodesics between them [^length-metric]. Note that while the topology is the same, the metric is different from the "default" metric inherited from the ambient Euclidean space. Occasionally we will consider objects that are homeomorphic to spheres when it is convinient (e.g. surface of a cube or of a simplex), but the conversion only changes things up to some constrant. On those objects we will still be using the length metric.

Statement of the problem.

## Contracting the image of a lower dimensional sphere
For the first four lemmas we consider maps from $S^m$ to $S^n$ when $m$ is less than $n$. We know that the image of $S^m$ in $S^n$ is not-surjective (citation). It is then contractible. In this section we want to show that the image of a lower dimensional sphere can be contracted in a Lipschitz way, and to provide a fairly tight Lipschitz constant. We start by showing that a Lipschitz map must in fact miss a whole open ball in the target:

Lemma.
: Let $f: S^m \rightarrow S^n$ be a Lipschitz conituous maps with a Lipschitz constant $L$. Then the image of $f$ misses a ball of radius $r$ for $r \gtrsim L^\frac{-m}{n-m}$

A ball with respect to the length-metric on the sphere is a spherical cap. The radius of the ball is the length of any geodesic from the center (the tip) of the cap to its edge. It is equal to the polar angle of the cap in radians.

![Spherical cap. Here $r=1$, $\theta=\rho$, $a=\sin{\theta}$, $h=1-\cos{\theta}$](figures/chapter1/Spherical_cap_diagram.tiff){#fig:cap short-caption="Spherical cap" width="30%"}

For the proof of the lemma we will need to cover the sphere with spherical caps. To estimate the number of caps needed to cover the sphere we use a volume argument. A sloppy version of the argument would go as follows: 
We equip the sphere with a volume form that scales well with the polar angle and is equal to 1 on the whole sphere. Then the volume of the sphere is 1, the volume of each spherical cap is $rho^m$. The cover should have area similar to that of the sphere (up to a constant). We then need ~$1/\rho^m$ spherical caps to cover the sphere.


 This is a quick sketch version where we drop all constants. If you are not familiar with such arguments please review the much longer argument in the appendix.

Claim.
: For any $\rho>0$, the sphere $S^m$ can be covered by $~1/\rho^m$ balls of radius $\rho$.

Proof.
: Instead of covering the sphere $S^m$ we will cover the disk $D^m$. We can then collapse the boundary to a single point and the cover will certainly still cover the sphere. We set the volume form on the unit disk to be equal to 1. Then the volume of a (closed) ball of radius $\rho$ (which is again just an m-disk) is equal to $\rho^m$. We then need roughly $1/\rho^m$ disks to cover the whole unit disk. To convince yourself that the constant really only depends on m we can repeat the argument verbetim replacing disks with squares.

Definition (spherical cap).
: A closed **spherical cap** is the smaller portion of a unit sphere $S^m$ cut off by a plane (including the boundary). Formally, the spherical cap with angle $\rho \in (0, \pi/2]$ and center $x \in S^m$ is given by $$cap(x,\rho) = \{y \in S^m: \langle x,y \rangle \geq cos\rho\}.$$ We will call a spherical cap with a polar angle $\rho$ a **$\boldsymbol{\rho}$-cap**. Since we are dealing with a unit sphere, the polar angle in radians is precisely the length of any geodesic from the center (the tip) of the cap to its edge.

Claim (Lemmas 1.2, 1.3).
: Let $f: S^m \rightarrow S^n$ be a Lipschitz conituous maps with a Lipschitz constant $L$. Then the image of $f$ misses a ball of radius $r$ for $r \gtrsim L^\frac{-m}{n-m}$
: For each radius r there is a Lipschitz-contraction $G: S^n \setminus B_r \times [0,1] \rightarrow S^n \setminus B_r$. G has Lipschitz constant $\lesssim 1/r$ in the $S^n$ direction and $\lesssim 1$ in the $[0,1]$ direction. 

To prove the claim we will need a few tools. For the first part we will need an upper bound for the covering number of the sphere. We will start by recalling the necessary concepts, then proceed with a construction to procure the required bound. For the second part we will need the Riemannian metric on the sphere using polar coordinates. We will then demonstrate how to find a Lipschitz constant for Lipschitz maps between manifolds. 

Def (Covering, packing). \label{covering,packing}
: Let $(X,d)$ be a metric space, $K \subseteq X$. 
: A collection $C$ of points in $X$ is called an **$\boldsymbol{\rho}$-covering** of $K$ 
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

Remark: It is sufficient for us to show the upper bound up to a constant $c(m)$. The reason for that is that in later arguments we will be able to choose the radius of the cover small enough that any constant $c(m,n)$ can be "neutralized" for our purposes, so long as the quantities we omit do not vary with $\rho$.

Proof.
: Let us first consider a maximal packing of our sphere with spherical caps. For any such packing the total volume of spherical caps cannot exceed the volume[^volume] of the sphere. As the caps in a packing are disjoint, 
$$ M(\rho) \leq \frac {\omega^m(S^m)} {\omega^m(\rhocap{\rho})}. $$
Now, $S^m$ can be covered by exactly two $\pi$-caps, so $\omega^m(S^m)=2\omega^m(\rhocap{\pi})$. Rewriting the previous inequality we get:
$$ M(\rho) \leq \frac {2\omega^m(\rhocap{\pi})} {\omega^m(\rhocap{\rho})}. $$ {#eq:packing}
We would like to replace the $\rho$-caps in the inequality by $\rho$-disks, as they scale easier with $\rho$, and that would allow us to reduce the fraction. Projecting the cap down onto the disk at its base will reduce the volume[^cap-size], i.e. 
$\omega^m(\rhocap{\rho}) \geq \omega^m(\sin{\rho} D^m)$. Dividing both sides by the $m$-volume of a $\rho$-disk and simplifying we obtain the following inequality:
$$ \frac{1}{\left(\frac{\pi}{2}\right)^m} \leq \frac {\mathrm{sin}^m\rho} {\rho^m} = \frac {\omega^m(\sin{\rho} D^m)} {\omega^m(\rho D^m)} \leq \frac {\omega^m(\rhocap{\rho})} {\omega^m(\rho D^m)}, $$
where $\rho \in (0, \frac{\pi}{2}].$ Multiplying by $\left(\frac{\pi}{2}\right)^m$ we get:
$$ 1 \leq \left(\frac{\pi}{2}\right)^m \cdot \frac {\omega^m(\rhocap{\rho})} {\omega^m(\rho D^m)} $$ {#eq:multiple}
Multiplying inequal [@eq:packing] by a term [@eq:multiple] greater than 1 on the right yields:
$$ N(\rho) \leq M(\rho) \lesssim \frac {\omega^m(\rhocap{\pi})} {\omega^m(\rhocap{\rho})} \lesssim \frac{{\omega^m(\pi D^m)}}{{\omega^m(\rho D^m)}} = \frac{\pi^m}{\rho^m} \sim \frac{1}{\rho^m}. $$ 

<!---
I am suddenly changing the language from spherical caps to balls. i mean the same thing, this should be transitioned better!
Except implicitly, because I use the covering number (defined for balls) to talk about spherical caps.
-->

Lemma.
: Let $f\!: S^m \rightarrow S^n$ be a Lipschitz-conituous map with a Lipschitz constant $L$. Then the image of $f$ misses a ball of radius $r$ for $r \lesssim L^{-\frac{m}{n-m}}$

Proof.
: For any $\rho>0$, $S^m$ can be covered by $\sim \rho^{-m}$ balls of radius $\rho$. The image of each such ball is contained in a ball of radius $L\rho$. Therefore, the image of $f$ can be covered by $\lesssim \rho^{-m}$ balls of radius $L\rho$. We set $r:=L\rho$. We now want to choose $\rho$ small enough so that the cover misses a ball of radius $r$. 
: Expanding the radius of the cover to $2r$ yields a cover of the $r$-neighborhood of the image. We denote this $2r$-cover by $C$. If this larger cover does not cover the full sphere $S^n$, the image of $f$ must miss a ball of radius $r$. The total volume of the cover $C$ is at most the cardinality of $C$ times the volume of a $2r$-cap of $S^n$, $|C|\omega^n(\rhocap{2r})$. We set $\rho$ so that this number is smaller than the volume of the sphere. So we get for $n>m$
$$|C|\omega^n(\rhocap{2r}) \lesssim \rho^{-m}r^n = L^n\rho^{n-m} \lesssim 1,$$
$$\rho \lesssim L^{-\frac{n}{n-m}},$$
$$r = L\rho \lesssim L^{-\frac{m}{n-m}}.$$
In particular, the statement holds for any radius less or equal to r.

## Computing our first Lipschitz constant

### Detour: geometric suspension

If we equip the sphere $S^2$ with the usual pullback Riemannian metric, the resulting metric written in the matrix form is
$$g = \left( \begin{array}{cc} 1 & 0 \\ 0 & \sin^2\! \theta \end{array} \right).$$

Even more often in the literature one encounters the corresponding symmetric quadratic form - its first fundamental form - which can be written as:
$$ \dx s^2 = \dx\theta \otimes \dx\theta + \sin^2\! {\theta} \; \dx\phi \otimes \dx\phi, $$ or simply
$$ \dx s^2=\dx\theta^2 + \sin^2\! \theta \,\, \dx\phi^2. $$

We will now show that the metric is verbatim the same for $S^m$ for $\forall m \geq 2$

![Polar coordinates](figures/chapter1/polar.pdf){#fig:polar short-caption="Polar coordinates" width="80%"}

We can think of $S^m$ as of several $S^{m-1}$ stacked on top of each other (where  $S^{m-1}$ shrink to a single point at the poles). This is essentially the geometric version of suspension. Using the polar angle rather than height, we scale the equator $S^{m-1}$ by $\sin \theta.$

Point-wise this gives us that any point $p$ of $S^m$ can be parametrized in terms of the polar angle $\theta$ and the corresponding vector $\phi$ of the equator scaled down by $\sin \theta$ - polar coordinates with respect to $S^{m-1}$ [@fig:polar]. Fixing some direction $z$ in $\R^{m+1}$ we can write out the parametrization:
\begin{equation}
\begin{split}
    \psi : &[0,\pi] \times S^{m-1} \longrightarrow S^m \\
    &(\theta, \phi) \mapsto \sin \! \theta \cdot \phi + \cos\theta \cdot \Vec{e_z},
\end{split}
\end{equation}

where $\Vec{e_z}$ denote the standard basis vector in the $z$ direction. Computing partial derivatives yields 
$$ \pdv{\psi}{\theta} = \cos\theta \cdot \phi - \sin\theta \cdot \Vec{e_z}, $$
$$ \pdv{\psi}{\phi} = \sin\theta \cdot \Vec{e_z}.$$

THIS DOES NOT EXPLAIN THE WHY. also missing all the stuff about taking the product metric (maybe more relevant below). Would be nice to provide some reference to some theory (like, what we did with Max, perhaps less in-depth than what we did with Leutzinger).

Computing the spherical metric as a pullback of the $\R^{m+1}$ metric:
$$g_{\theta\theta} = \langle \cos\theta \cdot \phi - \sin\theta \cdot \Vec{e_z} , \cos\theta \cdot \phi - \sin\theta \cdot \Vec{e_z} \rangle = \cos^2 \theta \cdot \langle \phi,\phi \rangle + \sin^2 \theta \cdot \langle \Vec{e_z},\Vec{e_z} \rangle = 1, $$
$$g_{\phi\theta} = g_{\theta\phi} = 0,$$
$$g_{\phi\phi} = \sin^2 \theta$$
yielding the desired
$$g = \left( \begin{array}{cc} 1 & 0 \\ 0 & \sin^2\! \theta \end{array} \right).$$

Remark.
Note that in this we could replace $S^{m-1}$ with an arbitrary manifold $M$ of non-zero dimension [^0-dim]. Remarkably, since we are not using any knowledge of the underlying manifold $M$ to compute the suspension metric with respect to $M$, it is only the function that we use to shrink the manifold towards suspension poles that matters for this relative metric. Analogously, we could take an analytic version of any topological construction to obtain its geometric version.

The complement of a point in $S^n$ is contractible. If we remove a ball from $S^n$, the leftover part can be contracted in a Lipschitz way.

Lemma. 
: For each radius r there is a Lipschitz-contraction $G: S^n \setminus B_r \times [0,1] \rightarrow S^n \setminus B_r$. G has Lipschitz constant $\lesssim 1/r$ in the $S^n$ direction and $\lesssim 1$ in the $[0,1]$ direction. 

### Detour: manifolds with boundaries
We want to show that we can contract the target sphere $S^n$ in a Lipschitz way. For that we need to construct a differentiable map between the cylinder of $S^n$ and $S^n$. Reminder: the (topological) cylinder is the cartesian product with the interval. So we want a map between manifolds, both equipped with a metric. For the sake of consistency, we would prefer to equip both with the length metric. Naturally, we could take the product Riemannian metric. But the inerval is not a manifold, nor is the (topological) cylinder! For it is strictly speaking not Euclidean at the points on the boundary - in the interval dimension we can only move in one direction from the boundary $M \times \{0\}$. At those boundary points we do, however, have homeomorphism to the Euclidean half-space $\R^{m+1}$. We would like to relax the usual definition of a manifold to include manifolds with boundary:

Definition (manifold with boundary).
: definition here

Thus, the old manifolds are just manifolds with an empty boundary. Notably, the relaxed definition encompasses basic topological objects, such as the (closed) unit disk, the Moebius strip and topological cylinders as manifolds, the latter allowing us to consider differentiable homotopies.

All the usual definitions of dimension, tangent spaces etc apply to manifolds with boundaries. A manifold with a boundary also always admits a Riemannian metric:

Definition (Double).
: A double a manifold with a boundary is bla glued along their boundaries. A double is a manifold without a boundary.

\begin{observation} \label{Any manifold with a boundary admits a Riemannian metric.}
A double of a manifold $M$ admits a Reimannian metric. Selecting a metric and restricting to $M$ yields a Riemmanian metric on $M$. cite stackexchange because credit should be given where credit is due. 
\end{observation}

### Derivative of a differentiable map w.r.t. the metric
In this section we want to learn how to find Lipschitz constants for a given differentiable map between manifolds. We want learn how to compute the differential directly using the corresponding metrics, with respect to a given parametrization As usual we will equip our spaces with the length metric

Equipping our spaces with a specific metric allows for explicit computations of c'(t) for a given curve c(t), explicit computations of lengths of tangent vectors etc. In particular it allows us to compute partial derivatives w.r.t. to our chosen parametrization as local dilation and to give an upper bound for dilation of a given map between manifolds.

THIS IS STILL HORRIBLE - REWRITE!

Definition (Dilation, local dilation). \{dilation}
: The **dilation** of a mapping between metric spaces $X, Y$ is the (possibly infinite) number
$$dil(f) = 

Zusammenhang mit L, mit c'(t), mit Ableitung und Differential.

Proof.
: computation.



[^length-metric]: To be precise, the length of the geodesics is determined by the standard Riemmanian metric, where the metric is pulled back along the embedding of the spheres into their ambient Euclidean spaces ($\R^m$, $\R^n$, respectively). The lengths of geodesics are then precisely the respective Euclidean lengths of their embeddings. The reason to specify a metric so early on is that when we talk about Lipschitz continuity we are implicitly dealing with the metrics, not just with undelying topologies. However, since all of our results are up to a constant, suitable constant manipulation would show them to hold for the standard Eukledian metric as well. Nevertheless, we prefer to settle on a specific metric to avoid confusion or ambiguity.
[^volume]: We are referring to $m$-volumes. Think of surface areas in case $m=2$.
[^cap-size]: In fact it is easy to see that $\omega^m(\sin{\rho} D^m) \leq \omega^m(\rhocap{\rho}) \leq \omega^m(\rho D^m)$. We leave it for the appendix maybe.
[^0-dim]: For zero-dimensional manifolds $\dx\phi^2$ vanishes, leaving $\dx s^2=\dx\theta^2$ as the metric.