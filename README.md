# RAMSI Algorithm and Performance Guarantees

        Version 1.1, Mar. 6, 2016
        Implementations by Huynh Van Luong, Email: huynh.luong@fau.de
        Multimedia Communications and Signal Processing, University of Erlangen-Nuremberg.
        
   `Please see` [LICENSE](https://github.com/huynhlvd/ramsi/blob/master/LICENSE.md) `for the full text of the license.`

**I. Reconstruction Algorithm with Multiple Side Information (RAMSI)**

Please cite this publication:

`H. V. Luong, J. Seiler, A. Kaup, and S. Forchhammer, "`[A Reconstruction Algorithm with Multiple Side Information for Distributed Compression of Sparse Sources](http://ieeexplore.ieee.org/document/7786164/)`," in Data Compression Conference 2016 (DCC 2016), Snowbird, Utah, Apr. 2016.`

  **_Solving the _n-l1_ minimization problem:_**
  
<img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\min_{\boldsymbol{x}}\Big\{H(\boldsymbol{x})=&space;\frac{1}{2}\|\mathbf{\Phi}\boldsymbol{x}-\boldsymbol{y}\|^{2}_{2}&space;&plus;&space;\lambda&space;\sum\limits_{j=0}^{J}\|\mathbf{W}_{j}(\boldsymbol{x}-\boldsymbol{z}_{j})\|_{1}\Big\}" title="\min_{\boldsymbol{x}}\Big\{H(\boldsymbol{x})= \frac{1}{2}\|\mathbf{\Phi}\boldsymbol{x}-\boldsymbol{y}\|^{2}_{2} + \lambda \sum\limits_{j=0}^{J}\|\mathbf{W}_{j}(\boldsymbol{x}-\boldsymbol{z}_{j})\|_{1}\Big\}"  /> (1)

Inputs:
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\boldsymbol{y}\in&space;\mathbb{R}^{m}" title="\boldsymbol{y}_{t}\in \mathbb{R}^{m}" />: A vector of observations/data <br /> 
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\mathbf{\Phi}\in&space;\mathbb{R}^{m\times&space;n}" title="\mathbf{\Phi}\in \mathbb{R}^{m\times n}" />: A measurement matrix <br />
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\boldsymbol{z}_{j}\in&space;\mathbb{R}^{n}" title="\boldsymbol{y}_{t}\in \mathbb{R}^{m}" />: Multiple side information signals <br />

Outputs:
- <img src="https://latex.codecogs.com/svg.latex?\dpi{150}&space;\boldsymbol{\hat{x}}\in\mathbb{R}^{n}" title="\boldsymbol{x}_{t},\boldsymbol{v}_{t}\in\mathbb{R}^{n}" />: The recovered source 

**_Source code files:_**  
 - [ramsi.m](https://github.com/huynhlvd/ramsi/blob/master/ramsi.m): The function for RAMSI
 - [usageDemo_ramsi.m](https://github.com/huynhlvd/ramsi/blob/master/usageDemo_ramsi.m): One demo to run RAMSI

**II. Measurement Bounds for Weighted n-l1 Minimization**

Please cite this publication:

`H. V. Luong, J. Seiler, A. Kaup, S. Forchhammer, and N. Deligiannis, "`[Sparse Signal Recovery with Multiple Prior Information: Algorithm and Measurement Bounds](https://doi.org/10.1016/j.sigpro.2018.06.019)`," Signal Processing, vol. 152, pp. 417-428, Nov. 2018.`

**_Computing the measurement bound m, which is required for successful reconstruction, for the weighted n-l1 minimization problem in (1)._**

<img src="https://latex.codecogs.com/svg.latex?m_{n\text{-}\ell_{1}}\geq&space;2\bar{a}_{n\text{-}\ell_{1}}&space;\log\frac{n}{\bar{s}_{n\text{-}\ell_{1}}}\hspace{-1pt}&plus;\hspace{-1pt}&space;\frac{7}{5}&space;\bar{s}_{n\text{-}\ell_{1}}\hspace{-1pt}&plus;\delta_{n\text{-}\ell_{1}}&plus;1" title="m_{n\text{-}\ell_{1}}\geq 2\bar{a}_{n\text{-}\ell_{1}} \log\frac{n}{\bar{s}_{n\text{-}\ell_{1}}}\hspace{-1pt}+\hspace{-1pt} \frac{7}{5} \bar{s}_{n\text{-}\ell_{1}}\hspace{-1pt}+\delta_{n\text{-}\ell_{1}}+1" />
 
 (For details, please refer to the above reference)
 
**_Source code files:_**    
- [nl1Bound.m](https://github.com/huynhlvd/ramsi/blob/master/nl1Bound.m): The function for computing measurement bounds
- [usageDemo_nl1Bound.m](https://github.com/huynhlvd/ramsi/blob/master/usageDemo_nl1Bound.m): One demo to run the nl1Bound function
