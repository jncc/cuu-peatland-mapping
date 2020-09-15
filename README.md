
[<img src="logos.png">](https://jncc.gov.uk/our-work/copernicus-project/)

<p> 

# 'cuu-peatland-mapping'

This R code was developed by JNCC under the Copernicus User Uptake Work Package 6 projects focussing on Mapping Peatland Condition. It calls from functions from the [habitat-condition-monitoring](https://github.com/jncc/habitat-condition-monitoring) package, which contains various functions involved in the preparation, statistical analysis and modelling with Sentinel-1 and Sentinel-2 data.
<p>

Building on a previous [JNCC pilot study](https://github.com/jncc/bare-peat-mapping-pilot), this project is exploring the use of EO to map changes in peatland condition over time. Focussing on sites across England, Scotland and Wales, the project will use high-resolution imagery to create fine-scale maps of areas of bare unvegetated peat, indicating poor condition. Through regression modelling, these maps will then be scaled up using a time series of Sentinel-2 optical imagery to estimate the amount of bare peat cover over a wider region and explore how this has changed over time. The project will investigate how we can remotely monitor the condition of these important ecosystems, informing ground operations for restoration and the design of monitoring schemes.

<p> 

## Site documentation

The markdown documentation walkthroughs the process of deriving the zonal statistics for each of the sites, using the Sentinel imagery from the studied time period and a spatial framework of polygons used to study change. 

### Fine-scale mapping

* FR_CES_Fine.Rmd - Caithness and East Sutherland, Scotland
* NE_DarkPeak_Fine.Rmd - Dark Peak, England
* NE_Humberhead_Fine.Rmd - Humberhead NNR, England
* WG_Brecon_Fine.Rmd - Brecon Beacons, Wales

### Time Series Modelling

* FR_CES_Broad.Rmd - Caithness and East Sutherland, Scotland
* NE_DarkPeak_Broad.Rmd -  Dark Peak, England
* NE_Humberhead_Broad.Rmd - Humberhead NNR, England
* WG_Brecon_Broad.Rmd - Brecon Beacons, Wales
