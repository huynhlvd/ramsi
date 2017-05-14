RAMSI Algorithm and Performance Guarantees
-----------------------------------------------------------------------
    Version 1.1, Mar. 6, 2016
    Implementations by Huynh Van Luong, Email: huynh.luong@fau.de
    Please see the file LICENSE for the full text of the license.
-----------------------------------------------------------------------

I. Reconstruction Algorithm with Multiple Side Information (RAMSI)

    PUBLICATION: H. V. Luong, J. Seiler, A. Kaup, and S. Forchhammer, "A Reconstruction Algorithm with 
    	Multiple Side Information for Distributed Compression of Sparse Sources," in Data Compression 
    	Conference 2016 (DCC 2016), Snowbird, Utah, Apr. 2016.

  Solving the minimization problem:
  
<img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\min_{\boldsymbol{x}}\Big\{H(\boldsymbol{x})=&space;\frac{1}{2}\|\mathbf{\Phi}\boldsymbol{x}-\boldsymbol{y}\|^{2}_{2}&space;&plus;&space;\lambda&space;\sum\limits_{j=0}^{J}\|\mathbf{W}_{j}(\boldsymbol{x}-\boldsymbol{z}_{j})\|_{1}\Big\}" title="\min_{\boldsymbol{x}}\Big\{H(\boldsymbol{x})= \frac{1}{2}\|\mathbf{\Phi}\boldsymbol{x}-\boldsymbol{y}\|^{2}_{2} + \lambda \sum\limits_{j=0}^{J}\|\mathbf{W}_{j}(\boldsymbol{x}-\boldsymbol{z}_{j})\|_{1}\Big\}" />, 
        	where b ∈ Rm x 1,  A ∈ Rm x n,  x, zj ∈ Rn x 1, Wj = diag(n), wij (∈ Wj) > 0.
		
 The main files are:  
 
     - ramsi.m: The function for RAMSI.
     - usageDemo.m: One demo to run RAMSI. 
       
II. Measurement Bounds for Weighted n-l1 Minimization

            The main files are:    
	            */nl1Bound.m: The function for computing measurement bounds.
	            */usageDemo.m: One demo to run the nl1Bound function. 


            PUBLICATION: H. V. Luong, J. Seiler, A. Kaup, S. Forchhammer, and N. Deligiannis, 
                "Measurement Bounds for Sparse Signal Recovery with Multiple Side Information," 
                 in e-print, arXiv, Jan. 2017.

            Computing the measurement bound m, which is required for successful reconstruction, for the weighted n-l1 minimization problem:
                     minx {1/2 ||Ax - b ||22  +  lambda ∑j Wj || x - zj ||1},

                     where measurements b =  Ax ∈ Rm x 1,  A ∈ Rm x n,  x, zj ∈ Rn x 1, Wj = diag(n), wij (∈ Wj) > 0.
