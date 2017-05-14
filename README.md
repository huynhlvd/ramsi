RAMSI Algorithm and Performance Guarantees
-----------------------------------------------------------------------
       Version 1.1, Mar. 6, 2016
       Implementations by Huynh Van Luong, Email: huynh.luong@fau.de
       Please see the file LICENSE for the full text of the license.
-----------------------------------------------------------------------

I. Reconstruction Algorithm with Multiple Side Information (RAMSI) [1]

    PUBLICATION: H. V. Luong, J. Seiler, A. Kaup, and S. Forchhammer, 
          "A Reconstruction Algorithm with Multiple Side Information for Distributed Compression of Sparse Sources," 
           in Data Compression Conference 2016 (DCC 2016), Snowbird, Utah, Apr. 2016.


            Solving the n-l1 minimization problem:
                     min ∑j Wj || x - zj ||1   subject to  Ax = b, 

                     where b ∈ Rm x 1,  A ∈ Rm x n,  x, zj ∈ Rn x 1, Wj = diag(n), wij (∈ Wj) > 0.
   The main files are:    
       - ramsi.m: The function for RAMSI.
       - usageDemo.m: One demo to run RAMSI. Some simple changes may be made to each of these files to get them to run on your machine. 
       
II. Measurement Bounds for Weighted n-l1 Minimization [2]

            The main files are:    
	            */nl1Bound.m: The function for computing measurement bounds.
	            */usageDemo.m: One demo to run the nl1Bound function. 


            PUBLICATION: H. V. Luong, J. Seiler, A. Kaup, S. Forchhammer, and N. Deligiannis, 
                "Measurement Bounds for Sparse Signal Recovery with Multiple Side Information," 
                 in e-print, arXiv, Jan. 2017.

            Computing the measurement bound m, which is required for successful reconstruction, for the weighted n-l1 minimization problem:
                     minx {1/2 ||Ax - b ||22  +  lambda ∑j Wj || x - zj ||1},

                     where measurements b =  Ax ∈ Rm x 1,  A ∈ Rm x n,  x, zj ∈ Rn x 1, Wj = diag(n), wij (∈ Wj) > 0.
