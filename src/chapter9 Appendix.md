# Appendix

## Covering a sphere by spherical caps.

Here we provide a direct and more thourough argument to cover the sphere $S^m$ by spherical caps. In this argument we do not drop constants. We start with a quick introduction to the topic of covering and packing: 

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
Let P be a $\rho$-packing. Then the balls ${B_{1/2\rho}(p)}$ are pairwise disjoint (triangle inequality). \newline 
If P is maximal, then P is also an $\rho$-covering (by contraposition). In particular, this implies $N(\rho) \leq M(\rho)$
\end{observation}

Claim. 
: $M(2\rho) \leq  N(\rho) \leq M(\rho)$

Proof. 
: The second inequality follows from the observation above. To prove the first inequality, assume $M(2\rho)>N(\rho)$. Then by the pigeon-hole principle there are two points $x,y$ of the packaging contained in the same $\rho$-ball of the cover. By triangle inequality this yields a contradiction.

We are now going to provide an upper bound for the covering number of a sphere. Geomtrically, we will be covering a sphere by spherical caps of equal size. We are interested in exploring the relationship between the size of the caps and the covering number.

Definition (spherical cap).
: A closed **spherical cap** is the smaller portion of a unit sphere $S^m$ cut off by a plane (including the boundary). Formally, the spherical cap with angle $\rho \in (0, \pi/2]$ and center $x \in S^m$ is given by $$cap(x,\rho) = \{y \in S^m: \langle x,y \rangle \geq cos\rho\}.$$ We will call a spherical cap with a polar angle $\rho$ a **$\boldsymbol{\rho}$-cap**. Since we are dealing with a unit sphere, the polar angle in radians is precisely the length of any geodesic from the center (the tip) of the cap to its edge.

[@fig:cap]

Lemma.
: The covering number of a sphere $N(S^m,d,\rho)$ $\lesssim \rho^{-m}$, where $d$ is the length-metric. That is, for any $\rho>0$, the sphere $S^m$ can be covered by at most (up to a constant) $1/\rho^m$ $\rho$-caps.

Remark: It is sufficient for us to show the upper bound up to a constant $c(m)$. The reason for that is that in later arguments we will be able to choose the radius of the cover small enough that any constant $c(m,n)$ can be "neutralized" for our purposes, so long as the quantities we omit do not vary with $\rho$.

Proof.
: Let us first consider a maximal packing of our sphere with spherical caps. For any such packing the total volume of spherical caps cannot exceed the volume[^volume] of the sphere. As the caps in a packing are disjoint, 
$$ M(\rho) \leq \frac {\omega^m(S^m)} {\omega^m(\rhocap{\rho})}. $$
Now, $S^m$ can be covered by exactly two $\frac{\pi}{2}$-caps, so
$\omega^m(S^m)=2\omega^m(\rhocap{\frac{\pi}{2}})$. Rewriting the inequality above we get:
$$ M(\rho) \leq \frac {2\omega^m(\rhocap{\frac{\pi}{2}})} {\omega^m(\rhocap{\rho})}. $$  {#eq:packing}
We would like to replace the $\rho$-caps in the inequality by $\rho$-disks, as they scale easier with $\rho$, and that would allow us to reduce the fraction. Projecting the cap down onto the disk at its base will reduce the volume[^cap-size], i.e. 
$\omega^m(\rhocap{\rho}) \geq \omega^m(\sin{\rho} D^m)$. Dividing both sides by the $m$-volume of a $\rho$-disk and simplifying we obtain the following inequality:
$$ \frac{1}{\left(\frac{\pi}{2}\right)^m} \leq \frac {\mathrm{sin}^m\rho} {\rho^m} = \frac {\omega^m(\sin{\rho} D^m)} {\omega^m(\rho D^m)} \leq \frac {\omega^m(\rhocap{\rho})} {\omega^m(\rho D^m)}, $$
where $\rho \in (0, \frac{\pi}{2}].$ Multiplying by $\left(\frac{\pi}{2}\right)^m$ we get:
$$ 1 \leq \left(\frac{\pi}{2}\right)^m \cdot \frac {\omega^m(\rhocap{\rho})} {\omega^m(\rho D^m)} $$ {#eq:multiple}
Multiplying inequality [@eq:packing] by a term [@eq:multiple] greater than 1 on the right yields:
$$ N(\rho) \leq M(\rho) \leq \frac {2\omega^m(\rhocap{\frac{\pi}{2}})} {\omega^m(\rhocap{\rho})} \leq  \left(\frac{\pi}{2}\right)^m \cdot \frac{2\omega^m(\frac{\pi}{2} D^m)}{\omega^m(\rho D^m)} = \left(\frac{\pi}{2}\right)^{2m} \cdot \frac{2}{\rho^m} \sim \frac{1}{\rho^m}. $$

<!---
I am suddenly changing the language from spherical caps to balls. i mean the same thing, this should be transitioned better!
Except implicitly, because I use the covering number (defined for balls) to talk about spherical caps.
-->

For proof of next Lemma \ref{f_misses_a_ball} (explicit constants):
$$|C|\omega^n(\rhocap{2r}) \leq  \left(\frac{\pi}{2}\right)^{2m-n} \cdot \frac{2}{\rho^m} \cdot (2r)^n \cdot \omega^n(\rhocap{\frac{\pi}{2}}) \leq \omega^n({S^n}) = 2\omega^n(\rhocap{\frac{\pi}{2}}),$$
simplified, this becomes
$$\left(\frac{\pi}{2}\right)^{2m-n} \cdot \frac{(2r)^n}{\rho^m} \leq 1.$$
Using $r=L\rho$ and $m<n$ we choose $\rho>0$ small enough to obey
$$\rho \leq \left(\frac{L}{\pi}\right)^{-\frac{n}{n-m}} \cdot \left(\frac{\pi}{2}\right)^{-\frac{2m}{n-m}}.$$

it then follows for $r$
$$ r = L\rho \leq \left(\frac{\pi^2L}{4}\right)^{-\frac{m}{n-m}} \cdot \pi^{\frac{n}{n-m}}.$$

### Detour: manifolds with boundaries
We want to show that we can contract the target sphere $S^n$ in a Lipschitz way. For that we need to construct a differentiable map between the cylinder of $S^n$ and $S^n$. Reminder: the (topological) cylinder is the cartesian product with the interval. So we want a map between manifolds, both equipped with a metric. For the sake of consistency, we would prefer to equip both with the length metric. Naturally, we could take the product Riemannian metric. But the interval is not a manifold, nor is the (topological) cylinder! For it is strictly speaking not Euclidean at the points on the boundary - in the interval dimension we can only move in one direction from the boundary $M \times \{0\}$. At those boundary points we do, however, have homeomorphism to the Euclidean half-space $\R^{m+1}$. We would like to relax the usual definition of a manifold to include manifolds with boundary:

Definition (manifold with boundary).
: The only difference is charts are allowed to be half-spaces. A definition can be found in any reference for calculus on manifolds. See e.g. [@Spivak]

Thus, the old manifolds are just manifolds with an empty boundary. Notably, the relaxed definition encompasses basic topological objects, such as the (closed) unit disk, the Moebius strip and topological cylinders as manifolds, the latter allowing us to consider differentiable homotopies.

All the usual definitions of dimension, tangent spaces etc apply to manifolds with boundaries. A manifold with a boundary also always admits a Riemannian metric:

Definition (Double).
: A double a manifold with a boundary is a union of two copies of the manifold glued along their boundaries. A double is a manifold without a boundary.

\begin{observation} \label{Any manifold with a boundary admits a Riemannian metric.}
A double of a manifold $M$ admits a Reimannian metric. Selecting a metric and restricting to $M$ yields a Riemmanian metric on $M$.
\end{observation}

<!-----
cite stackexchange because credit should be given where credit is due. 

### Derivative of a differentiable map w.r.t. the metric
In this section we want to learn how to find Lipschitz constants for a given differentiable map between manifolds. We want learn how to compute the differential directly using the corresponding metrics, with respect to a given parametrization As usual we will equip our spaces with the length metric

Equipping our spaces with a specific metric allows for explicit computations of c'(t) for a given curve c(t), explicit computations of lengths of tangent vectors etc. In particular it allows us to compute partial derivatives w.r.t. to our chosen parametrization as local dilation and to give an upper bound for dilation of a given map between manifolds.

THIS IS STILL HORRIBLE - REWRITE!

[^volume]: We are referring to $m$-volumes. Think of surface areas in case $m=2$.

----->

## On "bi-lipschitz to equilateral" triangulation of a sphere/ball
The solution is to subdivide a hypercube into smaller hypercubes (essentially breaking a cube up with a uniform grid). Then we subdivide each face by connecting barycenters to vertices until we have a triangulation. Cube is obviously bilipschitz to a ball.
![Triangulating a box](figures/boxes.png){#fig:boxes short-caption="Triangulation $Tri_L$" width="70%"}

One issue that arises is the grid step. It is especially noticeable for larger grids, which implies smaller Lipschitz constants. This dependency between grid jumps and Lipschitz constants allows us to write the jump off as a constant multiple:
For a natural number $k \in \N$ we end up wanting a value of side-length $\frac{c(n)}{L}$, that sits between two available side-lengths:
$$\frac{1}{k} \leq \frac{c(n)}{L} \leq \frac{1}{k-1}$$ 
Instead we solve the problem $\frac{L}{k-1}\cdot C \geq 1$ to find the constant that adjusts for the jump in values.

We could probably use greedy subdivision with moving the points heuristically after to achieve uniform lengths, but it would become a stochastic/numerical problem. It would be notably harder to show and it wouldn't eliminate the problem of the step entirely, albeit it would make the jumps considerably smoother. It is also only really relevant for improving the constant multiple for the simplicial approximation of f, not of the homotopy - the degrees there will create massive constants where such small improvements are of no relevance. Nonetheless, simplicial approximation may be interesting on its own and I think the problem itself is an interesting in its own right.

Almost equilateral triangulations of spaces are called **a mesh** of that space. [@mesh] deals with meshes for hyperspaces.
There is also a software package that handles triangulation of a hypersphere in an optimal way. There are also other meshes, I haven't looked into whether it can triangulate hyperballs too. [https://rdrr.io/cran/mvmesh/](https://rdrr.io/cran/mvmesh/man/PolarSphere.html)

<!---
do I still need this footnote for any argument?
[^cap-size]: In fact it is easy to see that $\omega^m(\sin{\rho} D^m) \leq \omega^m(\rhocap{\rho}) \leq \omega^m(\rho D^m)$. We leave it for the appendix maybe.
--->