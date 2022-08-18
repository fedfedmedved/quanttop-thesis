# n is odd theorem
Theorem ([CDMW]). Suppose that $n$ is odd and $f: S^m \rightarrow S^n$ is a null-homotopic map with Lipschitz constant $L$. Then there is a null-homotopy $H: S^m \times [0,1] \rightarrow S^n$ with Lipschitz constant at most $C(m,n)L$.

## Proof angle and outline
Here are some preparatory steps for the proof:

1. A null-homotopy from an arbitrary space $X$ can be described as a map from the cone of X to the target. Recall that the **cone** of $X$ **CX** is simply the cyllinder of $X$ with one end collapsed to a point: $X \times [0,1] / X \times \{0\}$. Cone of $S^m$ is homeomorphic to the unit ball $B^{m+1}$. To see this, think of radius of the ball as the variable for the interval. (picture for $S^1$). Thus, a null-homotopy of $f$ can be viewed as a map from $B^{m+1}$.
2. We first take a simplicial approximation of the map $f$ (ref Theorem \ref{simp}) using triangulations $Tri_L$ and $Tri_{S^n}$ as defined in the pre-discussion to Theorem \ref{sphere_approx}. The simplicial approximation is still null-homotopic:
cylinder composed with the cone picture here.
Therefore it suffices to prove the claim for $f: S^m, Tri_L \rightarrow S^n, Tri_S^n$.
3. We endow $B^{m+1}$ with a simplicial structure $Tri_L$ using the procedure from the pre-discussion to Theorem \ref{sphere_approx}.

We now have the following setup: we are given a map $h: (B^{m+1}, Tri_L) \rightarrow (S^n, Tri_{S^n})$ (the default null-homotopy for $f$) with $h_{| \partial B^{m+1}} \rightarrow (S^n, Tri_{S^n})$ simplicial with Lipschitz constant $L$ (our map $f$).

Our strategy for the proof is to "straighten out" $h$ skeleton by skeleton: we iteratively homotope $h$ relative to the boundary (so that the restriction to $f$ stays intact) to maps $h^0, h^1, h^2, ... , h^m = H$, where each map is $\lesssim L-$Lipschitz when restricted to the $j$-th skeleton of $(B^{m+1}, Tri_L)$ until we reach the $m$-th skeleton. The resulting map $h_m$ is the desired null-homotopy $H$.

There are several more key ingredients to the proof: 
1. At each skeleton we leverage knowledge about the corresponding homotopy group. We will quickly revise their definition and talk about homotopy groups of spheres.
2. CW-complexes, and, in particular, simplicial complexes are fibrations, i.e. they satisfy the homotopy extention property. We will briefly state what it means and prove this fact.

Before we proceed, let us adress some concerns one might have with this strategy:
<!------
concern section here? this one i can actually leave out completely. But I do need to explain why we focused on $m \lessthan n$ separately and reference the last theorem!!!
Homotopy groups, H.E.P., degree theory and relation to Lipschitz constants.
------->

Definition. Homotopy, relative homotopy. proof that lower homotopy groups are trivial. 
Definition. Fibration?

<!------
How much do I actually want to get into this?? I definitely want to explain the homotopy extension property because it's a big part of the proof. same goes for homotopy groups. they are the reason we can make the first skeleta simplicial and Sierre's theorem is the reason the proof works at all for higher skeleta. It is also the reason we are only considering n is odd.

it's important to mention somewhere that we have no geometric information about the map h. Hence, we cannot use simplicial approximation for it from thm whatever, and are forced to use the standard n+1 simplex to triangulate S^n, to ensure that edges are mapped to edges.
------->

## Homotoping skeleta up to n-1.
To recap, here is our setting: we are given a map $h$ between metric simplicial complexes $h: (B^{m+1}, Tri_L) \rightarrow (S^n, Tri_{S^n})$ (a null-homotopy for $f$), which is simplicial on the boundary, i.e. $h|_{\partial B^{m+1}} = f: (S^m, Tri_L) \rightarrow (S^n, Tri_{S^n})$ simplicial. We denote the skeleta of $(B^{m+1}, Tri_L)$ by $X^0 \subset X^1 \subset X^2 \dots \subset X^m \subset X^{m+1} = (B^{m+1}, Tri_L)$.  
Our goal for this section is to homotope $h$ to FINISH SENTENCE! Lipschitz constants!
### The zero-skeleton
We first aim to find a map $h^0$ that is simplicial on the 0-th skeleton. In order to do that we need to figure out where to map the vertices, i.e. to define a vertex map on $X^0$. This is a good moment to adress the choice of triangulation for $S^n$. If we could use some procedure similar to that of Theorem \ref{simp}, we could ensure that the neighboring vertices are mapped to the same simplex. But we triangulate $B^{m+1}$ without any knowledge of $h$, so $h$ could map vertices of a simplex anywhere in the target, no matter how fine of a triangulation we prescribe to $B^{m+1}$ at the beginning. Since we later want to build a simplicial map on the $1$-skeleton we cannot have the vertex map taking incident vertices of $Tri_L$ (i.e. vertices that share an edge) to non-incident vertices in the triangulated $S^n$. This forces us to choose a model complex where any pair of vertices share an edge. We also need the model simplicial complex to have the same dimension as the sphere. This makes the boundary of an $n+1$-simplex the unique choice of the model simplicial complex for the triangulation of the target sphere. The equilateral {n+1}-simplex has the most symmetry[^approximation] and was convinient for proof of \ref{simp}. From now on we will allow ourselves to write $B^{m+1}$, $S^n$ meaning the metric simplicial complexes $(B^{m+1}, Tri_L)$ and $(S^n, Tri_{S^n}) = \partial \Delta^{n+1}$ respectively.  
$h(X^0)$ is a disjoint set of points in $S^n$. For each of the points we choose a vertex of $S^n$ that is closest according to the metric it inherits from $\partial \Delta^{n+1}$ (the piece-wise straight line Euclidean length that restricts to Euclidean metric on each simplex). $S^n$ is path-connected, which gives a homotopy relative to the target vertex. To fit the more general framework, we could say that $\pi_0(S^n)=0$. We could even pick a straight-line homotopy to keep this procedure as deterministic as possible. Haveing fixed the vertex homotopies, we denote the union of the vertex homotopies together with the "constant" homotopy[^constant_homotopy] on the boundary sphere by $g^0: S^m \cup X^0 \times [0,1] \rightarrow \partial \Delta^{n+1}$. The starting map of the homotopy $g^0_0$ agrees with $h$, i.e. $h_{|\partial B^{m+1} \cup X^0} = g^0_0$. We extend $g^0$ to the whole ball using the homotopy extension property to obtain $\bar{g}^0$:
\begin{center}
    \begin{tikzcd}
        (S^m \cup X^0) \times [0,1] \bigcup_\{0\} B^{m+1} \times \{0\}
		\arrow[d, hook']
		\arrow[r, "g^0 \cup h"] 
			& \partial \Delta^{n+1} \\
		B^{m+1} \times [0,1]
		\arrow[ur, dashed, "\bar{g}^0"']
    \end{tikzcd}
\end{center}

$\bar{g}^0$ takes $h$ to $h^0:=\bar{g}^0_1$.

### The 1-skeleton
Let us explicitly do one more skeleton before stating the general version for the $k$-th skeleton. If $n=k=1$ we are done and we move on to the next section of the proof. Else $m \geq n>1$.
We start with the map $h^0: B^{m+1} \rightarrow \partial \Delta^{n+1}$, $h^0_{| X^0}$ is simplicial. 
Now, $h^0$ might take edges anywhere, only the end-points are prescribed. An edge image could wrap around $S^n$ multiple times, making the Lipschitz constant huge. We want to homotope all edges to straight edges relative endpoints (that is, using homotopies that fix endpoints for $\forall t$). We want to show that such homotopies exist using the fact that the fundamental group of the sphere $S^n$ is trivial, i.e. $\pi_1(S^n) = 1$ for $n>1$. 
Let $\sigma = [v0, v1]$ be a $1$-simplex in $B^{m+1}$, $e_1, e_2: \sigma \cong [0,1] \rightarrow S^n$ be two edges in $S^n$ that agree on the end-points (the images of vertices are determined by $h^0_{|X^0}$ and are not necessarily distinct in $S^n$). The edges we are interested in are $e_1:= h_0(\sigma)$ and $e_2$ - the simplicial image of $\sigma$, but we prove the claim for any two edges in $S^n$ that agree on the boundary. We give the simplex $\sigma$ an orientation from $v_0$ to $v_1$ (from $0$ to $1$ when viewed as the interval) and we denote by $-e_2$ the edge in the opposite direction. Then $e_1 \cup -e_2$ is a map from an oriented circle $S^1$ to $S^n$. Fixing $v_0$ as a basepoint makes $e_1 \cup -e_2$ into a representative of an element of the fundamental group $\pi_1(S^n)$, which is trivial because $n>1$. Now, this already shows us that the edges are homotopic relative $v_0$, but we want them to be homotopic relative both end-points. To fix this we homotope $e_2$ relative to boundary to a directed edge constant on the first and last third of the interval, and run through the entire $e_2$ in the middle. We can now homotope the point corresponding to $t=1/4$ to $e_1 \cup -e_2$ in the first third of the interval by what we have shown earlier. We now collapse $-e_2$ and $e_2$ and expand $e_1$ to the whole edge. All of these homotopies were done relative boundary.
SKETCH oriented $S^1$ gluing.

<!---
Okay , that's stupid, they always induce the same element because their domain is contractible. I either have to argue by quotienting the boundary out, or by gluing along the boundary. if i'm quotienting the boundary out i have to use the same homotopy for both. Then in the later argument I have to fix a null-homotopy for each representative map - I need that in both approaches though? I feel like gluing is cleaner because it is more obvious that it then does not depend on the chosen homotopy. But gluing requires dealing with orientation on the boundary.
------>

We define the homotopy $g^1$ on $X^1 \cup S^m$ - the union of edge homotopies relative the $0$-skeleton and the boundary sphere $S^m$ and extend it to the ball using the homotopy extension property:

\begin{center}
    \begin{tikzcd}
        (S^m \cup X^1) \times [0,1] \bigcup_\{0\} B^{m+1} \times \{0\}
		\arrow[d, hook']
		\arrow[r, "g^1 \cup h^0"] 
			& \partial \Delta^{n+1} \\
		B^{m+1} \times [0,1]
		\arrow[ur, dashed, "\bar{g}^1"']
    \end{tikzcd}
\end{center}

The $1$-end of the obtained homotopy $bar{g}^1_1$ is the desired map $h^1$. Its restriction to the $1$-skeleton, $h^1_{| X^1}$, is simplicial and therefore Lipschitz. The Lipschitz constant is $L/c(n)>L$ (strictly greater but up to a constant depending on $n$). It is worth noting that we have no interest in the geometry of the homotopy $\bar{g}^1$ between $h^0$ and $h^1$. In particular, we do not know if it is Lipschitz continuous, and it is completely irrelevant. We only construct that homotopy in order to construct the map $h^1$.

This finishes the discussion of the $1$-skeleton. Let us now repeat the argument in full generality.

### The $k$-th skeleton (for $k$ up to $n-1$)
We have constructed $h^{k-1}: B^{m+1} \rightarrow S^n$, which is the null-homotopy $S^m \times [0,1] \rightarrow S^n$, where $h^{k-1}_0 = f$ and $t$ is the radius of the unit ball. $h^{k-1}$ is simplicial on the $k-1$-skeleton $X^{k-1}$. We aim to construct $h^k$, which is simplicial on the $k$-th skeleton, $k \lessthan n$. This requires us to straighten out each $k$-simplex $\sigma^k$ of $B^{m+1}$ relative its boundary, i.e. to homotope $h^{k-1}_{|\sigma}$ to a simplicial map relative boundary. As before, we can do so because the $k$-th homotopy group of the target sphere, $\pi_k(S^n)$, is trivial and a pair of simplices that represent the same homotopy group element are homotopic relative boundary. The next lemma states this fact in full generality.

**Observation.**
Let $\lambda: \Delta^k \rightarrow S^n$, then its restriction to the boundary is null-homotopic. Fix a null-homotopy $H$. Quotienting out the boundary and its image descends to a map between spheres, $\bar{\lambda}$. Equipped with an orientation it represents an element of the homotopy group $\pi_k(S^n)$.

\begin{center}
    \begin{tikzcd}
        D^k
		\arrow[d]
		\arrow[r, "\lambda"]
			& S^n \\
		D^k / \partial D^k \arrow[ur, "\lambda \cup H"']
    \end{tikzcd}
\end{center}

Lemma (homotoping simplices relative boundary) \label{rel}.
: Let $\lambda_1, \lambda_2: D^k \rightarrow S^n$ be two maps that agree on the boundary $S^{k-1}$. Then the following are equivalent: 
: (i). The disk maps are homotopic relative boundary sphere, $\lambda_1 \simeq_\partial \lambda_2$
: (ii). Quotient maps over the boundary $\bar{\lambda_1}$, $\bar{\lambda_1}$ are in the same homotopy class of $\pi_k(S^n)$
: (iii). The difference $\lambda_1 \cup_\partial -\lambda_2$ is null-homotopic.

Proof.
: Clearly, $(i) \Rightarrow (ii)$ (collapse the boundary); $(i) \Rightarrow (iii)$ (homotope $\lambda_1$ to $\lambda_2$, then collapse $\lambda_2 \cup_\partial -\lambda_2$);
$(ii) \Rightarrow (i)$:  
Fix a null-homotopy $H$ of $\partial \Delta^k$ ($H_0 = Id$). Parametrize the disk $D^k$ by radius as cone of $S^{k-1}$. Shrink $\lambda$ to radius $1/2$, extend the rest to be the same as boundary, i.e. set $\lambda_{1|\partial} \forall r \in [1/2, 1]$. Collapse at $r=3/4$ and replace boundary mapping with $H$ for $r \in [1/2, 3/4]$, $-H$ for $r\in[3/4,1]$. For $r \in [0,3/4]$ the map is now $\lambda_2 \cup H$, homotope that part to $\lambda_2 \cup H$. Now collapse $H \cup -H$ to obtain $\lambda_2$. All homotopies were constructed relative boundary. SKETCH.
$(iii) \Rightarrow (i)$:  
Shrink $\lambda_1$ and collapse at $r=3/4$ as above, pasting in $- \lambda_2 \cup \lambda_2$ for $r \in [1/2, 1]$. For $r \in [0,3/4]$ the map collapses, leaving $\lambda_2$. SKETCH.

We have shown existence of homotopies of k-simplices to simplicial maps relative boundaries. We now construct the homotopy $g^k$ on $X^k \cup S^m$ as the union of those homotopies, relative $X^k \cup S^m$. We can extend it to the unit ball by the H.E.P.

\begin{center}
    \begin{tikzcd}
        (S^m \cup X^k) \times [0,1] \bigcup_{\{0\}} B^{m+1} \times \{0\}
		\arrow[d, hook']
		\arrow[r, "g^k \cup h^{k-1}"] 
			& \partial \Delta^{n+1} \\
		B^{m+1} \times [0,1]
		\arrow[ur, dashed, "\bar{g}^k"']
    \end{tikzcd}
\end{center}

We proceed this way until the $n-1$-st skeleton, constructing the desired map $h^{n-1}$. Its restriction to the $n-1$-st skeleton $X^{n-1}$ is simplicial and thus Lipschitz continuous with Lipschitz constant L.

## The n-skeleton
At the n-th skeleton we run into a problem if we try to proceed as before. Namely, degree.
We define relative degree (for the map $h^{n-1}$).

Definition (relative degree).

Intuition behind it, some pictures. The statement about relative to boundary and what would happen if we relaxed it.
We take that idea of unwrapping and run with it.

Claim.
: The difference of relative degrees is an integer. Two maps from n-simplices that agree on the boundary are homotopic rel boundary if and only if they have the same relative degree.
Proof.
: Glue the simplex maps in question along the boundary. $Deg(\lambda_1 \cup -\lambda_2)$ = the difference of relative degrees. The rest follows by Lemma \ref{rel}.

EQUAL AREA! we don't seem to actually need equal length anywhere, exceot maybe simlicial approximation.

Our aim from now on is not to make the map into a simplicial map, but rather to bound the degree.
What would happen if we managed to bound the degree with a constant that only depends on dimensions m,n?

representatives (ideally with a lower Lipschitz constant, but it can only be so low because degree implies it being quite high already)


What would we do if we knew we could limit the degree

Lemma (bounded relative degree).
: If there is an upper bound $A(m,n)$ for the relative degree of all maps $\Delta \rightarrow S^n$ then there is a map $h^n: (B^{m+1}, Tri_L) \rightarrow \partial \Delta^{n+1}$ that is Lipschitz with Lipschitz constant $\lesssim L$.

Proof. 
Our approach will be as always to homotope maps on simplices of $B^{m+1}$ to "controlled" maps relative $S^m \cup X^{n-1}$, then extend those homotopies to the whole ball, obtaining a homotopy $\bar(g)^n$ between maps $h^{n-1}$ and $h^n$. The main difference is that this time the "controlled" maps are not (in general) simplicial, but merely some fixed maps of a given degree:  
For each relative degree we choose a representative map. We can show preference for maps with a lower Lipschitz constant, but we can also choose completely arbitrary Lipschitz maps. We merely have to ensure the existence of Lipschitz maps for each relative degree (agrue why they exist). Now let A be the maximum over all Lipschitz constants of the representative maps. Then the map $h^n$ we aim to contruct will have Lipschitz constant $\lesssim AL$ (with the approximation coming from $\psi^n(L)$ - the maximum Lipschitz constant of homeomorhisms $\Delta^{n} \rightarrow \sigma$, where $\sigma \textrm{ is an } n \textrm{ simplex in } Tri_L$). BAD NOTATION - I need to figure out names for those constants and put them in a diagram.

The rest of this section, most of the rest of this chapter will be dedicated to showing that we can indeed bound the relative degree.
We will do so by first viewing relative degrees in the context of cohomology, and then more specifically - DeRham cohomology.

The idea of unwrapping, relative degree of a prism. 

I want to demontsrate the unwrapping idea for $S^1$. With specific degrees.

Essentially, this amounts to saying that the number of times we unwrap the simplex is 

### Higher dimensional skeleta
#### The n+1-st skeleton
We know that $h^n$ restricted to an $n$-simplex comes from a finite list of maps that are simplicial on the boundary of $\partial \Delta^n$. It suffices to only consider maps that agree with one selected simplex of $S^n = \partial \Delta ^ {n+1}$, considering a different simplex would be the same up to rotation. So really the size of our list here is the possible values of relative degree of such maps.  
Now, we want to consider a map from an n+1-simplex of $B^{m+1}$. The restriction to its boundary $h^n_{| \partial \Delta^{n+1} }$ comes from a finite list of maps. For each of the maps $g_a$ that agree with it on the boundary, the gluing at the equator $h^n_{|\Delta^{n+1}} \cup -g_a: S^{n+1} \rightarrow S^n$ represents an element of $\pi_{n+1}(S^n)$. The homotopy group is finite, meaning we only need $|\pi_{n+1}(S^n)|$ many maps that agree with $h^n_{|\Delta^{n+1}}$ on the boundary to guarantee that there is a $g_a$ such that $h^n_{|\Delta^{n+1}} \cup -g_a$ maps to zero in the homotopy group. Then by Lemma \ref{rel} the two maps are homotopic rel boundary, and we can homotope $h^n_{|\Delta^{n+1}}$ to a map with a controlled Lipschitz constant from a finite pre-determined list of maps. The usual H.E.P. procedure yields the desired map $h^{n+1}$ that is $\lesssim L$-Lipschitz on the {n+1}-skeleton.

#### The general case
Suppose we have $h^{k-1}$, where $k-1 \geq n+1$. $h^{k-1}$ restricted to a ${k-1}$-simplex comes from a finite list of maps. Thus, $h^{k-1}_{|\partial \Delta^k}$ comes from a finite list of maps. The $k$-th homotopy group $\pi_k(S^n)$ is also finite, meaning for each boundary mapping there are only finitely many fixed maps we need to present to choose from (multiplying the cardinalities determines the size of the new list of maps). Each of the maps on the list we select as before, aiming to minimize the Lipschitz constant. The usual procedure yields $h^{k}: B^{m+1} \rightarrow S^n$ that is Lipschitz on the $k$-skeleton with Lipschitz constant $\lesssim L$. When $k$ equals $m+1$ this finishes the main proof.

## Estimates for extensions and primitives
<!----
Don't forget the Q.E.D. sign :)
---->

[^constant_homotopy]: By "constant" we mean the homotopy that does not change over time, $g^0_{0|S^m}=g^0_{t|S^m}=f$ for $\forall t \in [0,1]$. It is also sometimes called the "trivial" homotopy.



[^approximation]: As mentioned before, symmetry of the triangulation will be important to us later on. We will address it explicitly later in the proof why we would like the target to have equilateral simplices of equal area.


