RAMSI Algorithm and Performance Guarantees
-----------------------------------------------------------------------
    Version 1.1, Mar. 6, 2016
    Implementations by Huynh Van Luong, Email: huynh.luong@fau.de
    Please see the file LICENSE for the full text of the license.
-----------------------------------------------------------------------

**I. Reconstruction Algorithm with Multiple Side Information (RAMSI)**

    PUBLICATION: H. V. Luong, J. Seiler, A. Kaup, and S. Forchhammer, "A Reconstruction Algorithm with 
    	Multiple Side Information for Distributed Compression of Sparse Sources," in Data Compression 
    	Conference 2016 (DCC 2016), Snowbird, Utah, Apr. 2016.

  Solving the minimization problem:
  
<img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\min_{\boldsymbol{x}}\Big\{H(\boldsymbol{x})=&space;\frac{1}{2}\|\mathbf{\Phi}\boldsymbol{x}-\boldsymbol{y}\|^{2}_{2}&space;&plus;&space;\lambda&space;\sum\limits_{j=0}^{J}\|\mathbf{W}_{j}(\boldsymbol{x}-\boldsymbol{z}_{j})\|_{1}\Big\}" title="\min_{\boldsymbol{x}}\Big\{H(\boldsymbol{x})= \frac{1}{2}\|\mathbf{\Phi}\boldsymbol{x}-\boldsymbol{y}\|^{2}_{2} + \lambda \sum\limits_{j=0}^{J}\|\mathbf{W}_{j}(\boldsymbol{x}-\boldsymbol{z}_{j})\|_{1}\Big\}" />

Inputs:
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\boldsymbol{y}_{t}\in&space;\mathbb{R}^{m}" title="\boldsymbol{y}_{t}\in \mathbb{R}^{m}" />: A vector of observations/data <br /> 
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\mathbf{\Phi}\in&space;\mathbb{R}^{m\times&space;n}" title="\mathbf{\Phi}\in \mathbb{R}^{m\times n}" />: A measurement matrix <br />
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\boldsymbol{z}_{j}\in&space;\mathbb{R}^{m}" title="\boldsymbol{y}_{t}\in \mathbb{R}^{m}" />: The foreground prior <br />
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\boldsymbol{B}_{t}\in&space;\mathbb{R}^{n\times&space;d}" title="\boldsymbol{B}_{t-1}\in \mathbb{R}^{n\times d}" />: A matrix of the background prior, which could be initialized by previous backgrounds <br />

Outputs:
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\boldsymbol{x}_{t},\boldsymbol{v}_{t}\in\mathbb{R}^{n}" title="\boldsymbol{x}_{t},\boldsymbol{v}_{t}\in\mathbb{R}^{n}" />: Estimates of foreground and background
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\boldsymbol{Z}_{t}:=\{\boldsymbol{z}_{j}=\boldsymbol{x}_{t-J&plus;j}\}" title="\boldsymbol{Z}_{t}:=\{\boldsymbol{z}_{j}=\boldsymbol{x}_{t-J+j}\}" />: The updated foreground prior
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\boldsymbol{B}_{t}\in&space;\mathbb{R}^{n\times&space;d}" title="\boldsymbol{B}_{t}\in \mathbb{R}^{n\times d}" />: The updated background prior

Main source code files are:  
 
     - ramsi.m: The function for RAMSI.
     - usageDemo.m: One demo to run RAMSI. 
     
**II. Measurement Bounds for Weighted n-l1 Minimization**

            The main files are:    
	            */nl1Bound.m: The function for computing measurement bounds.
	            */usageDemo.m: One demo to run the nl1Bound function. 


            PUBLICATION: H. V. Luong, J. Seiler, A. Kaup, S. Forchhammer, and N. Deligiannis, 
                "Measurement Bounds for Sparse Signal Recovery with Multiple Side Information," 
                 in e-print, arXiv, Jan. 2017.

            Computing the measurement bound m, which is required for successful reconstruction, for the weighted n-l1 minimization problem:
                     minx {1/2 ||Ax - b ||22  +  lambda ∑j Wj || x - zj ||1},

                     where measurements b =  Ax ∈ Rm x 1,  A ∈ Rm x n,  x, zj ∈ Rn x 1, Wj = diag(n), wij (∈ Wj) > 0.
