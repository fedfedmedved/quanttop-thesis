# n is odd theorem
Theorem ([CDMW]). Suppose that n is odd and $f: S^m \rightarrow S^n$ is a null-homotopic map with Lipschitz constant L. Then there is a null-homotopy $H: S^m \times [0,1] \rightarrow S^n with Lipschitz constant at most C(m,n)L.

The approach they take in this proof is as follows:
Here are some preparatory steps for the proof:

1. We first take a simplicial approximation of the map f (ref Lemma 1.5). The simplicial approximation is still null-homotopic:
cylinder composed with the cone picture here.
Therefore in the proof we can directly start with a simplicial map of the sphere.
2. A null-homotopy from an arbitrary space X can be described as a map from the Cone of X to the target. Recall that the cone of X is simply the cyllinder of X with one end collapsed to a point: $X \times [0,1] / X \times \{0\}$. Cone of $S^m$ is homeomorphic to the unit ball $B^{m+1}$. To see this, think of radius of the ball as the variable for the interval. (picture for $S^1$).
3. We endow $B^{m+1}$ with a simplicial structure $Tri_L$ using the procedure from blibla. 

We now have the following setup: we are given a map $h: B^{m+1} \rightarrow S^n$ (the default null-homotopy for f) with $h_{| \partial B^{m+1}} \rightarrow S^n$ simplicial with Lipschitz constant L (our map f).

Our strategy for the proof is to "straighten out" h skeleton by skeleton: we iteratively homotope $h$ relative to the boundary (so that the restriction to f stays intact) to maps $h_0, h_1, h_2, ... , h_m = H$, where each map is $\lesssim L-$Lipschitz when restricted to the $j$-th skeleton of $(B^{m+1}, Tri_L)$ until we reach the m-th skeleton. The resulting map $h_m$ is the desired homotopy $H$.

There are several more key ingredients to the proof: 
1. At each skeleton we leverage knowledge about the corresponding homotopy group. We will quickly revise their definition and talk about homotopy groups of spheres.
2. CW-complexes, and, in particular, simplicial complexes satisfy are fibrations, i.e. they satisfy the homotopy extention property. We will briefly state what it means and prove this fact.

Before we proceed, let us adress some concerns one might have with this strategy:
<!------
concern section here? this one i can actually leave out completely.
Homotopy groups, H.E.P., degree theory and relation to Lipschitz constants.
------->

Definition. Homotopy, relative homotopy. proof that lower homotopy groups are trivial. 
Definition. Fibration?

<!------
How much do I actually want to get into this?? I definitely want to explain the homotopy extension property because it's a big part of the proof. same goes for homotopy groups. they are the reason we can make the first skeleta simplicial and Sierre's theorem is the reason the proof works at all for higher skeleta. It is also the reason we are only considering n is odd.

it's important to mention somewhere that we have no geometric information about the map h. Hence, we cannot use simplicial approximation for it from thm whatever, and are forced to use the standard n+1 simplex to triangulate S^n, to ensure that edges are mapped to edges.
------->

Proof.
To recap, here is our setting: we are given a map $h: B^{m+1} \rightarrow S^n$ (a null-homotopy for $f$), which is simplicial, when restricted to the boundary, i.e. $h|_{\partial B^{m+1}} = f: (S^m, Tri_L) \rightarrow (S^n, Tri_{S^n})$ simplicial. We denote the skeleta of the simplicial complex $B^{m+1}$ by $X^0 \subset X^1 \subset X^2 \dots \subset X^m \subset X^{m+1} = B^{m+1}$.  
We first aim to find a map h_0 that is simplicial on the 0-th skeleton. For that we need to figure out where to map the vertices of $Tri_L$. If we could use some procedure similar to that of Theorem REFERENCE simplicial] we could ensure that the neighboring vertices are mapped to the same simplex. But we triangulate $B^{m+1}$ without any knowledge of $h$, so $h$ could map vertices of a simplex anywhere in the target, no matter how fine of a triangulation we prescribe to $B^{m+1}$ at the beginning. Since we later want to build a simplicial map on the 1-skeleton we need edges to map to edges, which forces us to choose the boundary of a standard simplex as triangulation of the target.[^approximation]  
h(X^0) is a disjoint set of points in S^n. For each of the points we choose a vertex of $Tri_{S^n}$ that is closest according to the surface metric. S^n is path-connected, which gives a homotopy relative to the vertex. To fit the more general framework, we could say that $\pi_0(S^n)=0$. We could even pick a straight-line homotopy by taking geodesics to keep this procedure as deterministic as possible. Having fixed the homotopies we use the homotopy extension property to obtain the homotopy $g^0$:
\begin{center}
    \begin{tikzcd}
        X^0 \times [0,1] \cup B^{m+1} \times \{0\}
		\arrow[d, hook']
		\arrow[r, "label"] 
			& S^n \\
		B^{m+1} \times [0,1]
		\arrow[ur, dashed, "g"]
    \end{tikzcd}
\end{center}  


[^approximation]: There are other reasons which make this choice of triangulation of the target especially convinient. Namely, later in the proof we would like the target to have equilateral simplices of equal area.


