# Abstract {-}

High-dimensional data are increasingly common across many scientific fields, driven by advances in data collection technologies. However, visualizing and interpreting such data pose significant challenges due to the difficulty of perceiving structures beyond two dimensions. Dimension reduction methods are widely used to create visual summaries of high-dimensional data. While linear approaches such as principal component analysis are effective for simple structures, they often fail to capture complex, nonlinear relationships. Nonlinear dimension reduction (NLDR) techniques address this limitation by applying nonlinear transformations to produce low-dimensional representations that reveal intricate patterns within the data. However, NLDR methods vary in how they distort or preserve structure, and their results can be misleading without appropriate diagnostic tools. However, the effectiveness of NLDR methods can vary depending on the chosen method and hyper-parameters, often resulting in representations that differ widely in accuracy and can be misleading without proper diagnostic tools. The main objective of this research is to develop new methods and software tools to diagnose, evaluate, and interpret NLDR results in relation to the true high-dimensional data structure.

This research presents five original contributions. The first contribution ([Chapter 2](#sec-first-paper)) introduces a new method for visualizing how NLDR warps data. This method improves the diagnostics of NLDR techniques. The second contribution ([Chapter 3](#sec-third-paper)) involves implementing the method introduced in [Chapter 2](#sec-first-paper) as an R package, `quollr`. The third contribution ([Chapter 4](#sec-fourth-paper)) introduces an R package, `cardinalR` designed to generate high-dimensional clustering data structures, with features such as adding noise dimensions and background noise. The fourth contribution ([Chapter 5](#sec-second-paper)) provides evidence in identification of clusters at various distances when observing NLDR representation and the tour view of high-dimensional data. This finding is based on a human subject experiment that explores both the perception and misperception of NLDR representations. Finally, the fifth contribution ([Chapter 6](#sec-fifth-paper)) provides a Shiny app that offers a user-friendly interface for analysts to obtain the most accurate NLDR representation. Overall, this work advances the field of diagnosing NLDR by improving the visualization of high-dimensional data.

# Declaration {-}

I hereby declare that this thesis contains no material which has been accepted for the award of any other degree or diploma at any university or equivalent institution and that, to the best of my knowledge and belief, this thesis contains no material previously published or written by another person, except where due reference is made in the text of the thesis.

This thesis includes one original papers published in a peer reviewed journal and four unpublished papers. The core theme of the thesis is to "develop methods and software to evaluate and understand non-linear dimension reduction methods". The ideas, development and writing up of all the papers in the thesis were the principal responsibility of myself, the student, working within the Department of Econometrics and Business Statistics under the supervision of Professor Dianne Cook, Dr Paul Harrison (MGBP, BDInstitute), Dr Michael Lydeamore, and Dr Thiyanga S. Talagala (University of Sri Jayewardenepura).

The inclusion of co-authors reflects the fact that the work came from active collaboration between researchers and acknowledges input into team-based research. In the case of [Chapter 2](#sec-first-paper), [Chapter 3](#sec-third-paper), [Chapter 4](#sec-fourth-paper), and, [Chapter 6](#sec-fifth-paper), my contribution to the work involved the following:


::: {.cell}
::: {.cell-output-display}
`````{=html}
<table class="table" style="font-size: 10px; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:right;font-weight: bold;text-align: left;"> Chapter </th>
   <th style="text-align:left;font-weight: bold;text-align: left;"> Publication title </th>
   <th style="text-align:left;font-weight: bold;text-align: left;"> Status </th>
   <th style="text-align:left;font-weight: bold;text-align: left;"> Student contribution </th>
   <th style="text-align:left;font-weight: bold;text-align: left;"> Co-authors contribution </th>
   <th style="text-align:left;font-weight: bold;text-align: left;"> Coauthors are Monash students </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;width: 1.2cm; "> 2 </td>
   <td style="text-align:left;width: 3cm; ">  </td>
   <td style="text-align:left;width: 3.5cm; "> Revised and resubmitted in the Journal of Computational and Graphical Statistics </td>
   <td style="text-align:left;width: 2.5cm; "> 80%  Concept, Analysis, Software, Writing </td>
   <td style="text-align:left;width: 2.4cm; ">  </td>
   <td style="text-align:left;width: 1.3cm; "> No </td>
  </tr>
  <tr>
   <td style="text-align:right;width: 1.2cm; "> 3 </td>
   <td style="text-align:left;width: 3cm; ">  </td>
   <td style="text-align:left;width: 3.5cm; "> Submitted in the R Journal </td>
   <td style="text-align:left;width: 2.5cm; "> 80%  Concept, Analysis, Software, Writing </td>
   <td style="text-align:left;width: 2.4cm; ">  </td>
   <td style="text-align:left;width: 1.3cm; "> No </td>
  </tr>
  <tr>
   <td style="text-align:right;width: 1.2cm; "> 4 </td>
   <td style="text-align:left;width: 3cm; ">  </td>
   <td style="text-align:left;width: 3.5cm; "> Submitted in the R Journal </td>
   <td style="text-align:left;width: 2.5cm; "> 80%  Concept, Analysis, Software, Writing </td>
   <td style="text-align:left;width: 2.4cm; ">  </td>
   <td style="text-align:left;width: 1.3cm; "> No </td>
  </tr>
  <tr>
   <td style="text-align:right;width: 1.2cm; "> 6 </td>
   <td style="text-align:left;width: 3cm; ">  </td>
   <td style="text-align:left;width: 3.5cm; "> Submitted in the Oxford Academic (Bioinformatics Advances) </td>
   <td style="text-align:left;width: 2.5cm; "> 80%  Concept, Analysis, Software, Writing </td>
   <td style="text-align:left;width: 2.4cm; ">  </td>
   <td style="text-align:left;width: 1.3cm; "> No </td>
  </tr>
</tbody>
</table>

`````
:::
:::



Chapters 3 is planned for submission to peer-reviewed journal.

\clearpage

To ensure the clarity and coherence of the written content, artificial intelligence tools were employed to assist in smoothing and refining the language throughout the thesis.

<!-- **The thesis is written in Australian spelling, except for Chapters 3 and 4, which use American spelling as specified by the publication venue.** -->

<!-- The thesis is written in Australian spelling, except for Chapters $2$, $4$, $5$, and $6$, which use American spelling as specified by the publication venues. -->

This thesis uses American spelling, as that’s the style followed by the journals where the work will be submitted or published.

I have renumbered sections of submitted papers in order to generate a consistent presentation within the thesis. 

**Student name**: Piyadi Gamage Jayani Lakshika

**Student signature**: 

**Date**: 13th January 2026 

I hereby certify that the above declaration correctly reflects the nature and extent of the student’s and co-authors’ contributions to this work. In instances where I am not the responsible author I have consulted with the responsible author to agree on the respective contributions of the authors.

**Main Supervisor name**: Dianne Cook

**Main Supervisor signature**:

**Date**: 13th January 2026
