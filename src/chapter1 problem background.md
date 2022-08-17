# 1 Background of the problem

some introduction.

Gromov was able to show that there is a Lipschitz null-homotopy with the tower of exponentials. He apparently was also able to show linear dependency for the case m=n. (reference Guth).

## Some backgound assumptions

This paper deals with Lipschitz constants of maps between spheres. Most of the time we will only estimate the Lipschitz constants up to a constant $C(m,n)$, that only depends on the dimensions of the spheres. We denote equality/inequality up to a constant by $\sim, \lesssim, \gtrsim$ respectively.
Throughout this paper let the unit spheres $S^m$, $S^n$ be equipped with the length metric induced by the standard Riemannian metric (unless stated otherwise). That is, the distance between any two points is determined by the (Euclidean) length of the geodesics between them [^length-metric]. Note that while the topology is the same, the metric is different from the "default" metric inherited from the ambient Euclidean space. Occasionally we will consider objects that are homeomorphic to spheres when it is convinient (e.g. surface of a cube or of a simplex), but the conversion only changes things up to some constrant. On those objects we will still be using the length metric.

Statement of the problem.

## Contracting the image of a lower dimensional sphere
### Introduction to computations up to a constant
In this section we first consider Lipschitz maps from $S^m$ to $S^n$ when $m \lessthan n$. This case is fairly easy, as we know from topology that APPARENTLY THAT'S WRONG. we need piece-wise linearity or smoothness. We know that the image of $S^m$ in $S^n$ is not-surjective (citation). It is then contractible. In this section we want to show that the image of a lower dimensional sphere can be contracted in a Lipschitz way, and to provide a fairly tight Lipschitz constant. 

<!---
STATE THE FIRST PROPOSITION PROPERLY, introduce it and give a good reference! I also state the Lemma twice, that's a problem. I would like to lay out a plan for this section (i started drafting it on Saturday at the Grillplatz and never finished. Basically, here I want to lay out the game plan for this section. Maybe also mention how these proofs play a role in the later ones. Want to be extra specific about simplicial approximation not fitting into the m<n pattern.

i need to either explain what "fairly tight" means, or not write it at all.
--->

We start by showing that a Lipschitz map must in fact miss a whole open ball in the target:

Lemma.
: Let $f: S^m \rightarrow S^n$ be a Lipschitz conituous maps with a Lipschitz constant $L$. Then the image of $f$ misses a ball of radius $r$ for $r \lesssim L^\frac{-m}{n-m}$

Our strategy for proving this lemma will be to first cover the domain sphere by open balls of a set radius, then map that cover to the target sphere and show that the image of the cover cannot be surjective.

A ball with respect to the length-metric on the sphere is a spherical cap. The radius of the ball is the length of any geodesic from the center (the tip) of the cap to its edge. It is equal to the polar angle of the cap in radians.

![Spherical cap. Here $r=1$, $\theta$ is the polar angle, $a=\sin{\theta}$, $h=1-\cos{\theta}$](figures/chapter1/Spherical_cap_diagram.tiff){#fig:cap short-caption="Spherical cap" width="30%"}

<!---
Claim (Approximating a spherical cap).
: definition of a spherical cap, the idea of approximating by flat structures.
Can I avoid this altogether? I should just be able to use a better volume form. But i really like the new argument and this should be included for the sake of completeness.
--->

For the proof of the lemma we will need to cover the sphere with spherical caps. To estimate the number of caps needed to cover the sphere we use a volume argument. A sloppy version of the argument would go as follows: we equip the sphere with a volume form that scales well with the polar angle and is equal to 1 on the whole sphere. Then the volume of the sphere is 1, the volume of each spherical cap is $\rho^m$. The cover should have area similar to that of the sphere (up to a constant). We then need $\sim 1/\rho^m$ spherical caps to cover the sphere.

You may object: why should the cover have volume similar to that of the sphere if there is an overlap? Why should the overlap scale well with the radius? Is it okay for us to change the metric if the result is stated w.r.t. to a different one (we could of course use the standard volume but then you would be right to point out that spherical cap volume might not scale well with the cover radius). However, this argument is only meant to provide us with an intuition, and we aim to show that this types of arguments can be formalized fairly easily:

Claim.
: For any $\rho>0$, the sphere $S^m$ can be covered by $\sim 1/\rho^m$ balls of radius $\rho$.

<!---
the hemisphere disk equivalence should be stated separately!!
--->

Proof.
: We want to estimate the number of $1/\rho$ balls needed to cover the sphere. Covering the sphere is up to a constant the same as covering the hemisphere. In fact, the the cardinality of the cover for $S^m$ ~ Hemisphere $S^m_+$ ~ $D^m$ (we can tranfer the cover back and forth by projecting the hemisphere onto the equator disk or wrapping a larger disk around the hemisphere [^wrapping-up-a-ball] $= B^m$ ~ covering $\sqrt{2}B^m$ (scaling up) ~ covering the m-box of side length two (it can be squeezed between the two balls, i.e. it contains the unit ball and it is contained in the $\sqrt{2}B^m$) ~ covering the m-box of side length 1 (the unit m-box). It is easy to see why the volume argument should work now: the unit box can be clearly be covered by $\lceil 1/\rho \rceil ^m$ boxes of side length $\rho$. Each $\rho$-box is contained in a ball of radius $\rho$ and we are done.

Arguing up to a constant allows us great flexibility in choosing objects we are more comfortable working with. The constants we omitted can easily be traced back through the equivalence steps we took. However, if you are not yet comfortable working up to a constant there is a direct argument on the sphere without any equivalences or dropping constants that I provided in the appendix.

Lemma (Image of $f$ misses a ball). \label{f_misses_a_ball}
: Let $f\!: S^m \rightarrow S^n$ be a Lipschitz-conituous map with a Lipschitz constant $L$. Then the image of $f$ misses a ball of radius $r$ for $r \lesssim L^{-\frac{m}{n-m}}$

Proof.
: For any $\rho>0$, $S^m$ can be covered by $\sim \rho^{-m}$ balls of radius $\rho$. The image of each such ball is contained in a ball of radius $L\rho$. Therefore, the image of $f$ can be covered by $\lesssim \rho^{-m}$ balls of radius $L\rho$. We set $r:=L\rho$. We now want to choose $\rho$ small enough so that the cover misses a ball of radius $r$. 
: Expanding the radius of the cover to $2r$ yields a cover of the $r$-neighborhood of the image. We denote this $2r$-cover by $C$. If this larger cover does not cover the full sphere $S^n$, the image of $f$ must miss a ball of radius $r$. The total volume of the cover $C$ is at most the cardinality of $C$ times the volume of a ball of radius $2r$ (which is a spherical cap of polar angle $2r$). We replace the cap volume by the larger volume of a disk $2r \cdot D^n$ by essentially the same argument as we used to transfer the disk cover from the disk to the hemisphere HEMISPHERE IS ESSENTIALLY A spherical cap. Can we use the "special" volume form argument here instead????? and [^wrapping-up-a-ball]. The total cover volume is then at most $|C|\omega^n(\pi/2 \cdot B^n_2r)$, where $\omega^n$ denotes the Euclidean n-volume form?????.

<!---
This proof is still under construction. I want to make the remark about comparing a cap with a disk more universal, so that I can use is in all proofs. I will state it as a separate claim and would like to write out the map in a separate line and include a picture. The argument is simple and should be presented clearly, as it seems to be relevant in multiple spots.

Remark: It is sufficient for us to show the upper bound up to a constant $c(m)$. The reason for that is that in later arguments we will be able to choose the radius of the cover small enough that any constant $c(m,n)$ can be "neutralized" for our purposes, so long as the quantities we omit do not vary with $\rho$.
--->

We now set $\rho$ so that this number is smaller than the volume of the sphere. So we get for $n>m$
$$|C|\omega^n(\rhocap{2r}) \lesssim \rho^{-m}r^n = L^n\rho^{n-m} \lesssim 1,$$
$$\rho \lesssim L^{-\frac{n}{n-m}},$$
$$r = L\rho \lesssim L^{-\frac{m}{n-m}}.$$
In particular, even if f is a constant map we can choose $\rho$ small enough so that $r \leq \pi/2$

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
    &(\theta, \phi) \mapsto \sin\theta \cdot \phi + \cos\theta \cdot \Vec{e_z},
\end{split}
,
\end{equation}

where $\Vec{e_z}$ denote the standard basis vector in the $z$ direction. Computing partial derivatives yields 
$$ \pdv{\psi}{\theta} = \cos\theta \cdot \phi - \sin\theta \cdot \Vec{e_z}, $$
$$ \pdv{\psi}{\phi} = \sin\theta \cdot \Vec{e_z}.$$

<!----
THIS DOES NOT EXPLAIN THE WHY. also missing all the stuff about taking the product metric (maybe more relevant below). Would be nice to provide some reference to some theory (like, what we did with Max, perhaps less in-depth than what we did with Leutzinger).

this metric is not well defined at the polls. I suppose the parametrization is fine but its differential is not well defined at the polls either, because "direction sphere" is not a valid direction at the polls.
--->

Computing the spherical metric as a pullback of the $\R^{m+1}$ metric:
$$g_{\theta\theta} = \langle \cos\theta \cdot \phi - \sin\theta \cdot \Vec{e_z} , \cos\theta \cdot \phi - \sin\theta \cdot \Vec{e_z} \rangle = \cos^2 \theta \cdot \langle \phi,\phi \rangle + \sin^2 \theta \cdot \langle \Vec{e_z},\Vec{e_z} \rangle = 1, $$
$$g_{\phi\theta} = g_{\theta\phi} = 0,$$
$$g_{\phi\phi} = \sin^2 \! \theta$$
yielding the desired
$$g = \left( \begin{array}{cc} 1 & 0 \\ 0 & \sin^2\! \theta \end{array} \right).$$

Remark.
Note that in this we could replace $S^{m-1}$ with an arbitrary manifold $M$ of non-zero dimension [^0-dim]. Remarkably, since we are not using any knowledge of the underlying manifold $M$ to compute the suspension metric with respect to $M$, it is only the function that we use to shrink the manifold towards suspension poles that matters for this relative metric. Analogously, we could take an analytic version of any topological construction to obtain its geometric version.

<!---
should I use array or matrix? do i care about consistency? spacing seems nicer in an array.

This part is still a bit raw, have to recall what me and Max had been talking about, maybe actually sit down and discuss it with him.
--->

The complement of a point in $S^n$ is contractible. If we remove a ball from $S^n$, the leftover part can be contracted in a Lipschitz way.

Lemma (contraction lemma) \label{contraction}. 
: For each radius r there is a Lipschitz-contraction $G: ( S^n \setminus B_r ) \times [0,1] \rightarrow S^n \setminus B_r$. G has Lipschitz constant $\lesssim 1/r$ in the $S^n$ direction and $\lesssim 1$ in the $[0,1]$ direction. 

We choose the obvious contraction map:
$$G: ( S^n \setminus B_r ) \times [0,1] \rightarrow S^n \setminus B_r$$
$$G: (\rho, \theta, t) \rightarrow ((1-t)\rho, \theta)$$
Our goal is to compute its Lipschitz constants in both the sphere and the time direction. The strategy is to find the supremum of the differential applied to the appropriate tangent vectors and use it as an upper bound for the Lipschitz constants. The theoretical foundation for this approach is the mean value theorem for manifolds (REFERENCE).

State the mean value theorem, reference. 

Proof.
: Let $G$ be as above. Its differential is
\begin{equation*}
\dx G=
\begin{pmatrix}
1-t & 0 & -\rho \\
0 & 1 & 0
\end{pmatrix}
\end{equation*}
We start with the Lipschitz constant in the direction of the sphere by restricting to tangent vectors in the sphere direction, i.e. with the zero time component $(v_\rho, v_\theta, 0) \in T_p((S^n \setminus B_r) \times [0,1])$. It is of course the same as to fix $t$ as a parameter and consider the family of maps $G_t$ that are self-maps of the punctured sphere $S^n \setminus B_r$. We want compute the operator norm $\|\dx G_t\|$ (REFERENCE):
$$\|\dx G_t\| = \sup_{v \neq 0} \frac{\|\dx G_tv\|_{G(p)}}{\|v\|_p} = \sup_{\|v\|_p=1} \|\dx G_tv\|_{G(p)},$$ 
where $v = (v_\rho, v_\theta) \in T_p(S^n \setminus B_r), p=(\rho, \theta), G_t(p) = ((1-t)\rho, \theta)$ and we apply the sphere metric we computed in the section above. So for $\dx G_tv$ we have:
\begin{equation*}
\dx G
\begin{pmatrix}
v_\rho \\
v_\theta \\
0
\end{pmatrix}
= \dx G_t v=
\begin{pmatrix}
1-t & 0\\
0 & 1
\end{pmatrix}
\cdot
\begin{pmatrix}
v_\rho \\
v_\theta
\end{pmatrix}
= (1-t)^2 v^2_\rho + v^2_\theta 
\end{equation*}
$$\|v\|_p=1 \Leftrightarrow v^2_\rho + v^2_\theta \sin^2 \! \rho = 1$$
$$\|\dx G_t v\|^2_{G(p)} = v^2_\rho (1-t)^2 + v^2_\theta \sin^2 \! ((1-t)\rho)
= v^2_\rho \cdot (1-t)^2 + (1-v^2_\rho) \cdot \frac{ \sin^2 \! ((1-t)\rho) }{ \sin^2\!\rho }, \text{ where } 0 \leq v^2_\rho \leq 1$$
So the value we are interested in maximizing is a convex combination of two terms, $(1-t)^2$ and $\frac{ \sin^2((1-t)\rho) }{ \sin^2\rho }$. We can find the supremum for each term, pick the larger one and be done. Instead let us first take a closer look at what is happening here. The two terms are just the operator norm in the directions of $\rho$ and $\theta$ respectively. The reason why the norm is just a convex combination of the two is because the metric has no mixed terms, i.e. because the metric matrix $dG_t$ is diagonal.
$$\|\dx G_t v\|^2_{G(p)} = v^2_\rho \cdot \frac{ \|\dx G \Vec{v_\rho\|^2 }}{ \|\Vec{v_\rho}\|^2 } + (1-v^2_\rho) \cdot \frac{ \|\dx G \Vec{v}_\theta \|^2 }{ \|\Vec{v_\theta}\|^2 }$$
$$\|\dx G_t\| = \max\{ \|\dx G_{\theta, t}\| , \|\dx G_{\rho, t}\| \}, \text{ where } \|\dx G_{\theta, t}\| = \sup(1-t), $$
$$\|\dx G_{\rho, t}\| = \sup_{v_\theta \neq 0} \frac{ \|\dx G \Vec{v}_\theta \|_{G(p)} } { \| \Vec{v}_\theta \|_p } = \sup_{v_\theta \neq 0} \frac{ \| \Vec{v_\theta}\|_{G(p)} }{ \|\Vec{v}_\theta \|_p } = \sup_{\substack{v_\theta \neq 0, \\ \rho \neq 0}} \frac{ \sqrt{ \sin^2 \! ((1-t)\rho) } }{ \sqrt{ \sin^2\!\rho } } = \sup_{\rho \neq 0} \frac { \sin((1-t)\rho) }{ \sin\rho }$$
Direction $\rho$ is the boring one, as $\sup(1-t)=1$ is achieved at $t=0$, where the sine quotient also equals $1$ for $t=0$. Thus, we can focus solely on the direction $\theta$ of the lateral spheres[^pole].
INSERT SPHERE CONTRACTION PICTURE HERE
For large $r>\pi/2$ the Lipschitz constant $L \lessthan 1$, as increasing t only reduces the fraction. Geometrically, for  contraction then only shrinks the lateral spheres together with their tangent vectors.
For $r \lessthan \pi/2$ we achieve the largest possible stretch of the tangent vectors when the latteral spheres $S^{n-1}$ grow the most via $G$, that is, when p sits at the boundary of $S^n \setminus B_r$ and G(p) sits at the equator sphere. There
$$\rho = \pi - r; \; (1-t)\rho = \pi/2$$
$$\|\dx G_t\| = \|\dx G_{\rho, t}\| = \frac { \sin(\pi/2) }{ \sin(\pi - r) } = \frac {1}{\sin r} \sim r^{-1}.$$


<!---
PRIORITY (after writing out the strategy for this section)
could try using a border matrix.

put operator norm into a separate remark? note that dG is a bounded operator.

we should consider the pole point for the domain sphere separately:
First off, let us address the limitations of the representation we chose for our metric, namely the pole point. There where where $\rho=0$, thus G fixes by the pole and dG_{\rho=0} is identity on the tangent space. Hence, \|dG_{\rho=0}\|=1.

we don’t have to worry about the product metric because i am considering the components of the product separately.
a generic tangent vector v in the direction of the sphere (i.e. with the zero time component) is v in TpM, where $$$p=(\rho, \theta, t)$$ 
v=v_1 time dG/d\rho + v_2 times dG/d\theta

REFERENCE APPENDIX manifolds with boundary
--->

[^pole]: We still have to address the case $\rho=0$. This is the pole point where our metric repersentation is not well defined. $G$ fixes the pole and $dG_t$ on the pole tangent space is identity. Hence at that point $\|dG_t|{\rho=0}\|=1$.

CONTINUE HERE!!!

The bound we proved is not particularly good. In the standard proof that the image of a lower dimensional sphere is not surjective one approximates the sphere by piece-wise linear maps. We can explore this idea further by introducing simplicial approximation.
<!------
CONTINUE HERE!!! SIMPLICIAL APPROXIMATION THEOREM
------>

## Simplicial approximation

Simplicial complexes are often neglected in presentation, so it might be beneficial to agree on some basic definitions.

Definition (simplicial complex).
: A simplicial complex $K$ is a collection of simplices satisfying the following conditions:
: (1) Every face of a simplex in $K$ also lies in $K$
: (2) A non-empty intersection of two simlices in $K$ $\sigma_1 \cap \sigma_2 \neq \varnothing$ is a face of both $\sigma_1$ and $\sigma_2$.

Additionally we equip a simplicial complex $K$ with coherent topology of its simplices: a subset $U$ is open in $K$ iff $U \cap \sigma$ is open for all $\sigma \in K$.

**Observation.**

- A simplex $\sigma$ is closed in $K$.
- The interior of a single vertex is the vertex itself. The boundary of a vertex is empty.
- A simplicial complex is a union of interiors of its simplices.

We will restrict our attention to finite simplicial complexes.  
By default a simplicial complex $K$ has a topology but no metric. A **geometric realization |K|** of $K$ on the other hand carries the metric that restricts to the subspace Euclidean metric on each simplex. This metric thus obviously agrees with the topology of K (i.e. $K \cong |K|$). If $K$ has $N+1$ vertices one can simply choose a realization as the subsimplex of the standard N simplex $\Delta^N$.

Definition (star).
: Let $K$ be a simplicial complex. The **closed star** of a simplex $\sigma$ in $K$ **St$\sigma$** is the union of all simplices containing $\sigma$. The **open star** of a simplex $\sigma \in K$ st$\sigma$ is the union of interiors of all simplices containing $\sigma$.

**Observation:** 
Closed stars are closed. Open stars are open. St$\sigma$ is the closure of st$\sigma$.  

Of a special interest to us are stars of vertices. A star of a vertex v is the combinatorial analog of a ball around v. A closed star of a vertex caputures all adjacent and incident edges, while open stars of vertices provide an open cover that is just shy of containing the adjacent vertices - this cover is expecially useful for simplicial approximation.
<!-----
Picture open/ closed STAR OF A VERTEX
There are some nice pictures on wikipedia that I could borrow.
--->

Claim (Lemma 2C.2 in Hatcher) \label{sterneschnitt}.
: Let $v_1, v_2, \dots, v_k \in VertK$. Then $\mathrm{st}v_1 \cap \mathrm{st}v_2 \cap \dots \cap \mathrm{st}v_k$ is either empty or $\sigma=[v_1, v_2, \dots, v_k] \in K$ and $\mathrm{st}v_1 \cap \mathrm{st}v_2 \cap \dots \cap \mathrm{st}v_k = \mathrm{st}\sigma$.

Definition. 
: Let $K,J$ be simplicial complexes.
We call a map $f_0: VertK \rightarrow VertJ$ that takes the vertex set of $K$ to the vertex set of $J$ a **vertex map**. 
: A map $f: K \rightarrow J$ that is linear on each simplex of $K$ w.r.t. the barycentric coordinates is called a **simplicial map**.

**Observation:** A simplicial map restricts to a vertex map. A vertex map that can be linearly extended to a simplicial map if for each simplex $\sigma$ its vertices are mapped to vertices of some target simplex.

Now that we have collected all the necessary tools we proceed with simplicial approximation. We start with a classical result on simplicial approximation.

Theorem (cf. Hatcher).
: If $K$ is a finite simplicial complex and $J$ is an arbitrary simplicial complex, then any map $f: K \rightarrow J$ is homotopic to a map that is simplicial with respect to some iterated barycentric subdivision of $K$.

We don't actually intend to prove this result, but rather highlight some of the ideas that we want to translate to the Lipschitz setting:

1. We equip $K$ with a metric as described above. In particular with this metric open stars are open and closed stars are closed in K. Distances within the simplex are also well behaved - all points are at most as far apart as the largest side length.
<!-------
How does Hatcher define simplicial complexes? NO. Don't they already have a topology? Abstract ones don't. Geometric realizations do. Are we dealing with abstract simplicial complexes? It seems like we are dealing with abstract simplicial complexes (which are usually just called simplicial complexes), because if we were given a geometric realization in R^n it would have a metric defined on it already. instead we say "define some metric".
------>
2. Observe that open stars form a covering of $J$. Taking pre-image of that cover yields an open cover of K. Since K is a finite simplicial complex it is in particular compact. We take the finite subcover and find its Lebesgue number (it exists by the Lebesgue number lemma). This gives us a way to determine the desired size of the simplices of K. 
3. Now let us subdivide K until the simplices are small enough that closed star of a vertex v is contained in some cover element. This means we managed to contain the closed nighborhood of a vertex - adjacent edges and their vertices - fully in a reasonably small region of the the simplex. Edges can't wrap around our simplex multiple times and vertices cannot be too far apart. Meaning we have a chance of building a simplicial map.  
This is as much of the proof as we need for now - see Hatcher for more details and the contruction.

To translate this idea to a Lipschitz map setting we want to replace Lebesgue number using our Lipschitz constant. First we need both our spaces to be metric. We have to pay attention to several thnigs: 

FRame THE DISCUSSION!

We want distance between vertices in J to be uniform (can normalize it to 1).
J cannot have singletons.

The key observation here is that in a Lipschitz setting we can avoid using the Lebesgue number of the open star cover altogether. If the image of a vertex maps close to some vertex we can just take it as our approximation. A bad case is if a vertex maps far from any vertex while still close to some edge. So let us consider what happens if some vertex v maps to the barycenter of an $n$-simplex $\Delta^n$ of side length 1. To contain $B(Im(v), c(n))$ in an open star of any vertex we would need to set the radius $c(n)$ to be less than the shortest distance from the barycenter to the face of the n-simplex, i.e. $c(n) := dist(barycenter, \partial \Delta^n) - \epsilon$. But that distance is determined by $n$ and it grows smaller as $n$ increases. Meaning this was indeed the worst case scenario we have determined the required constant without referring to the Lebesgue number!



<!-----
Definition.
: Let K be a simplicial complex, X be a metric space and L some constant. We define the special triangulation TriL

Theorem (Simplicial approximation of a Lipschitz map).
Let $J$ be a finite simplicial complex of dimension $n$ and let $|J|$ be an equilteral realization of $J$ with edges of length 1. Let X be a metric space and $f: X \rightarrow |J|$ be a Lipschitz map with Lipschitz constant $L$. If $X$ admits a triangulation TriL into "almost equilateral simplices" of side length at most than $c(n)/L$ with bi-lipschitz constant  (to be clarified later) then there is  and |K| of a finite complex $K$ where each simplex is homeomorphic to some standard simplex of side-length 1/L with bi-lipschitz constant ~1. 
and |K| consists of simplices of side length at most c(n)/L, where c(n) 
----->


Theorem (Simplicial approximation of a Lipschitz map) \label{simp}. 
: Let $J$ be a finite simplicial complex of dimension $n$ and let $|J|$ be an equilteral realization of $J$ with edges of length 1. Let $f: |K| \rightarrow |J|$ be a Lipschitz map with Lipschitz constant $L$ and let $c(n)$ be defined as in the discussion above. If $|K|$ has equilateral simplices of side length $c(n)/L$ then $f$ can be approximated by a simplicial map with Lipschitz constant $L/c(n)$ and a homotopy $H_{simp}$ with Lipschitz constant $\dots$. More generally, if each simplex of $|K|$ is homeomorphic to some standard simplex of side-length $1/L$ with bi-lipschitz constant $\sim 1$ (i.e. homeomorphisms are Lipschitz in both directions with constants $\lambda(K), \gamma(K)$) then the constants are $C(K, n)L$ for $f_{simp}$ and blah in direction and $\sim 1$ in the time direction respectively.

<!-----
the worst the bi-lipschitz constant(s) the worst the Lipschitz constant of the simplicial approximation.
talk about generalizations?
---->

Proof.
: By the discussion above we can guarantee that for each $v \in VertK$ there is a vertex $g(v) \in VertJ$ such that St$v \subset \text{st} g(v)$. Thus $g: VertK \rightarrow VertJ$ defines a vertex map. We want to show that it extends to a simplicial map. Let $x$ be a point in the interior of $[v_1, v_2, \dots, v_k]$. Then $f(x)$ is contained in each of the stars $st$g(v_i)$. Thus by the claim \ref{sterneschnitt} above $\sigma= [g(v_1), g(v_2), \dots, g(v_k)]$ is a simplex in $J$ and we can extend the vertex map $g$ to a simplicial map $f_{simp}$. Again by claim \ref{sterneschnitt} we conclude that $f(x) \in st(\sigma)$ and thus there is a simplex $\sigma'$ that contains $f(x)$ in its interior and contains $\sigma$ as a face (does not have to be a proper face, i.e. it is possible that $\sigma'=\sigma$). We conclude that $f(x), f_{simp}(x) \in \sigma'$. We can now simply take the straight line homotopy, i.e. (cf HATCHER).  
$$ H_{simp}=(1-t)f+tf_{simp} $$
It remains to verify that the Lispchitz constants hold. $f_{simp}$ extends linearly on simplices, thus for equilateral K the constant multiple is deterined entirely by the ratio of edge lengths, i.e. $1/c(n) > 1$. The Lipschitz constant o $f_{simp}$ in this case is thus $L/c(n)$. For the more general version this is magnified by how much the shortest edge in K need to be stretched, which is at most the product $\lambda \cdot \gamma$ of the Lipschitz constants of the bi-lipschitz simplex homeomorphisms in both directions, which depend solely on $K$. The total constant thus amounts to $C(K, n) := frac{\lambda\gamma}{c(n)}\cdot L \sim L$.  
Finally, we have to determine the Lipschitz constants of the homotopy. Note that $C(K, n) > 1/c(n) > 1$, thus for  a given $t$ $H_{simp}(t)$ has Lipscihtz constant $(1-t)L+tC(K,n)L$. Meaning in the sphere direction the constant is at most C(K,n)L and in the time direction the Lipschitz constant grows linearly with $C(K,n)$. This finishes the proof.

### Approximating maps between spheres

Definition (triangulation).
: Let $K$ be a simplicial complex, $X$ a topological space. A homeomorphism $\phi: K \rightarrow X$ is called a **triangulation** of $X$.
: Let $f: X \rightarrow Y$ be a map between mertic spaces, $\phi: (K, d_k) \rightarrow X$, $\psi: (J, d_j) \rightarrow Y$ - bi-lipschitz triangulations. Then if there is a simplicial approximation $g_{simp}$ of $g := \phi \circ f \circ \psi^{-1}$ we call $f_{simp} := \phi^-1 \circ g_{simp} \circ \psi$ the simplicial approximation of $f$.
\begin{center}
    \begin{tikzcd}
		X \arrow[r, "f_{simp}"] & Y \\
		(K, d_k) \arrow[u, "\phi"] \arrow[r, "g_{simp}"] 
			& (J, d_j) \arrow[u, "\psi"]
	\end{tikzcd}
\end{center}
We now want to find triangulations for out spheres so that we can apply the simplicial approximation to them. We will pick triangulations that suit our purposes for the main result.

We start with a triangulation of $S^n$ by the boundary of the unilateral $n+1$-simplex $\partial Delta^{n+1}$. This obviously uses very few vertices, thereby limiting the quality of our approximation, so let me try to motivate this choice of triangulation (the motivation will become apparent in the upcoming proofs): for the main result in case $m \geq n$ we need all vertices to be pairwise incident (i.e. any two vertices to share an edge). This will allow us to "approximate" the null-homotopy to some extent witout any further geometric information about it. Furthermore, we would like simplices to be both equilateral and to have equal area. This already determines our triangulation uniquely (up to rotations). Additionally, $\partial Delta^{n+1}$ is defined for all dimensions (as opposed to, say, a triangulation of S^2 by the surface of icosahedron, that does not gereralize well to other dimensions). $\partial Delta^{n+1}$ is bi-lipschitz homeomorphic to S^n with bi-lipschitz constants $\sim 1$ only depending on $n$.

It is notably more difficult to triangulize $S^m$ so that its triangulation fits the theorem. In fact, the proof of the main theorem requires us to be able to triangulate not only S^m but the whole unit ball, $B^{m+1}$. One difficulty with it is that the Lipschitz constant of our approximation is determined entirely by the shortest side length(s) in the metric simplicial complex: $(length(s) \cdot L \cdot 1/c(n))^{-1}$. At the same time the side-length needs to be stricty less than $c(n)/L$
<!-----
ATTENTION! HOW do i define c(n)? i can just define it without epsilon and then require the lipschitz constant direction ball $\phi$ to be strictly less than c(n)/L, for an equilateral simpex of side-length one.

This whole thing about shortest side should be moved up to motiate the bi-lipschitz requirement.??? Ideally into th esame pre-discussion before the theorem??
---->
We formulate this as an exercise and leave the solution for the appendix. 

Exercise. Find a family of geometric simplicial complexes $(K, |K|)$ together with a bi-lipschitz triangulation of the unit ball $Tri_L: |K| \rightarrow B^{m+1}$ such that the Lipschitz constant in the direction of the ball is less than 1. We require furthermore that each simplex in $(K, |K|)$ is bilipschitz homeomorphic to the unilateral simplex $\Delta ^{m+1}$. We require the maximum over Lipschitz constants of maps $\Delta \rightarrow B^{m+1}$ to be bounded by $c(n)/L$. 

<!------
This is tsated in a horribly convoluted way - rewrite
------>

Theorem (cf 1.4 Guth) \label{sphere_approx}. 
: If $m \lessthan n$ and $f: S^m \rightarrow S^n$ has Lipschizt consntat $L$, then tehre is a null-homotopy with Lipschitz constant $\lesssim L$. In fact the null-homotopy has Lipschitz constant $\lesssim L$ in the $S^m$ directions and $\lesssim 1$ in the [0,1] direction.

Proof.
: Consider the map between simplices instead. Approximate g using Theorem \ref{simp}. g_{simp} is piecewise linear hence not surjective (REFERENCE ARGUMENT either above or in the appendix!). Thus $g_simp$ misses a whole simplex! Now back on the sphere simplicial approximation of $f$ $f_{simp} misses a ball of radius $~1$ in $S^n$. Applying Lemma 1.3 \ref{contarction}

Remark. Lemmas 1.2 and Propositoin bla shows that Lipschitz maps for dim $m \lessthan n$ are null-homotopic inedpendently. Both is stronger than what we need for the main proof. Note that we did not use Lemmas 1.1-1.2. ADD A REMARK AT THE BEGINNING THAT THESE CAN BE SKIPPED.

**Remark.** This bound is basically tight. I did not verify this, Guth recommends it as an exercise.

<!------
both differentiable manifolds are equipped with length-metrics. Those metrics should agree with the simplicial structure - we would like edges of a simplex to be geodesic segments (and shortest paths), simplices should not budge out too much - e.g. there shouldn't be distances longer than the longest edge - to avoid weird counterexamples. We 
repeat step one.
take the smallest diameter of the star and denote it by diam(J). diam(J) could be described purely in terms of the smallest side-length involved in the finite cover and a constant depending only on the size of the simplex. This already involves a choice.
---->

[^length-metric]: To be precise, the length of the geodesics is determined by the standard Riemmanian metric, where the metric is pulled back along the embedding of the spheres into their ambient Euclidean spaces ($\R^m$, $\R^n$, respectively). The lengths of geodesics are then precisely the respective Euclidean lengths of their embeddings. The reason to specify a metric so early on is that when we talk about Lipschitz continuity we are implicitly dealing with the metrics, not just with undelying topologies. However, since all of our results are up to a constant, suitable constant manipulation would show them to hold for the standard Euclidean metric as well. Nevertheless, we prefer to settle on a specific metric to avoid confusion or ambiguity.

[^wrapping-up-a-ball]: Projecting the hemisphere $S^m_+$ down onto the unit disk $D^m$ at the equator obviously only changes things up to a constant (depending only on m): we project down the cover centers and keep the radius as is. Showing that the cover can be transferred in the other direction is a little trickier: we start by scaling the cover up by a factor of $\pi/2$ to cover $\pi/2D^m$. We then wrap the larger disc around the hemisphere by taking $(\theta, r)$ to $(\theta, \rho)=(\theta, r), where %\theta \in S^{m-1}$, $r$ is the radius and $\rho$ is the polar angle. Distances can only reduce for the same reason that we can wrap a paper around a ball without tearing it and the paper will wrinkle: radial components of distances stay the same and angular components srink with a factor of sine as the radius increases. Of course if you are not convinced you can scale your disk up by another factor of two. Same as before, keeping the projected cover centers and the old cover radius yield a cover.

[^0-dim]: For zero-dimensional manifolds $\dx\phi^2$ vanishes, leaving $\dx s^2=\dx\theta^2$ as the metric.