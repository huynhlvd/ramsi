# RAMSI Algorithm and Performance Guarantees

        Version 1.1, Mar. 6, 2016
        Implementations by Huynh Van Luong, Email: huynh.luong@fau.de
        Multimedia Communications and Signal Processing, University of Erlangen-Nuremberg.
        
        Please see the file LICENSE for the full text of the license.

**I. Reconstruction Algorithm with Multiple Side Information (RAMSI)**

Please cite this publication

    PUBLICATION: H. V. Luong, J. Seiler, A. Kaup, and S. Forchhammer, "A Reconstruction Algorithm with 
    	Multiple Side Information for Distributed Compression of Sparse Sources," in Data Compression 
    	Conference 2016 (DCC 2016), Snowbird, Utah, Apr. 2016.

  **_Solving the _n-l1_ minimization problem:_**
  
<img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\min_{\boldsymbol{x}}\Big\{H(\boldsymbol{x})=&space;\frac{1}{2}\|\mathbf{\Phi}\boldsymbol{x}-\boldsymbol{y}\|^{2}_{2}&space;&plus;&space;\lambda&space;\sum\limits_{j=0}^{J}\|\mathbf{W}_{j}(\boldsymbol{x}-\boldsymbol{z}_{j})\|_{1}\Big\}" title="\min_{\boldsymbol{x}}\Big\{H(\boldsymbol{x})= \frac{1}{2}\|\mathbf{\Phi}\boldsymbol{x}-\boldsymbol{y}\|^{2}_{2} + \lambda \sum\limits_{j=0}^{J}\|\mathbf{W}_{j}(\boldsymbol{x}-\boldsymbol{z}_{j})\|_{1}\Big\}"  /> (1)

Inputs:
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\boldsymbol{y}\in&space;\mathbb{R}^{m}" title="\boldsymbol{y}_{t}\in \mathbb{R}^{m}" />: A vector of observations/data <br /> 
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\mathbf{\Phi}\in&space;\mathbb{R}^{m\times&space;n}" title="\mathbf{\Phi}\in \mathbb{R}^{m\times n}" />: A measurement matrix <br />
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\boldsymbol{z}_{j}\in&space;\mathbb{R}^{n}" title="\boldsymbol{y}_{t}\in \mathbb{R}^{m}" />: Multiple side information signals <br />

Outputs:
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\boldsymbol{\hat{x}}\in\mathbb{R}^{n}" title="\boldsymbol{x}_{t},\boldsymbol{v}_{t}\in\mathbb{R}^{n}" />: The recovered source 

**_Source code files:_**  
 - `ramsi.m`: The function for RAMSI
 - `usageDemo_ramsi.m`: One demo to run RAMSI

**II. Measurement Bounds for Weighted n-l1 Minimization**

Please cite this publication

    PUBLICATION: H. V. Luong, J. Seiler, A. Kaup, S. Forchhammer, and N. Deligiannis, 
          "Measurement Bounds for Sparse Signal Recovery with Multiple Side Information," 
           in e-print, arXiv, Jan. 2017.

**_Computing the measurement bound m, which is required for successful reconstruction, for the weighted n-l1 minimization problem in (1)._**
                     
**_Source code files:_**    
- `nl1Bound.m`: The function for computing measurement bounds
- `usageDemo_nl1Bound.m`: One demo to run the nl1Bound function
