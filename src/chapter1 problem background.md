# 1 Background of the problem

some introduction.

## Some backgound assumptions

This paper deals with Lipschitz constants of maps between spheres. Most of the time we will only estimate the Lipschitz constants up to a constant $C(m,n)$, that only depends on the dimensions of the spheres. We denote equality/inequality up to a constant by $\sim, \lesssim, \gtrsim$ respectively.
Throughout this paper let the unit spheres $S^m$, $S^n$ be equipped with the length metric induced by the standard Riemannian metric (unless stated otherwise). That is, the distance between any two points is determined by the (Euclidean) length of the geodesics between them [^length-metric]. Note that while the topology is the same, the metric is different from the "default" metric inherited from the ambient Euclidean space. Occasionally we will consider objects that are homeomorphic to spheres when it is convinient (e.g. surface of a cube or of a simplex), but the conversion only changes things up to some constrant. On those objects we will still be using the length metric.

Statement of the problem.

## Contracting the image of a lower dimensional sphere
### Introduction to computations up to a constant
In this section we first consider Lipschitz maps from $S^m$ to $S^n$ when $m \lessthan n$. This case is fairly easy, as we know from topology that  We know that the image of $S^m$ in $S^n$ is not-surjective (citation). It is then contractible. In this section we want to show that the image of a lower dimensional sphere can be contracted in a Lipschitz way, and to provide a fairly tight Lipschitz constant. 

<!---
STATE THE FIRST PROPOSITION PROPERLY, introduce it and give a good reference! I also state the Lemma twice, that's a problem. I would like to lay out a plan for this section (i started drafting it on Saturday at the Grillplatz and never finished. Basically, here I want to lay out the game plan for this section. Maybe also mention how these proofs play a role in the later ones. Want to be extra specific about simplicial approximation not fitting into the m<n pattern.
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
    &(\theta, \phi) \mapsto \sin \! \theta \cdot \phi + \cos\theta \cdot \Vec{e_z},
\end{split}
\end{equation}

where $\Vec{e_z}$ denote the standard basis vector in the $z$ direction. Computing partial derivatives yields 
$$ \pdv{\psi}{\theta} = \cos\theta \cdot \phi - \sin\theta \cdot \Vec{e_z}, $$
$$ \pdv{\psi}{\phi} = \sin\theta \cdot \Vec{e_z}.$$

<!----
THIS DOES NOT EXPLAIN THE WHY. also missing all the stuff about taking the product metric (maybe more relevant below). Would be nice to provide some reference to some theory (like, what we did with Max, perhaps less in-depth than what we did with Leutzinger).
--->

Computing the spherical metric as a pullback of the $\R^{m+1}$ metric:
$$g_{\theta\theta} = \langle \cos\theta \cdot \phi - \sin\theta \cdot \Vec{e_z} , \cos\theta \cdot \phi - \sin\theta \cdot \Vec{e_z} \rangle = \cos^2 \theta \cdot \langle \phi,\phi \rangle + \sin^2 \theta \cdot \langle \Vec{e_z},\Vec{e_z} \rangle = 1, $$
$$g_{\phi\theta} = g_{\theta\phi} = 0,$$
$$g_{\phi\phi} = \sin^2 \theta$$
yielding the desired
$$g = \left( \begin{array}{cc} 1 & 0 \\ 0 & \sin^2\! \theta \end{array} \right).$$

Remark.
Note that in this we could replace $S^{m-1}$ with an arbitrary manifold $M$ of non-zero dimension [^0-dim]. Remarkably, since we are not using any knowledge of the underlying manifold $M$ to compute the suspension metric with respect to $M$, it is only the function that we use to shrink the manifold towards suspension poles that matters for this relative metric. Analogously, we could take an analytic version of any topological construction to obtain its geometric version.

<!---
should I use array or matrix? do i care about consistency? spacing seems nicer in an array.

This part is still a bit raw, have to recall what me and Max had been talking about, maybe actually sit down and discuss it with him.
--->

The complement of a point in $S^n$ is contractible. If we remove a ball from $S^n$, the leftover part can be contracted in a Lipschitz way.

Lemma. 
: For each radius r there is a Lipschitz-contraction $G: S^n \setminus B_r \times [0,1] \rightarrow S^n \setminus B_r$. G has Lipschitz constant $\lesssim 1/r$ in the $S^n$ direction and $\lesssim 1$ in the $[0,1]$ direction. 

Proof.
: There is a very obvious contraction map:

$$G: S^n \setminus B_r \times [0,1] \rightarrow S^n \setminus B_r$$
$$G: (\rho, \theta, t) \rightarrow ((1-t)\rho, \theta)$$

We want to compute its Lipschitz constants in both the sphere and the time direction. Our strategy is to find the supremum of the differential applied to the appropriate tangent vectors. The theoretical foundation for that is the mean value theorem for manifolds (REFERENCE).

\begin{equation*}
\dx G=
\begin{pmatrix}
1-t & 0 & -\rho \\
0 & 1 & 0
\end{pmatrix}
\end{equation*}

We start with the Lipschitz constant in the direction of the sphere by restricting to tangent vectors in the sphere direction, i.e. with the zero time component $v=(v_\rho, v_\theta, 0),$ where $v \in T_p(S^n \setminus B_r \times [0,1])$. It is of course the same as to fix t as a parameter and consider $G_t$ as a self-map of the punctured sphere $S^n \setminus B_r$. We want compute the operator norm $\|\dx G_t\|$ (REFERENCE):
$$\|\dx G_t\| = \sup_{v \neq 0} \frac{\|\dx G_tv\|}{\|v\|} = \sup_{\|v\|=1} \|\dx G_tv\|, \text{ where } v \in T_pS^n \setminus B_r, p=(\rho, \theta) $$


\begin{equation*}
\begin{pmatrix}
1-t & 0 & -\rho \\
0 & 1 & 0
\end{pmatrix}
\cdot
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

Then using the sphere metric we computed earlier for at $p=(\rho, \theta)$ and $G_t(p) = ((1-t)\rho, \theta)$ respectively, $ \|v\|=1$ yields,
$$v^2_1+\sin^2 v^2 = 1$$
$$\|\dx G_t v\| = \sqrt{(1-t)^2 v^2_\rho + sin^2(1-t)\rho \cdot v^2_\theta}
= \sqrt{ v^2_\rho \cdot (1-t)^2 + (1-v^2_\rho) \cdot \frac{ sin^2(1-t)\rho }{ sin^2\rho }}$$


<!---
CONTINUE HERE!!! PRIORITY (after writing out the strategy for this section)
could try using a border matrix.

I should be more explicit at which points the differential happens!!!!!

put operator norm into a separate remark, note that dG is a bounded operator.

here i want to tex the computations from the new notebook with the sketches.
we don’t have to worry about the product metric because i am considering the components of the product separately.
a generic tangent vector v in the direction of the sphere (i.e. with the zero time component) is v in TpM, where $$$p=(\rho, \theta, t)$$ 
v=v_1 time dG/d\rho + v_2 times dG/d\theta
we want to compute the operator norm REFERENCE ||dG|| WRITE OUT FORMULA
to simplify the computation we set a:=1-t,

then dGv = 

REFERENCE APPENDIX manifolds with boundary
--->

[^length-metric]: To be precise, the length of the geodesics is determined by the standard Riemmanian metric, where the metric is pulled back along the embedding of the spheres into their ambient Euclidean spaces ($\R^m$, $\R^n$, respectively). The lengths of geodesics are then precisely the respective Euclidean lengths of their embeddings. The reason to specify a metric so early on is that when we talk about Lipschitz continuity we are implicitly dealing with the metrics, not just with undelying topologies. However, since all of our results are up to a constant, suitable constant manipulation would show them to hold for the standard Euclidean metric as well. Nevertheless, we prefer to settle on a specific metric to avoid confusion or ambiguity.

[^wrapping-up-a-ball]: Projecting the hemisphere $S^m_+$ down onto the unit disk $D^m$ at the equator obviously only changes things up to a constant (depending only on m): we project down the cover centers and keep the radius as is. Showing that the cover can be transferred in the other direction is a little trickier: we start by scaling the cover up by a factor of $\pi/2$ to cover $\pi/2D^m$. We then wrap the larger disc around the hemisphere by taking $(\theta, r)$ to $(\theta, \rho)=(\theta, r), where %\theta \in S^{m-1}$, $r$ is the radius and $\rho$ is the polar angle. Distances can only reduce for the same reason that we can wrap a paper around a ball without tearing it and the paper will wrinkle: radial components of distances stay the same and angular components srink with a factor of sine as the radius increases. Of course if you are not convinced you can scale your disk up by another factor of two. Same as before, keeping the projected cover centers and the old cover radius yield a cover.

[^0-dim]: For zero-dimensional manifolds $\dx\phi^2$ vanishes, leaving $\dx s^2=\dx\theta^2$ as the metric.